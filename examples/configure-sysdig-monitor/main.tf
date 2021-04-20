#####################################################
# Configure sysdig to a cluster
# Copyright 2020 IBM
#####################################################

provider "null" {}

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
  source = "terraform-ibm-modules/cluster/ibm//modules/configure-sysdig-monitor"

  cluster_name       = var.cluster_name
  sysdig_instance_id = data.ibm_resource_instance.sysdig_instance.guid
}