# Module vpc-kubernetes-cluster

This module is used to to provision an vpc cluster on IBM Cloud Infrastructure - VPC.

## Example Usage
```
data "ibm_resource_group" "rg" {
  name = var.resource_group
}

module "vpc_kubernetes_cluster" {
  //Uncomment the following line to make the source point to registry level
  //source = "terraform-ibm-modules/cluster/ibm//modules/vpc-kubernetes"
  source = "../../modules/vpc-kubernetes"
  cluster_name                    = var.cluster_name
  vpc_id                          = var.vpc_id
  worker_pool_flavor              = var.worker_pool_flavor
  worker_zones                    = var.worker_zones
  worker_nodes_per_zone           = var.worker_nodes_per_zone
  resource_group_id               = data.ibm_resource_group.rg.id
  kube_version                    = var.kube_version
  update_all_workers              = var.update_all_workers
  service_subnet                  = var.service_subnet
  pod_subnet                      = var.pod_subnet
  worker_labels                   = var.worker_labels
  wait_till                       = var.wait_till
  disable_public_service_endpoint = var.disable_public_service_endpoint
  tags                            = var.tags
  cos_instance_crn                = var.cos_instance_crn
  force_delete_storage            = var.force_delete_storage
  kms_config                      = var.kms_config
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

| Name                              | Description                                             | Type   | Default     | Required |
|-----------------------------------|---------------------------------------------------------|--------|-------------|----------|
| cluster\_name                     | Name of the cluster                                     | string | n/a         | yes      |
| vpc\_id                           | The ID of the VPC.                                      | string | n/a         | yes      |
| worker\_pool\_flavor              | The flavor of the VPC worker node that you want to use. | string | n/a         | yes      |
| worker\_zones                     | Map(Map(zones)) where each zone has its subnet id       | map    | n/a         | yes      |
| resource_group                    | Name of the resource group.                             | string | n/a         | no       |
| worker\_nodes\_per\_zone          | Number of worker nodes.                                 | number | 1           | no       |
| kube\_version                     | Kubernetes version                                      | string | n/a         | no       |
| update\_all\_workers              | Kubernetes version of the worker nodes is updated       | bool   | false       | no       |
| service\_subnet                   | Custom subnet CIDR to provide private IP for services   | string | n/a         | no       |
| pod\_subnet                       | Custom subnet CIDR to provide private IP  for pods      | string | n/a         | no       |
| worker\_labels                    | Labels on all the workers in the default worker pool    | map    | n/a         | no       |
| wait\_till                        | Stage when to mark the cluster creation as completed    | string | ingressReady| no       |
| cos\_instance\_crn                | CRN of cos instance                                     | string | n/a         | no       |
| kms\_config                       | Use to attach a Key Protect instance to a cluster.      | list   | n/a         | no       |
| tags                              | List of tags to attach                                  | list   | n/a         | no       |
| force\_delete\_storage            | Set to delete persistent storage of cluster             | bool   | false       | no       |
| create_timeout                    | Timeout duration for create                             | string | n/a         | no       |
| update_timeout                    | Timeout duration for update                             | string | n/a         | no       |
| delete_timeout                    | Timeout duration for delete                             | string | n/a         | no       |
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

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## kms_config Inputs

| Name                              | Description                                           | Type   | Default | Required |
|-----------------------------------|-------------------------------------------------------|--------|---------|----------|
|  instance_id                      | GUID of the Key Protect instance.                     | string | n/a     | no       |
|  crk_id                           | ID of the customer root key.                          | string | n/a     | no       |
|  private_endpoint                 | Set to true to configure KMS private service endpoint.| bool   | n/a     | no       |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Note

All optional fields are given value `null` in varaible.tf file. User can configure the same by overwriting with appropriate values.

Worker zones is a map(map(zones)), where key will be zone_name and value will be map containing respective subnet_id.

## Usage

terraform apply -var-file="input.tfvars"