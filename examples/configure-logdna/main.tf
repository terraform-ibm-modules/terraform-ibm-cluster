#####################################################
# Configure logdna to a cluster
# Copyright 2020 IBM
#####################################################

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
  //Uncomment the following line to make the source point to registry level
  //source = "terraform-ibm-modules/cluster/ibm//modules/configure-logdna"

  source               = "../../modules/configure-logdna"
  cluster              = var.cluster
  logdna_instance_id   = data.ibm_resource_instance.logdna_instance.guid
  private_endpoint     = var.private_endpoint
  logdna_ingestion_key = var.logdna_ingestion_key
  create_timeout       = var.create_timeout
  update_timeout       = var.update_timeout
  delete_timeout       = var.delete_timeout
}