#####################################################
# Configure logdna to a cluster
# Copyright 2020 IBM
#####################################################

provider "null" {}

data "ibm_resource_group" "resource_group" {
  name = var.resource_group
}

data "ibm_resource_instance" "logdna_instance" {

  name              = var.logdna_name
  service           = "logdna"
  resource_group_id = data.ibm_resource_group.resource_group.id
  location          = var.region
}

module "cluster_logdna_attach" {
  source = "terraform-ibm-modules/cluster/ibm//modules/configure-logdna"

  cluster_name       = var.cluster_name
  logdna_instance_id = data.ibm_resource_instance.logdna_instance.guid
}