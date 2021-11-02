# Module classic-free-cluster

This example is used to to provision an free IKS cluster on IBM Cloud Infrastructure - classic

## Example Usage
```
provider "ibm" {
}

module "classic_free_cluster" {
  //Uncomment the following line to make the source point to registry level
  //source = "terraform-ibm-modules/cluster/ibm//modules/classic-free"

  source = "../../modules/classic-free"

  cluster_name = var.cluster_name
  worker_zone  = var.worker_zone
  hardware     = var.hardware
  taints       = var.taints
  create_timeout    = var.create_timeout
  update_timeout    = var.update_timeout
  delete_timeout    = var.delete_timeout
}
```
## NOTE: If we want to make use of a particular version of module, then set the "version" argument to respective module version.


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name                              | Description                                           | Type   | Default | Required |
|-----------------------------------|-------------------------------------------------------|--------|---------|----------|
| cluster\_name                     | Name of the cluster                                   | string | n/a     | yes      |
| worker\_zone                      | The zone where the worker node is created.            | string | n/a     | yes      |
| hardware                          | The level of hardware isolation for your worker node. | string | n/a     | yes      |
| taints                            |A nested block that sets or removes Kubernetes taints for all worker nodes in a worker pool|list(string)| n/a  | no  |
| create_timeout                    | Timeout duration for create                           | string | n/a     | no       |
| update_timeout                    | Timeout duration for update                           | string | n/a     | no       |
| delete_timeout                    | Timeout duration for delete                           | string | n/a     | no       |


## taints Inputs

| Name                | Description                                           | Type   | Default | Required |
|---------------------|-------------------------------------------------------|--------|---------|----------|
|  key                | Key for taint.                                        | string | n/a     | yes      |
|  value              | Value for taint.                                      | string | n/a     | yes      |
|  private_endpoint   | Effect for taint. Accepted values are NoSchedule, PreferNoSchedule, and NoExecute| string   | n/a     | yes       |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
