# Module logdna

This module is used to configure a logdna to an existing cluster on IBM Cloud Infrastructure.

## Example Usage
```
provider "null" {}

data "ibm_resource_group" "resource_group" {
  name = var.resource_group
}

data "ibm_resource_instance" "logdna_instance" {

  name              = var.logdna_name
  service           = "logdna"
  resource_group_id = data.ibm_resource_group.resource_group.id
  location          = var.region
}

module "cluster_logdna_attach" {
  source = "../../../modules/configure-cluster/logdna"

  cluster_name                    = var.cluster_name
  logdna_instance_id              = data.ibm_resource_instance.logdna_instance.guid
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name                              | Description                                           | Type   | Default | Required |
|-----------------------------------|-------------------------------------------------------|--------|---------|----------|
| cluster\_name                     | Name of the cluster                                   | string | n/a     | yes      |
| logdna\_name                      | Name of the logdna to attach to a cluster.            | string | n/a     | yes      |
| region                            | Region where sysdig is provisioned.                   | string | n/a     | no       |
| resource\_group                   | Name of the resource group.                           | string | n/a     | yes      |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


