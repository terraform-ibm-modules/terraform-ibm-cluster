# Terraform Module to install Portworx

This Terraform Module installs the **Portworx Service** on an Openshift (ROKS) cluster on IBM Cloud.

## Requirements

To run locally on IBM Cloud, this module has the following dependencies:

- Have an IBM Cloud account with required privileges
- Access to IBM Cloud
  - [Create an IBM Cloud API key](https://cloud.ibm.com/docs/account?topic=account-userapikey#create_user_key)
  - [Create an IBM Cloud Classic Infrastructure API Key](https://cloud.ibm.com/docs/account?topic=account-classic_keys)

  In the terminal window, export the following environment variables to let the IBM Provider to retrieve the credentials.

  ```bash
  export IAAS_CLASSIC_USERNAME="< Your IBM Cloud Username/Email here >"
  export IAAS_CLASSIC_API_KEY="< Your IBM Cloud Classic API Key here >"
  export IC_API_KEY="< IBM Cloud API Key >"
  ```

- [IBM Cloud CLI](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment#install-ibm-cloud-cli) installed
  - [Login to IBM Cloud with the CLI](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment#login-to-ibm-cloud)
- [IBM Cloud CLI Plugin](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment#ibm-cloud-cli-plugins) for `kubernetes-service` and `container-service` installed
- [Terraform](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment#install-terraform) **version 0.12** installed
- [IBM Cloud Terraform Provider](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment#configure-access-to-ibm-cloud) installed
- Utility tools such as:
  - [jq](https://stedolan.github.io/jq/download/)
  - [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- OpenShift or Kubernetes cluster

## Provisioning this module in a Terraform Script

In your Terraform code define the `ibm` provisioner block with the `region`.

```hcl
provider "ibm" {
  region     = "us-south"
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}
```


### Provisioning the Portworx Module

Use a `module` block assigning `source` to `git::https://github.com/ibm-hcbt/terraform-ibm-cloud-pak.git//modules/portworx`. Then set the [input variables](#input-variables) required to install the Portworx service.

```hcl
module "portworx" {
  source = "git::https://github.com/ibm-hcbt/terraform-ibm-cloud-pak.git//modules/portworx"
  enable = true
  ibmcloud_api_key = "<api-key>"

  // Cluster parameters
  kube_config_path      = ".kube/config"
  worker_nodes          = 2  // Number of workers

  // Storage parameters
  install_storage       = true
  storage_capacity      = 200  // In GBs
  storage_iops          = 10   // Must be a number, it will not be used unless a storage_profile is set to a custom profile
  storage_profile       = "10iops-tier"

  // Portworx parameters
  resource_group_name   = "default"
  region                = "us-east"
  cluster_id            = "<cluster-id>"
  unique_id             = "roks-px-tf"

  // These credentials have been hard-coded because the 'Databases for etcd' service instance is not configured to have a publicly accessible endpoint by default.
  // You may override these for additional security.
  create_external_etcd  = false
  etcd_username         = "portworxuser"
  etcd_password         = "portworxpassword"
  etcd_secret_name      = "px-etcd-certs" # don't change this
}
```


## Input Variables

| Name                           | Description                                                                                                                                                                                                                | Default | Required |
| ------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | -------- |
| `enable`                       | If set to `false` does not install Portworx on the given cluster. Enabled by default | `true`  | Yes       |
| `ibmcloud_api_key`             | This requires an ibmcloud api key found here: `https://cloud.ibm.com/iam/apikeys`    |         | Yes       |
| `kube_config_path`             | This is the path to the kube config                                          |  `.kube/config` | Yes       |
| `worker_nodes`                 | Number of worker nodes in the cluster                                        |                 | Yes       |
| `install_storage`              | If set to `false` does not install storage and attach the volumes to the worker nodes. Enabled by default  |  `true` | Yes      |
| `storage_capacity`             | Sets the capacity of the volume in GBs. |   `200`    | Yes      |
| `storage_iops`                 | Sets the number of iops for a custom class. *Note* This is used only if a user provides a custom `storage_profile` |   `10`    | Yes      |
| `storage_profile`              | The is the storage profile used for creating storage. If this is set to a custom profile, you must update the `storage_iops` |   `10iops-tier`    | Yes      |
| `resource_group_name`          | The resource group name where the cluster is housed                                  |         | Yes      |
| `region`                       | The region that resources will be provisioned in. Ex: `"us-east"` `"us-south"` etc.  |         | Yes      |
| `cluster_id`                   | The name of the cluster created |  | Yes       |
| `unique_id`                    | The id of the portworx-service  |  | Yes       |
| `create_external_etcd`         | Set this value to `true` or `false` to create an external etcd | `false` | Yes |
| `etcd_username`                | Username needed for etcd                         | `portworxuser`     | yes |
| `etcd_password`                | Password needed for etcd                         | `portworxpassword` | Yes |
| `etcd_secret_name`             | Etcd secret name, do not change it from default  | `px-etcd-certs`    | Yes |


**NOTE** The boolean input variable `enable` is used to enable/disable the module. This parameter may be deprecated when Terraform 0.12 is not longer supported. In Terraform 0.13, the block parameter `count` can be used to define how many instances of the module are needed. If set to zero the module won't be created.

For an example of how to put all this together, refer to our [Cloud Pak for Data Terraform script](https://github.com/ibm-hcbt/cloud-pak-sandboxes/tree/master/terraform/cp4data).


## Executing the Terraform Script

Run the following commands to execute the TF script (containing the modules to create/use ROKS and Portworx). Execution may take about 5-15 minutes:

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

## Clean up

To remove Portworx and Storage from a cluster, execute the following command:

Run in the cluster:

```bash
curl -fsL https://install.portworx.com/px-wipe | bash

terraform destroy
```



