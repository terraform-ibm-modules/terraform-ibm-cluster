# Module container_alb

This example is used to enable or disable an Ingres application load balancer (ALB) that is set up in your cluster. ALBs are used to set up HTTP or HTTPS load-balancing for containerized apps that are deployed into an IBM Cloud Kubernetes Service or Red Hat OpenShift on IBM Cloud cluster. For more information, about Ingress ALBs, [see](https://cloud.ibm.com/docs/containers?topic=containers-ingress-about)

## Example Usage
```
provider "ibm" {
}

module "container_alb" {
  //Uncomment the following line to make the source point to registry level
  //source = "terraform-ibm-modules/cluster/ibm//modules/configure-alb"

  source = "../../modules/configure-alb"

  alb_id = var.alb_id
  enable = var.enable
  region = var.region
  user_ip = var.user_ip
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
| user_ip                      |For a private ALB only. The private ALB is deployed with an IP address from a user-provided private subnet. |string| n/a  | no  |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Usage
```
terraform init

terraform plan

terraform apply
```
