# Module classic-free-cluster

This example is used to to provision an free IKS cluster on IBM Cloud Infrastructure - classic

## Example Usage
```
provider "ibm" {
}

module "classic_free_cluster" {
  source  = "terraform-ibm-modules/cluster/ibm//modules/classic-free"

  cluster_name        = var.cluster_name
  worker_zone         = var.worker_zone
  hardware            = var.hardware
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

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
