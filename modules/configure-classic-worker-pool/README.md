# Module classic_cluster_worker_pool

This module is used to configure a worker pool to an existing IKS cluster on IBM Cloud Infrastructure with - classic.

## Example Usage
```
provider "ibm" {
}

data "ibm_resource_group" "rg" {
  name = var.resource_group
}

module "classic_cluster_worker_pool" {
  //Uncomment the following line to make the source point to registry level
  //source = "terraform-ibm-modules/cluster/ibm//modules/configure-classic-worker-pool"
  source = "../../modules/configure-classic-worker-pool"

  cluster_name                    = var.cluster_name
  worker_pool_name                = var.worker_pool_name
  worker_nodes                    = var.worker_nodes
  flavor                          = var.flavor
  worker_zones                    = var.worker_zones
  resource_group_id               = data.ibm_resource_group.rg.id
  wait_till_albs                  = var.wait_till_albs
  hardware                        = var.hardware
  encrypt_local_disk              = var.encrypt_local_disk
  labels                          = var.labels
  taints                          = var.taints
  create_timeout                  = var.create_timeout
  update_timeout                  = var.update_timeout
  delete_timeout                  = var.delete_timeout
}
```
## NOTE:

If we want to make use of a particular version of module, then set the "version" argument to respective module version.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name                              | Description                                           | Type   | Default | Required |
|-----------------------------------|-------------------------------------------------------|--------|---------|----------|
| cluster\_name                     | Name of the cluster                                   | string | n/a     | yes      |
| worker\_nodes                     | Number of worker nodes.                               | number | n/a     | yes      |
| hardware                          | The level of hardware isolation for your worker node. | string | n/a     | no       |
| flavor                            | The machine type for your worker node.                | string | n/a     | yes      |
| worker\_pool\_name                | Name of the worker pool                               | string | n/a     | yes      |
| encrypt\_local\_disk              | Set this to encrypt th elocal disk                    | string | n/a     | no       |
| worker\_zones                     | List of zones to attach to a pool.                    | map    | n/a     | yes      |
| worker\_zones.public_vlan         | ID of the public  VLAN that we want to use for zone.  | string | n/a     | no       |
| worker\_zones.private_vlan        | ID of the private VLAN that we want to use for zone.  | string | n/a     | no       |
| resource\_group                   |  Name of the resource group.                          | string | n/a     | no       |
| wait_till_albs                    | Use to avoid long wait cluster creation time          | bool   | n/a     | no       |
| labels                            | labels to add to the worker nodes in the worker pool  | map    | n/a     | no       |
| create_timeout                    | Timeout duration for creation                         | string | n/a     | no       |
| update_timeout                    | Timeout duration for updation                         | string | n/a     | no       |
| delete_timeout                    | Timeout duration for deletion                         | string | n/a     | no       |
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

NOTE: We can configure the list of zones to be attached to a cluster by entering zone details in input.tfvars.

## Usage

terraform apply -var-file="input.tfvars"

## Note

All optional fields are given value `null` in varaible.tf file. User can configure the same by overwriting with appropriate values.

## Timeout block

Same set of timeout values (create, update & delete) are applicable to all the resources in a module. For example, say a particular module has 2 resources R1 & R2, if we configure create timeout say 90 mins then R1 create timeout will be set to 90 mins and similarly create timeout for R2 also will be set to 90 mins.
