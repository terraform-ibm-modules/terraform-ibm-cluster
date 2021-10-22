# IBM Clusters Terraform Module

This is a collection of modules that make it easier to provision a cluster on IBM Cloud Platform:

* classic-kubernetes-multi-zone-cluster
* classic-kubernetes-single-zone-cluster
* classic-openshift-multi-zone-cluster
* classic-openshift-single-zone-cluster
* vpc-kubernetes-cluster
* vpc-openshift-cluster
* classic-free-cluster

And it also has the following modules to configure a already provisioned cluster in IBM Cloud Platform:

* classic-cluster-worker-pool
* vpc-cluster-worker-pool
* add-ons
* openshift-route

## Compatibility

This module is meant for use with Terraform 0.13.

## Usage

Full examples are in the [examples](./examples/) folder, but basic usage is as follows for creation of classic cluster with single zone:

```hcl
provider "ibm" {
}

data "ibm_resource_group" "rg" {
  name = var.resource_group
}

module "classic_kubernetes_single_zone_cluster" {
  source  = "terraform-ibm-modules/cluster/ibm//modules/classic-kubernetes-single-zone"

  cluster_name                    = var.cluster_name
  worker_zone                     = var.worker_zone
  hardware                        = var.hardware
  resource_group_id               = data.ibm_resource_group.rg.id
  worker_nodes_per_zone           = (var.worker_nodes_per_zone != null ? var.worker_nodes_per_zone : 1)
  worker_pool_flavor              = var.worker_pool_flavor != null ? var.worker_pool_flavor : null
  public_vlan                     = (var.public_vlan_id != null ? var.public_vlan_id : null)
  private_vlan                    = (var.private_vlan_id != null ? var.private_vlan_id : null)
  master_service_public_endpoint  = (var.master_service_public_endpoint != null ? var.master_service_public_endpoint : null)
  master_service_private_endpoint = (var.master_service_private_endpoint != null ? var.master_service_private_endpoint : null)
  force_delete_storage            = (var.force_delete_storage != null ? var.force_delete_storage : false)
  gateway_enabled                 = (var.gateway_enabled != null ? var.gateway_enabled : false)
  encrypt_local_disk              = (var.encrypt_local_disk != null ? var.encrypt_local_disk : true)
  no_subnet                       = (var.no_subnet != null ? var.no_subnet : false)
  subnet_id                       = var.subnet_id != null ? var.subnet_id : []
  update_all_workers              = (var.update_all_workers != null ? var.update_all_workers : false)
  tags                            = (var.tags != null ? var.tags : [])
  kube_version                    = (var.kube_version != null ? var.kube_version : null)
  kms_config                      = var.kms_config != null ? var.kms_config :[]
  workers_info                    = var.workers_info != null ? var.workers_info : []
  webhook                         = var.webhook != null ? var.webhook : []

}

```

Creation of vpc openshift cluster:

```hcl
provider "ibm" {
  generation = var.generation
}

data "ibm_resource_group" "rg" {
  name = var.resource_group
}

module "vpc_openshift_cluster" {
  source  = "terraform-ibm-modules/cluster/ibm//modules/vpc-openshift"

  cluster_name                    = var.cluster_name
  vpc_id                          = var.vpc_id
  worker_pool_flavor              = var.worker_pool_flavor
  worker_zones                    = var.worker_zones
  worker_nodes_per_zone           = (var.worker_nodes_per_zone != null ? var.worker_nodes_per_zone : 1)
  resource_group_id               = data.ibm_resource_group.rg.id
  kube_version                    = (var.kube_version != null ? var.kube_version : null)
  update_all_workers              = (var.update_all_workers != null ? var.update_all_workers : false)
  service_subnet                  = (var.service_subnet != null ?  var.service_subnet : "172.21.0.0/16")
  pod_subnet                      = (var.pod_subnet != null ? var.pod_subnet : "172.30.0.0/16")
  worker_labels                   = (var.worker_labels != null ? var.worker_labels : null)
  wait_till                       = (var.wait_till != null ? var.wait_till  : "ingressReady")
  disable_public_service_endpoint = (var.disable_public_service_endpoint != null ? var.disable_public_service_endpoint : true)
  tags                            = (var.tags != null ? var.tags : [])
  cos_instance_crn                = (var.cos_instance_crn != null ? var.cos_instance_crn : null)
  force_delete_storage            = (var.force_delete_storage != null ? var.force_delete_storage : false)
  kms_config                      = (var.kms_config != null ? var.kms_config : [])
  entitlement                     = (var.entitlement != null ? var.entitlement : null)
}
```

Creation of openshift route:

```hcl
module "openshift_cluster_route" {
  source = "github.com/terraform-ibm-modules/terraform-ibm-cluster//modules/openshift-route"

  ibmcloud_api_key    = var.ibmcloud_api_key
  cluster_service_url = var.cluster_service_url
  namespace           = var.namespace
  route_data          = var.route_data
}
```

## Requirements

### Terraform plugins

- [Terraform](https://www.terraform.io/downloads.html) 0.13
- [terraform-provider-ibm](https://github.com/IBM-Cloud/terraform-provider-ibm)

## Install

### Terraform

Be sure you have the correct Terraform version (0.13), you can choose the binary here:
- https://releases.hashicorp.com/terraform/

### Terraform plugins

Be sure you have the compiled plugins on $HOME/.terraform.d/plugins/

- [terraform-provider-ibm](https://github.com/IBM-Cloud/terraform-provider-ibm)

### Pre-commit Hooks

Run the following command to execute the pre-commit hooks defined in .pre-commit-config.yaml file

```
pre-commit run -a
```

We can install pre-coomit tool using

```
pip install pre-commit

      or

pip3 install pre-commit
```

### Detect Secret Hook

Used to detect secrets within a code base.

To create a secret baseline file run following command

```
detect-secrets scan --update .secrets.baseline
```

While running the pre-commit hook, if you encounter an error like

```
WARNING: You are running an outdated version of detect-secrets.
Your version: 0.13.1+ibm.27.dss
Latest version: 0.13.1+ibm.46.dss
See upgrade guide at https://ibm.biz/detect-secrets-how-to-upgrade
```

run below command

```
pre-commit autoupdate
```
which upgrades all the pre-commit hooks present in .pre-commit.yaml file.

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