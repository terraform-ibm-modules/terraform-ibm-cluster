# Module classic_openshift_multi_zone_cluster

This module is used to provision an openshift cluster on IBM Cloud Infrastructure with multi zone attached - classic.

## Example Usage
```
provider "ibm" {
}

data "ibm_resource_group" "rg" {
  name = var.resource_group
}

module "classic_openshift_multi_zone_cluster" {
  //Uncomment the following line to make the source point to registry level
  //source = "terraform-ibm-modules/cluster/ibm//modules/classic-openshift-multi-zone"

  source                          = "../../modules/classic-openshift-multi-zone"
  cluster_name                    = var.cluster_name
  metro                           = var.metro
  worker_zones                    = var.worker_zones
  hardware                        = var.hardware
  resource_group_id               = data.ibm_resource_group.rg.id
  worker_nodes_per_zone           = var.worker_nodes_per_zone
  worker_pool_flavor              = var.worker_pool_flavor
  public_vlan                     = var.public_vlan_id
  private_vlan                    = var.private_vlan_id
  master_service_public_endpoint  = var.master_service_public_endpoint
  master_service_private_endpoint = var.master_service_private_endpoint
  force_delete_storage            = var.force_delete_storage
  gateway_enabled                 = var.gateway_enabled
  encrypt_local_disk              = var.encrypt_local_disk
  no_subnet                       = var.no_subnet
  subnet_id                       = var.subnet_id
  update_all_workers              = var.update_all_workers
  tags                            = var.tags
  kube_version                    = var.kube_version
  kms_config                      = var.kms_config
  taints                          = var.taints
  workers_info                    = var.workers_info
  webhook                         = var.webhook
  entitlement                     = var.entitlement
  wait_till_albs                  = var.wait_till_albs
  create_timeout                  = var.create_timeout
  update_timeout                  = var.update_timeout
  delete_timeout                  = var.delete_timeout
}
```
## NOTE:

If we want to make use of a particular version of module, then set the "version" argument to respective module version.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name                              | Description                                                    | Type   | Default | Required |
|-----------------------------------|----------------------------------------------------------------|--------|---------|----------|
| cluster\_name                     | Name of the cluster                                            | string | n/a     | yes      |
| metro                             | The zone where the worker node is created.                     | string | n/a     | yes      |
| hardware                          | The level of hardware isolation for your worker node.          | string | n/a     | yes      |
| worker\_zones                     | Map(Map(zones)) where each zone has its public & private VLANs | map    | n/a     | yes      |
| resource\_group                   |  Name of the resource group.                                   | string | n/a     | no       |
| worker\_nodes\_per\_zone          | Number of workser nodes.                                       | number | 1       | no       |
| worker\_pool\_flavor              | The machine type for your worker node.                         | string | n/a     | no       |
| public\_vlan\_id                  | The ID of the public VLAN                                      | string | n/a     | no       |
| private\_vlan\_id                 | The ID of the private VLAN.                                    | string | n/a     | no       |
| master\_service\_public\_endpoint | Used to enable the public service endpoint.                    | string | n/a     | no       |
| master\_service\_private\_endpoint| Used to enable the private service endpoint.                   | string | n/a     | no       |
| force\_delete\_storage            | Set to delete persistent storage of cluster                    | bool   | false   | no       |
| gateway\_enabled                  | Set to to  create a gateway-enabled cluster.                   | bool   | false   | no       |
| encrypt\_local\_disk              | On set, worker node disks are encrypted with AES 256           | bool   | true    | no       |
| no\_subnet                        | On set, no subnet is created during cluster creation           | bool   | false   | no       |
| subnet\_id                        | List of subnets                                                | list   | n/a     | no       |
| update\_all\_workers              | Kubernetes version of the worker nodes is updated              | bool   | false   | no       |
| tags                              | List of tags to attach                                         | list   | n/a     | no       |
| kube\_version                     | Kubernetes version                                             | string | n/a     | no       |
| kms\_config                       | Use to attach a Key Protect instance to a cluster.             | list   | n/a     | no       |
| workers\_info                     | Array of workers info                                          | list   | n/a     | no       |
| webhook                           | List of webhooks                                               | list   | n/a     | no       |
| wait_till_albs                    | Use to avoid long wait cluster creation time                   | list   | n/a     | no       |
| entitlement                       | OpenShift entitlement avoids the OCP licence charges           | string | n/a     | no       |
| create_timeout                    | Timeout duration for creation                                  | string | n/a     | no       |
| update_timeout                    | Timeout duration for updation                                  | string | n/a     | no       |
| delete_timeout                    | Timeout duration for deletion                                  | string | n/a     | no       |
| taints                            |A nested block that sets or removes Kubernetes taints for all worker nodes in a worker pool|list(string)| n/a  | no  |



## taints Inputs

| Name                | Description                                           | Type   | Default | Required |
|---------------------|-------------------------------------------------------|--------|---------|----------|
|  key                | Key for taint.                                        | string | n/a     | yes      |
|  value              | Value for taint.                                      | string | n/a     | yes      |
|  private_endpoint   | Effect for taint. Accepted values are NoSchedule, PreferNoSchedule, and NoExecute| string   | n/a     | yes       |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## worker_zones Inputs

| Name                              | Description                                           | Type   | Default | Required |
|-----------------------------------|-------------------------------------------------------|--------|---------|----------|
| public_vlan                       | ID of the public  VLAN that we want to use for zone.  | string | n/a     | no       |
| private_vlan                      | ID of the private VLAN that we want to use for zone.  | string | n/a     | no       |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## kms_config Inputs

| Name                              | Description                                           | Type   | Default | Required |
|-----------------------------------|-------------------------------------------------------|--------|---------|----------|
|  instance_id                      | GUID of the Key Protect instance.                     | string | n/a     | no       |
|  crk_id                           | ID of the customer root key.                          | string | n/a     | no       |
|  private_endpoint                 | Set to true to configure KMS private service endpoint.| bool   | n/a     | no       |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## workers_info Inputs

| Name                              | Description                                           | Type   | Default | Required |
|-----------------------------------|-------------------------------------------------------|--------|---------|----------|
|   id                              | ID of the worker node that you want to update.        | string | n/a     | no       |
|   version                         | Kubernetes version that to update your worker nodes to| string | n/a     | no       |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## webhook Inputs

| Name                              | Description                                           | Type   | Default | Required |
|-----------------------------------|-------------------------------------------------------|--------|---------|----------|
|   level                           | Notification level, such as Normal or Warning         | string | n/a     | yes      |
|   type                            | webhook type. Currently, Slack is supported           | string | n/a     | yes      |
|   url                             | URL for the webhook                                   | string | n/a     | yes      |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

NOTE: We can configure the list of zones, kms_config, workers_info and webhook to be attached to a cluster by entering respective details in input.tfvars.

Worker zones is a map(map(zones)), where key will be zone_name and value will be map containing respective public & private VLANs.

## Usage

terraform apply -var-file="input.tfvars"

## Note

All optional fields are given value `null` in varaible.tf file. User can configure the same by overwriting with appropriate values.

## Timeout block

Same set of timeout values (create, update & delete) are applicable to all the resources in a module. For example, say a particular module has 2 resources R1 & R2, if we configure create timeout say 90 mins then R1 create timeout will be set to 90 mins and similarly create timeout for R2 also will be set to 90 mins.