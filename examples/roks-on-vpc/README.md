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
  create_timeout    = var.create_timeout
  update_timeout    = var.update_timeout
  delete_timeout    = var.delete_timeout
}
```
## NOTE:
If we want to make use of a particular version of module, then set the "version" argument to respective module version.


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name                              | Description                                           | Type   | Default | Required |
|-----------------------------------|-------------------------------------------------------|--------|---------|----------|
| cluster\_name                     | Name of the cluster                                   | string | n/a     | yes      |
| worker\_zone                      | The zone where the worker node is created.            | string | n/a     | yes      |
| hardware                          | The level of hardware isolation for your worker node. | string | n/a     | yes      |
| create_timeout                    | Timeout duration for create                           | string | n/a     | no       |
| update_timeout                    | Timeout duration for update                           | string | n/a     | no       |
| delete_timeout                    | Timeout duration for delete                           | string | n/a     | no       |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Usage

terraform apply
