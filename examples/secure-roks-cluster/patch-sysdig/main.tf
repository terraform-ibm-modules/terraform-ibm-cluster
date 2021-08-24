data "ibm_container_vpc_cluster" "cluster" {
  name              = var.cluster
  resource_group_id = var.resource_group_id
}
data "ibm_container_cluster_config" "clusterConfig" {
  depends_on        = [data.ibm_container_vpc_cluster.cluster]
  cluster_name_id   = var.cluster
  resource_group_id = var.resource_group_id
  config_dir        = "/tmp"
}
data "ibm_container_cluster_config" "clusterConfigRetry" {
  depends_on        = [data.ibm_container_cluster_config.clusterConfig]
  cluster_name_id   = var.cluster
  resource_group_id = var.resource_group_id
  config_dir        = "/tmp"
}
resource "time_sleep" "wait_1m" {
  create_duration = "1m"
}
resource "null_resource" "patch_sysdig" {
  depends_on = [
    time_sleep.wait_1m, data.ibm_container_cluster_config.clusterConfigRetry
  ]
  provisioner "local-exec" {
    environment = {
      KUBECONFIG = data.ibm_container_cluster_config.clusterConfigRetry.config_file_path
    }
    command = <<EOT
          export KUBECONFIG=$KUBECONFIG
          kubectl -n ibm-observe set image ds/sysdig-agent  sysdig-agent=icr.io/ext/sysdig/agent
        EOT
  }
}
variable "cluster" {

}
variable "resource_group_id" {

}
terraform {
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">=1.30.0"
    }
  }
}