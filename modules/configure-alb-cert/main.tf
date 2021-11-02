#####################################################
# ibm_container_alb_cert - Used to create SSL certificate that
# you store in IBM Cloud Certificate Manager for an Ingress Application Load Balancer (ALB).
# Copyright 2020 IBM
#####################################################

resource "ibm_container_alb_cert" "cert" {
  cert_crn    = var.certificate_crn
  secret_name = var.secret_name
  cluster_id  = var.cluster
  namespace   = var.namespace != null ? var.namespace : null
  persistence = var.persistence != null ? var.persistence : null
}