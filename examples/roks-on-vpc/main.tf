locals {
  worker_zones = { for subnet in data.ibm_is_subnet.subnets : subnet.zone => { "subnet_id" = subnet.id } }

  kms_config = [{
    instance_id      = module.kms.kms_instance_guid
    crk_id           = module.kms.kms_key_id
    private_endpoint = false
    },
  ]
}

##############################################################################
# Resource Group
##############################################################################

data ibm_resource_group resource_group {
  name = var.resource_group
}

##############################################################################

##############################################################################
# VPC Data
#############################################################################

data ibm_is_vpc vpc {
  name = var.vpc_name
}

#############################################################################
# Get Subnet Data
# > If the subnets cannot all be gotten by name, replace the `name`
#   field with the `identifier` field and get the subnets by ID instead
#   of by name.
#############################################################################

data ibm_is_subnet subnets {
  count = length(var.subnet_names)
  name  = var.subnet_names[count.index]
}

##############################################################################
# KMS
##############################################################################

module kms {
  source = "terraform-ibm-modules/kms/ibm//modules/key-protect"

  is_kp_instance_exist   = false
  resource_group_id      = data.ibm_resource_group.resource_group.id
  service_name           = var.service_name
  location               = var.location
  plan                   = "tiered-pricing"
  tags                   = var.kms_tags
  allowed_network_policy = var.allowed_network_policy
  key_name               = var.key_name
  standard_key_type      = var.standard_key_type
  force_delete           = var.force_delete
  network_access_allowed = var.network_access_allowed
}

##############################################################################

##############################################################################
# COS Instance
##############################################################################

module cos {
  source = "terraform-ibm-modules/cos/ibm//modules/instance"

  service_name      = var.cos_instance_name
  resource_group_id = data.ibm_resource_group.resource_group.id
  plan              = var.plan
  region            = var.region
  parameters        = var.parameters
  create_timeout    = var.create_timeout
  update_timeout    = var.update_timeout
  delete_timeout    = var.delete_timeout
}

##############################################################################

##############################################################################
# IAM Authorization
##############################################################################

module "authorization_policy" {

  source = "terraform-ibm-modules/iam/ibm//modules/service-authorization"

  source_service_name         = "cloud-object-storage"
  target_service_name         = "kms"
  roles                       = var.iam_roles
  source_resource_instance_id = module.cos.cos_instance_id
  target_resource_instance_id = module.kms.kms_key_crn
}

##############################################################################

##############################################################################
# Container VPC Cluster
##############################################################################

module "container_vpc_cluster" {

  source = "terraform-ibm-modules/cluster/ibm//modules/vpc-openshift"

  cluster_name                    = "${var.unique_id}-roks-cluster"
  vpc_id                          = data.ibm_is_vpc.vpc.id
  resource_group_id               = data.ibm_resource_group.resource_group.id
  worker_pool_flavor              = var.worker_pool_flavor
  worker_nodes_per_zone           = var.worker_nodes_per_zone
  kube_version                    = var.kube_version
  tags                            = var.cluster_tags
  wait_till                       = var.wait_till
  cos_instance_crn                = module.cos.cos_instance_id
  entitlement                     = var.entitlement
  worker_zones                    = local.worker_zones
  disable_public_service_endpoint = var.disable_public_service_endpoint
  kms_config                      = local.kms_config
  create_timeout                  = var.create_timeout
  update_timeout                  = var.update_timeout
  delete_timeout                  = var.delete_timeout

}

##############################################################################
# Worker pool
##############################################################################


module "vpc_cluster_worker_pool" {

  source = "terraform-ibm-modules/cluster/ibm//modules/configure-vpc-worker-pool"

  for_each              = { for wp in var.worker_pool_data : wp.pool_name => wp }
  worker_pool_name      = each.value.pool_name
  flavor                = each.value.machine_type
  worker_nodes_per_zone = each.value.workers_per_zone

  cluster_name          = module.container_vpc_cluster.vpc_openshift_cluster_id
  resource_group_id     = data.ibm_resource_group.resource_group.id
  virtual_private_cloud = data.ibm_is_vpc.vpc.id
  worker_zones          = local.worker_zones
  entitlement           = var.entitlement
}

