# Module vpc_cluster_worker_pool

This module is used to configure a worker pool to an existing IKS cluster on IBM Cloud Infrastructure with - VPC.

## Example Usage
```
provider "ibm" {
}

data "ibm_resource_group" "rg" {
  name = var.resource_group
}

module "vpc_cluster_worker_pool" {
  source  = "terraform-ibm-modules/cluster/ibm//modules/configure-vpc-worker-pool"

  cluster_name                    = var.cluster_name
  worker_pool_name                = var.worker_pool_name
  worker_nodes_per_zone           = var.worker_nodes_per_zone
  flavor                          = var.flavor
  resource_group_id               = data.ibm_resource_group.rg.id
  virtual_private_cloud           = var.virtual_private_cloud
  worker_zones                    = var.worker_zones
  labels                          = (var.labels != null ? var.labels : null )
  entitlement                     = var.entitlement != null ? var.entitlement : null
}
```
## NOTE:

If we want to make use of a particular version of module, then set the "version" argument to respective module version.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name                              | Description                                                    | Type   | Default | Required |
|-----------------------------------|----------------------------------------------------------------|--------|---------|----------|
| cluster\_name                     | Name of the cluster                                            | string | n/a     | yes      |
| worker\_nodes\_per\_zone          | Number of worker nodes.                                        | number | n/a     | yes      |
| flavor                            | The machine type for your worker node.                         | string | n/a     | yes      |
| worker\_pool\_name                | Name of the worker pool                                        | string | n/a     | yes      |
| worker\_zones                     | Map(Map(zones)) where each zone has its public & private VLANs | map    | n/a     | yes      |
| worker\_zones.subnet_id           | subnet_id you want to attach                                   | string | n/a     | yes      |
| resource\_group                   |  Name of the resource group.                                   | string | n/a     | no       |
| labels                            | labels to add to the worker nodes in the worker pool           | map    | n/a     | no       |
| entitlement                       | OpenShift entitlement avoids the OCP licence charges           | string | n/a     | no       |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## worker_zones Inputs

| Name                              | Description                                           | Type   | Default | Required |
|-----------------------------------|-------------------------------------------------------|--------|---------|----------|
| subnet_id                         | Uniue identifier of subnet                            | string | n/a     | no       |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

NOTE: We can configure the list of zones to be attached to a cluster by entering zone details in input.tfvars.

Worker zones is a map(map(zones)), where key will be zone_name and value will be map containing respective public & private VLANs.

## Usage

terraform apply -var-file="input.tfvars"

## Note

All optional fields are given value `null` in varaible.tf file. User can configure the same by overwriting with appropriate values.

