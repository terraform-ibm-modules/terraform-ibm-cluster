# Module container_alb_cert

This example is used to SSL certificate that you store in IBM Cloud Certificate Manager for an Ingress Application Load Balancer (ALB). For more information, about container ALB certificate, see [setting up Kubernetes Ingress](https://cloud.ibm.com/docs/containers?topic=containers-ingress-types).

## Example Usage
```
provider "ibm" {
}

module "container_alb_cert" {
  //Uncomment the following line to make the source point to registry level
  //source = "terraform-ibm-modules/cluster/ibm//modules/configure-alb-cert"

  source = "../../modules/configure-alb-cert"

  certificate_crn    = var.certificate_crn
  secret_name = var.secret_name
  cluster  = var.cluster
  namespace = var.namespace
  persistence = var.persistence
}
```
## NOTE:

If we want to make use of a particular version of module, then set the "version" argument to accordingly.


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name          | Description                                           | Type   | Default        | Required |
|---------------|-------------------------------------------------------|--------|----------------|----------|
| certificate_crn      | The CRN of the certificate                            | string | n/a            | yes      |
| secret_name   | The name of the ALB certificate secret.               | string | n/a            | yes      |
| cluster    | ID or name of the cluster that hosts the Ingress ALB      | string | n/a            | yes      |
| namespace     | The namespace in which the secret is created          | string | ibm-cert-store | no       |
| persistence   | Persist the secret data in your cluster.              | bool   | n/a            | no       |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Usage
```
terraform init

terraform plan

terraform apply
```
