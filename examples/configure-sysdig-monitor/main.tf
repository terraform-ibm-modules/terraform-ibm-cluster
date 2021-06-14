#####################################################
# Configure sysdig to a cluster
# Copyright 2020 IBM
#####################################################

data "ibm_resource_group" "resource_group" {
  name = var.resource_group
}

data "ibm_resource_instance" "sysdig_instance" {

  name              = var.sysdig_name
  service           = "sysdig-monitor"
  resource_group_id = data.ibm_resource_group.resource_group.id
  location          = var.region
}

module "cluster_sysdig_attach" {
  //Uncomment the following line to make the source point to registry level
  //source = "terraform-ibm-modules/cluster/ibm//modules/configure-sysdig-monitor"
  source             = "../../modules/configure-sysdig-monitor"
  cluster            = var.cluster
  sysdig_instance_id = data.ibm_resource_instance.sysdig_instance.guid
  private_endpoint   = var.private_endpoint
  sysdig_access_key  = var.sysdig_access_key
  create_timeout     = var.create_timeout
  update_timeout     = var.update_timeout
  delete_timeout     = var.delete_timeout
}