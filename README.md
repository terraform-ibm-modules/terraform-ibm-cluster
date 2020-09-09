# IBM Clusters Terraform Module

This is a collection of modules that make it easier to provision a cluster on IBM Cloud Platform:
* [classic-kubernetes-multi-zone-cluster](modules/classic-kubernetes-multi-zone-cluster)
* [classic-kubernetes-single-zone-cluster](./modules/classic-kubernetes-single-zone-cluster)
* [classic-openshift-multi-zone-cluster](./modules/classic-openshift-multi-zone-cluster)
* [classic-openshift-single-zone-cluster](./modules/classic-openshift-single-zone-cluster)
* [vpc-kubernetes-cluster](./modules/vpc-kubernetes-cluster)
* [vpc-openshift-cluster](./modules/vpc-openshift-cluster)
* [classic-free-cluster](./modules/classic-free-cluster)

And it also has the following modules to configure a already provisioned cluster in IBM Cloud Platform:
* [classic-cluster-worker-pool](./modules/configure-cluster/classic-cluster-worker-pool)
* [vpc-cluster-worker-pool](./modules/configure-cluster/vpc-cluster-worker-pool)
* [add-ons](./modules/configure-cluster/add-ons)

## Compatibility

This module is meant for use with Terraform 0.12. If you haven't
[upgraded][terraform-0.12-upgrade] and need a Terraform 0.11.x-compatible
version of this module, the last released version intended for Terraform 0.11.x
is [1.1.1][v1.1.1].

## Usage

Full examples are in the [examples](./examples/) folder, but basic usage is as follows for creation of classic cluster with single zone:

```hcl
provider "ibm" {
}

data "ibm_resource_group" "test" {
  name = var.resource_group
}

module "classic_kubernetes_single_zone_cluster" {
  source = "../../modules/classic-kubernetes-single-zone-cluster"

  cluster_name                    = var.cluster_name
  resource_group_id               = data.ibm_resource_group.test.id
  worker_zone                     = var.worker_zone
  worker_nodes_per_zone           = var.worker_nodes_per_zone
  worker_pool_flavor              = var.worker_pool_flavor
  public_vlan                     = var.public_vlan_id
  private_vlan                    = var.private_vlan_id
  hardware                        = var.hardware
  master_service_public_endpoint  = var.master_service_public_endpoint
  master_service_private_endpoint = var.master_service_private_endpoint
}

```

Creation of vpc openshift cluster:

```hcl
provider "ibm" {
  generation = var.generation
}

data "ibm_resource_group" "test" {
  name = var.resource_group
}

module "vpc_openshift_cluster" {
  source = "../../modules/vpc-openshift-cluster"

  cluster_name                    = var.cluster_name
  resource_group_id               = data.ibm_resource_group.test.id
  vpc_id                          = var.vpc_id
  cos_instance_crn                = var.cos_instance_crn
  worker_pool_flavor              = var.worker_pool_flavor
  worker_nodes_per_zone           = var.worker_nodes_per_zone
  sunet_id                        = var.sunet_id
  zone_name                       = var.zone_name
}
```

## Requirements

### Terraform plugins

- [Terraform](https://www.terraform.io/downloads.html) 0.12
- [terraform-provider-ibm](https://github.com/IBM-Cloud/terraform-provider-ibm) 

## Install

### Terraform

Be sure you have the correct Terraform version (0.12), you can choose the binary here:
- https://releases.hashicorp.com/terraform/

### Terraform plugins

Be sure you have the compiled plugins on $HOME/.terraform.d/plugins/

- [terraform-provider-ibm](https://github.com/IBM-Cloud/terraform-provider-ibm) 

## How to input varaible values through a file

To review the plan for the configuration defined (no resources actually provisioned)

`terraform plan -var-file=./input.tfvars`

To execute and start building the configuration defined in the plan (provisions resources)

`terraform apply -var-file=./input.tfvars`

To destroy the VPC and all related resources

`terraform destroy -var-file=./input.tfvars`

All optional parameters by default will be set to null in respective example's varaible.tf file. If user wants to configure any optional paramter he has overwrite the default value.

## Note

All optional fields should be given value `null` in respective resource varaible.tf file. User can configure the same by overwriting with appropriate values.