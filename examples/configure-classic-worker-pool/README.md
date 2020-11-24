# Module classic_cluster_worker_pool

This module is used to configure a worker pool to an existing IKS cluster on IBM Cloud Infrastructure with - classic.

## Example Usage
```
provider "ibm" {
}

data "ibm_resource_group" "test" {
  name =  var.resource_group 
}

module "classic_cluster_worker_pool" {
  source  = "terraform-ibm-modules/cluster/ibm//modules/configure-classic-worker-pool"

  cluster_name                    = var.cluster_name
  worker_pool_name                = var.worker_pool_name
  worker_nodes                    = var.worker_nodes
  flavor                          = var.flavor
  worker_zones                    = var.worker_zones
  resource_group_id               = data.ibm_resource_group.test.id
  wait_till_albs                  = (var.wait_till_albs != null ? var.wait_till_albs : true)
  hardware                        = (var.hardware != null ? var.hardware : "shared")
  encrypt_local_disk              = (var.encrypt_local_disk != null ? var.encrypt_local_disk : true)
  labels                          = (var.labels != null ? var.labels : null )
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
| resource\_group                   |  Name of the resource group.                          | string | n/a     | no       |
| wait_till_albs                    | Use to avoid long wait cluster creation time          | bool   | n/a     | no       |
| labels                            | labels to add to the worker nodes in the worker pool  | map    | n/a     | no       |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

NOTE: We can configure the list of zones to be attached to a cluster by entering zone details in input.tfvars.

## Usage

terraform apply -var-file="input.tfvars"

## Note

All optional fields are given value `null` in varaible.tf file. User can configure the same by overwriting with appropriate values.

