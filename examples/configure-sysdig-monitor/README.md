# Module sysdig-monitor

This module is used to configure a sysdig monitor to an existing cluster on IBM Cloud Infrastructure.

## Example Usage
```
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
  //Uncomment the following line to make the source point to registry level
  //source = "terraform-ibm-modules/cluster/ibm//modules/configure-sysdig-monitor"
  source = "../../modules/configure-sysdig-monitor"
  cluster            = var.cluster
  sysdig_instance_id = data.ibm_resource_instance.sysdig_instance.guid
  private_endpoint   = var.private_endpoint
  sysdig_access_key  = var.sysdig_access_key
  create_timeout       = var.create_timeout
  update_timeout       = var.update_timeout
  delete_timeout       = var.delete_timeout
}
```
## NOTE:

If we want to make use of a particular version of module, then set the "version" argument to respective module version.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name                              | Description                                               | Type   | Default | Required |
|-----------------------------------|-----------------------------------------------------------|--------|---------|----------|
| cluster                           | Name or id of the cluster                                 | string | n/a     | yes      |
| sysdig\_name                      | Name of the sysdig to attach to a cluster.                | string | n/a     | yes      |
| region                            | Region where sysdig is provisioned.                       | string | n/a     | no       |
| resource\_group                   | Name of the resource group.                               | string | n/a     | yes      |
| private_endpoint                  | Use to connect to sysdig instance through private endpoint| bool   | n/a     | no       |
| sysdig_access_key                 | sysdig access key                                         | string | n/a     | no       |
| create_timeout                    | Timeout duration for create                               | string | n/a     | no       |
| update_timeout                    | Timeout duration for update                               | string | n/a     | no       |
| delete_timeout                    | Timeout duration for delete                               | string | n/a     | no       |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Usage

terraform apply
