# Module add-ons

This module is used to configure a list of add-ons to an existing cluster on IBM Cloud Infrastructure.

## Example Usage
```
provider "ibm" {
}

module "classic_kubernetes_worker_pool" {
  //Uncomment the following line to make the source point to registry level
  //source = "terraform-ibm-modules/cluster/ibm//modules/configure-addons"

  source = "../../modules/configure-addons"
  cluster_name        = var.cluster_name
  add_ons             = var.add_ons
  create_timeout      = var.create_timeout
  update_timeout      = var.update_timeout
  delete_timeout      = var.delete_timeout
}
```
## NOTE:

If we want to make use of a particular version of module, then set the "version" argument to respective module version.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name                              | Description                                                           | Type   | Default | Required|
|-----------------------------------|---------------------------------------------------------------------- |--------|---------|---------|
| cluster\_name                     | Name of the cluster                                                   | string | n/a     | yes     |
| add\_ons                          | map(map(add_ons)), key is add_on name and value is respective version.| string | n/a     | yes     |
| add\_ons.version                  | The add-on version.                                                   | string | n/a     | no      |
| create_timeout                    | Timeout duration for create                                           | string | n/a     | no      |
| update_timeout                    | Timeout duration for update                                           | string | n/a     | no      |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## add_ons Inputs

| Name                              | Description                                           | Type   | Default | Required |
|-----------------------------------|-------------------------------------------------------|--------|---------|----------|
| version                           | The add-on version.                                   | string | n/a     | no       |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

NOTE: We can configure the list of add-ons to be attached to a cluster by entering add-on details in input.tfvars.


## Usage

terraform apply -var-file="input.tfvars"

