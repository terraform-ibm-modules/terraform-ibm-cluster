data "ibm_resource_group" "resource_group" {
  name       = (var.resource_group != null ? var.resource_group : null)
  is_default = (var.resource_group == null ? true : null)
}

module "vpc_ocp_cluster" {
  source  = "terraform-ibm-modules/cluster/ibm//modules/vpc-openshift"
  version = "1.4.0"
  depends_on = [
    null_resource.delete_default_egress_security_rule
  ]
  cluster_name                    = "${var.resource_prefix}-cluster"
  vpc_id                          = module.vpc.vpc_id
  worker_pool_flavor              = var.flavor
  resource_group_id               = data.ibm_resource_group.resource_group.id
  kube_version                    = var.ocp_version
  worker_zones                    = local.worker_zones
  worker_nodes_per_zone           = var.worker_nodes_per_zone
  tags                            = ["secure-roks", "cluster", var.resource_prefix]
  disable_public_service_endpoint = var.disable_public_service_endpoint
  entitlement                     = var.ocp_entitlement
  cos_instance_crn                = local.cos_crn
  kms_config                      = local.kms_config
  worker_labels                   = { worker = var.resource_prefix }
  create_timeout                  = var.create_timeout
  wait_till                       = var.wait_till
}

module "configure_cluster_sysdig" {
  source             = "terraform-ibm-modules/cluster/ibm//modules/configure-sysdig-monitor"
  version            = "1.4.0"
  depends_on         = [module.configure_cluster_logdna]
  cluster            = module.vpc_ocp_cluster.vpc_openshift_cluster_id
  sysdig_instance_id = local.sysdig_instance_id
  private_endpoint   = var.private_endpoint
  sysdig_access_key  = var.monitoring_access_key
}
module "configure_cluster_logdna" {
  source               = "terraform-ibm-modules/cluster/ibm//modules/configure-logdna"
  version              = "1.4.0"
  cluster              = module.vpc_ocp_cluster.vpc_openshift_cluster_id
  logdna_instance_id   = local.logdna_instance_id
  private_endpoint     = var.private_endpoint
  logdna_ingestion_key = var.logging_ingestion_key

}
data "ibm_container_vpc_cluster" "cluster" {
  name              = module.vpc_ocp_cluster.vpc_openshift_cluster_id
  resource_group_id = data.ibm_resource_group.resource_group.id
}
data "ibm_container_cluster_config" "clusterConfig" {
  depends_on        = [module.configure_cluster_sysdig]
  cluster_name_id   = module.vpc_ocp_cluster.vpc_openshift_cluster_id
  resource_group_id = data.ibm_resource_group.resource_group.id
  admin             = true
  config_dir        = "/tmp"
}
resource "null_resource" "patch_sysdig" {
  depends_on = [module.configure_cluster_sysdig]
  provisioner "local-exec" {
    environment = {
      APIKEY     = var.ibmcloud_api_key
      SERVER     = data.ibm_container_vpc_cluster.cluster.private_service_endpoint_url
      KUBECONFIG = data.ibm_container_cluster_config.clusterConfig.config_file_path
    }
    command = <<EOT
          export KUBECONFIG=$KUBECONFIG
          oc login -u apikey -p $APIKEY --server $SERVER
          oc -n ibm-observe set image ds/sysdig-agent  sysdig-agent=icr.io/ext/sysdig/agent
        EOT
  }
}
