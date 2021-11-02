# Module container_vpc_alb

This example is used to enable or disable an Ingres application load balancer (ALB) that is set up in your VPC cluster. ALBs are used to set up HTTP or HTTPS load-balancing for containerized apps that are deployed into an IBM Cloud Kubernetes Service or Red Hat OpenShift on IBM Cloud cluster. For more information, about Ingress ALBs, [see](https://cloud.ibm.com/docs/containers?topic=containers-ingress-about)

## Example Usage
```
provider "ibm" {
}

data "ibm_resource_group" "rg" {
  name = var.resource_group
}

module "container_vpc_alb" {
  //Uncomment the following line to make the source point to registry level
  //source = "terraform-ibm-modules/cluster/ibm//modules/configure-vpc-alb"

  source = "../../modules/configure-vpc-alb"

  alb_id = var.alb_id
  enable = var.enable
  resource_group_id = data.ibm_resource_group.rg.id
}
```
## NOTE:

If we want to make use of a particular version of module, then set the "version" argument to accordingly.


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name                         | Description                                           | Type   | Default | Required |
|------------------------------|-------------------------------------------------------|--------|---------|----------|
| alb_id                       | The unique identifier of the ALB.                     | string | n/a     | yes      |
| enable                       |  If set to true, the default Ingress ALB in your cluster is enabled and configured with the IBM-provided Ingress subdomain. If set to false, the default Ingress ALB is disabled in your cluster.| bool | true    | no      |
| resource_group               |Name of the resource group.                             |string| n/a  | no  |


## Outputs

| Name            | Description                          | Type   |
|-----------------|--------------------------------------|--------|
| id              | The unique identifier of the ALB.    | string |
| alb_type        | The ALB type                         | string |
| name            | Name of the ALB.                     | string |
| cluster         | Name of the cluster.                 | string |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Usage
```
terraform init

terraform plan

terraform apply
```
