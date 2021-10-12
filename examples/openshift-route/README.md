# Module openshift-route

This module is used to provision a route to an openshift cluster. An [OpenShift route](https://docs.openshift.com/enterprise/3.0/architecture/core_concepts/routes.html) is a way to expose a service by giving it an externally-reachable hostname like www.example.com.


## Example Usage

``` terraform
provider "ibm" {
}

locals {
    # get json
    data = jsondecode(var.route_data)
}

data "ibm_satellite_cluster" "cluster" {
  name  = var.cluster
}

module "openshift_cluster_route" {
  source = "github.com/terraform-ibm-modules/terraform-ibm-cluster//modules/openshift-route"

  ibmcloud_api_key    = var.ibmcloud_api_key
  cluster_service_url = data.ibm_satellite_cluster.cluster.server_url
  namespace           = var.namespace
  route_data          = var.route_data
}
```

## Note

* To update a openshift route, users has to get the "resourceVersion" parameter value from terraform.tfstate or openshift console file, And add it to 'route_data' variable as a route specification.

``` Route Specfication
{
   "kind":"Route",
   "apiVersion":"route.openshift.io/v1",
   "metadata":{
      "name":"route-01",
      "resourceVersion": "<resourceVersion>"
   },
	.....
	.....
}
```
* All optional fields are given value `null` in varaible.tf file. User can configure the same by overwriting with appropriate values.
* Provide `version` attribute in terraform block in versions.tf file to use specific version of terraform provider.


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name                     | Description                                                    | Type   |Default  |Required |
|--------------------------|----------------------------------------------------------------|:-------|:--------|:--------|
| ibmcloud_api_key         | IBM Cloud IAM API key                                          |`string`| n/a     | yes     |
| cluster                  | Cluster Name                                                   |`string`| n/a     | yes     |
| namespace                | Openshift namespace name                                       |`string`| default | no      |
| route_data               | Route specification                                            |`string`| n/a     | no      |

## Outputs

| Name                     | Description                |
|--------------------------|----------------------------|
| route_response           | Route response             |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Usage

Initialising Provider

Make sure you declare a required providers ibm block to make use of IBM-Cloud Terraform Provider

```terraform
terraform {
  required_providers {
    restapi = {
      source  = "fmontezuma/restapi"
      version = "1.14.1"
    }
    ibm = {
      source = "IBM-Cloud/ibm"
    }
  }
}
```

```bash
terraform init
terraform plan
terraform apply
```

Run `terraform destroy` when you don't need these resources.
