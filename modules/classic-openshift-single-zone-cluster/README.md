# Module classic-openshift-single-zone-cluster 

This module is used to to provision a Red Hat Openshift cluster on IBM Cloud Infrastructure - classic.

## Example Usage
```
provider "ibm" {
}

data "ibm_resource_group" "test" {
  name = var.resource_group
}

module "classic_openshift_single_zone_cluster" {
  source = "../../modules/classic-openshift-single-zone-cluster"

  cluster_name                    = var.cluster_name
  worker_zone                     = var.worker_zone
  hardware                        = var.hardware 
  resource_group_id               = data.ibm_resource_group.test.id
  worker_nodes_per_zone           = (var.worker_nodes_per_zone != null ? var.worker_nodes_per_zone : 1)
  worker_pool_flavor              = (var.worker_pool_flavor != null ? var.worker_pool_flavor : null)
  public_vlan                     = (var.public_vlan_id != null ? var.public_vlan_id : null)
  private_vlan                    = (var.private_vlan_id != null ? var.private_vlan_id : null)
  master_service_public_endpoint  = (var.master_service_public_endpoint != null ? var.master_service_public_endpoint : null)
  master_service_private_endpoint = (var.master_service_private_endpoint != null ? var.master_service_private_endpoint : null)
  force_delete_storage            = (var.force_delete_storage != null ? var.force_delete_storage : false)
  gateway_enabled                 = (var.gateway_enabled != null ? var.gateway_enabled : false)
  encrypt_local_disk              = (var.encrypt_local_disk != null ? var.encrypt_local_disk : true)
  no_subnet                       = (var.no_subnet != null ? var.no_subnet : false)
  subnet_id                       = (var.subnet_id != null ? var.subnet_id : []) 
  update_all_workers              = (var.update_all_workers != null ? var.update_all_workers : false)
  tags                            = (var.tags != null ? var.tags : [])
  kube_version                    = (var.kube_version != null ? var.kube_version : null)
  kms_config                      = (var.kms_config != null ? var.kms_config :[])
  workers_info                    = (var.workers_info != null ? var.workers_info : [])
  webhook                         = (var.webhook != null ? var.webhook : [])
  entitlement                     = (var.entitlement != null ? var.entitlement : null)

}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name                              | Description                                           | Type   | Default | Required |
|-----------------------------------|-------------------------------------------------------|--------|---------|----------|
| cluster\_name                     | Name of the cluster                                   | string | n/a     | yes      |
| worker\_zone                      | The zone where the worker node is created.            | string | n/a     | yes      |
| resource\_group\_id               | ID of the resource group.                             | string | n/a     | no       |
| worker\_nodes\_per\_zone          | Number of workser nodes.                              | number | n/a     | no       |
| hardware                          | The level of hardware isolation for your worker node. | string | n/a     | no       |
| worker_pool_flavor                | The machine type for your worker node.                | string | n/a     | no       |
| public\_vlan\_id                  | The ID of the public VLAN                             | string | n/a     | no       |
| private\_vlan\_id                 | The ID of the private VLAN.                           | string | n/a     | no       |
| master\_service\_public\_endpoint | Enable the public service endpoint                    | string | n/a     | no       |
| master\_service\_private\_endpoint| Enable the private service endpoint                   | string | n/a     | no       |
| force\_delete\_storage            | Set to delete persistent storage of cluster           | bool   | false   | no       |
| gateway\_enabled                  | Set to to  create a gateway-enabled cluster.          | bool   | false   | no       |
| encrypt\_local\_disk              | On set, worker node disks are encrypted with AES 256  | bool   | true    | no       |
| no\_subnet                        | On set, no subnet is created during cluster creation  | bool   | false   | no       |
| subnet\_id                        | List of subnets                                       | list   | n/a     | no       |
| update\_all\_workers              | Kubernetes version of the worker nodes is updated     | bool   | false   | no       |
| tags                              | List of tags to attach                                | list   | n/a     | no       |
| kube\_version                     | Kubernetes version                                    | string | n/a     | no       |
| kms\_config                       | Use to attach a Key Protect instance to a cluster.    | list   | n/a     | no       |
| workers\_info                     | Array of workers info                                 | list   | n/a     | no       |
| webhook                           | List of webhooks                                      | list   | n/a     | no       |
| entitlement                       | OpenShift entitlement avoids the OCP licence charges  | string | n/a     | no       |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->