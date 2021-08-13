provider "ibm" {
  region = var.region
}

data "ibm_resource_group" "group" {
  name = var.resource_group_name
}

resource "null_resource" "mkdir_kubeconfig_dir" {
  triggers = { always_run = timestamp() }
  provisioner "local-exec" {
    command = "mkdir -p ${local.kube_config_path}"
  }
}

data "ibm_container_cluster_config" "cluster_config" {
  depends_on = [null_resource.mkdir_kubeconfig_dir]
  cluster_name_id   = var.cluster_id
  resource_group_id = data.ibm_resource_group.group.id
  config_dir        = local.kube_config_path
}

// Module:

module "portworx" {
  source = "../modules"
  // TODO: With Terraform 0.13 replace the parameter 'enable' or the conditional expression using 'with_iaf' with 'count'
  enable = true

  ibmcloud_api_key = var.ibmcloud_api_key

  // Cluster parameters
  kube_config_path = data.ibm_container_cluster_config.cluster_config.config_file_path
  worker_nodes     = var.worker_nodes  // Number of workers

  // Storage parameters
  install_storage      = true
  storage_capacity     = var.storage_capacity  // In GBs
  storage_iops         = var.storage_iops   // Must be a number, it will not be used unless a storage_profile is set to a custom profile
  storage_profile      = var.storage_profile

  // Portworx parameters
  resource_group_name   = var.resource_group_name
  region                = var.region
  cluster_id            = var.cluster_id
  unique_id             = var.unique_id

  // These credentials have been hard-coded because the 'Databases for etcd' service instance is not configured to have a publicly accessible endpoint by default.
  // You may override these for additional security.
  create_external_etcd  = var.create_external_etcd
  etcd_username         = var.etcd_username
  etcd_password         = var.etcd_password
  // Defaulted.  Don't change
  etcd_secret_name      = "px-etcd-certs"
}

