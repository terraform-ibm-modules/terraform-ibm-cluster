#####################################################
# Openshift cluster route provisioning
# Copyright 2021 IBM
#####################################################

provider "ibm" {
}

data "ibm_satellite_cluster" "cluster" {
  name = var.cluster
}

module "openshift_cluster_route" {
  source = "github.com/terraform-ibm-modules/terraform-ibm-cluster//modules/openshift-route"

  ibmcloud_api_key    = var.ibmcloud_api_key
  cluster_service_url = data.ibm_satellite_cluster.cluster.server_url
  namespace           = var.namespace
  route_data          = var.route_data
}