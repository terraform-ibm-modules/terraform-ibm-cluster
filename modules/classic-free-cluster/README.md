# Module classic-free-cluster

This module is used to to provision an free IKS cluster on IBM Cloud Infrastructure - classic

## Example Usage
```
provider "ibm" {
}

module "classic_free_cluster" {
  source = "../../modules/classic-free-cluster"
  
  cluster_name        = var.cluster_name
  worker_zone         = var.worker_zone
  hardware            = var.hardware
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name                              | Description                                           | Type   | Default | Required |
|-----------------------------------|-------------------------------------------------------|--------|---------|----------|
| cluster\_name                     | Name of the cluster                                   | string | n/a     | yes      |
| worker\_zone                      | The zone where the worker node is created.            | string | n/a     | yes      |
| hardware                          | The level of hardware isolation for your worker node. | string | n/a     | yes      |


## Outputs

| Name                  | Description                          | Type   | Default | Required |
|---------------------- |--------------------------------------|--------|---------|----------|
| container_cluster_id  | Kubernetes classic free cluster id   | string | n/a     | yes      |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
