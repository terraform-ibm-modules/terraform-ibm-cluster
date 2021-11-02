#####################################################
# ibm_container_alb_cert - Used to create SSL certificate that
# you store in IBM Cloud Certificate Manager for an Ingress Application Load Balancer (ALB).
# Copyright 2020 IBM
#####################################################

provider "ibm" {
}

module "container_alb_cert" {
  //Uncomment the following line to make the source point to registry level
  //source = "terraform-ibm-modules/cluster/ibm//modules/configure-alb-cert"

  source = "../../modules/configure-alb-cert"

  certificate_crn = var.certificate_crn
  secret_name     = var.secret_name
  cluster         = var.cluster
  namespace       = var.namespace
  persistence     = var.persistence
}