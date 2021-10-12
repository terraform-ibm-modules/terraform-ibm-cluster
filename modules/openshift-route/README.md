# This module is used to create openshift route

This module is used to provision a route to an openshift cluster. An [OpenShift route](https://docs.openshift.com/enterprise/3.0/architecture/core_concepts/routes.html) is a way to expose a service by giving it an externally-reachable hostname like www.example.com.

## Prerequisite

* Set up the IBM Cloud command line interface (CLI), the Satellite plug-in, and other related CLIs.
* Install cli and plugin package
```console
    ibmcloud plugin install container-service
```
## Usage

```
terraform init
```
```
terraform plan
```
```
terraform apply
```
```
terraform destroy
```
## Example Usage

``` hcl
module "openshift-route" {
  source = "github.com/terraform-ibm-modules/terraform-ibm-cluster//modules/openshift-route"

  ibmcloud_api_key    = var.ibmcloud_api_key
  cluster_service_url = var.cluster_service_url
  namespace           = var.namespace
  route_data          = var.route_data
}
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Note

* To update a openshift route, users has to get "resourceVersion" parameter value from terraform.tfstate or openshift console file and add it to 'route_data' variable as a route specification.

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
* If we want to make use of a particular version of module, then set the argument "version" to respective module version

## Inputs

| Name                     | Description                                                    | Type   |Default  |Required |
|--------------------------|----------------------------------------------------------------|:-------|:--------|:--------|
| ibmcloud_api_key         | IBM Cloud IAM API key                                          |`string`| n/a     | yes     |
| cluster_service_url      | Cluster service URL                                            |`string`| n/a     | yes     |
| namespace                | Openshift namespace name                                       |`string`| default | no      |
| route_data               | Route specification                                            |`string`| n/a     | yes     |

## Outputs

| Name                     | Description                |
|--------------------------|----------------------------|
| route_response           | Route response             |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->