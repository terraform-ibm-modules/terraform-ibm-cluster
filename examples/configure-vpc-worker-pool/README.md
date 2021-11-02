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
  //Uncomment the following line to make the source point to registry level
  //source = "terraform-ibm-modules/cluster/ibm//modules/configure-vpc-worker-pool"
  source = "../../modules/configure-vpc-worker-pool"

  cluster_name          = var.cluster_name
  worker_pool_name      = var.worker_pool_name
  worker_nodes_per_zone = var.worker_nodes_per_zone
  flavor                = var.flavor
  resource_group_id     = data.ibm_resource_group.rg.id
  virtual_private_cloud = var.virtual_private_cloud
  worker_zones          = var.worker_zones
  labels                = var.labels
  taints                = var.taints
  entitlement           = var.entitlement
  create_timeout        = var.create_timeout
  delete_timeout        = var.delete_timeout
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
| create_timeout                    | Timeout duration for create                                    | string | n/a     | no       |
| delete_timeout                    | Timeout duration for delete                                    | string | n/a     | no       |
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
| subnet_id                         | Uniue identifier of subnet                            | string | n/a     | no       |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

NOTE: We can configure the list of zones to be attached to a cluster by entering zone details in input.tfvars.

Worker zones is a map(map(zones)), where key will be zone_name and value will be map containing respective public & private VLANs.

## Usage

terraform apply -var-file="input.tfvars"

## Note

All optional fields are given value `null` in varaible.tf file. User can configure the same by overwriting with appropriate values.

