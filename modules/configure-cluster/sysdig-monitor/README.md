# Module sysdig-monitor

This module is used to configure a sysdig monitor to an existing cluster on IBM Cloud Infrastructure.

## Example Usage
```
provider "null" {}

data "ibm_resource_group" "resource_group" {
  name = var.resource_group
}

data "ibm_resource_instance" "sysdig_instance" {

  name              = var.sysdig_name
  service           = "sysdig-monitor"
  resource_group_id = data.ibm_resource_group.resource_group.id
  location          = var.region
}

module "cluster_sysdig_attach" {
  source = "../../../modules/configure-cluster/sysdig-monitor"

  cluster_name                    = var.cluster_name
  sysdig_instance_id              = data.ibm_resource_instance.sysdig_instance.id
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name                              | Description                                           | Type   | Default | Required |
|-----------------------------------|-------------------------------------------------------|--------|---------|----------|
| cluster\_name                     | Name of the cluster                                   | string | n/a     | yes      |
| sysdig\_instance_\id              | ID of the sysdig instance to attach to a cluster.     | string | n/a     | yes      |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


