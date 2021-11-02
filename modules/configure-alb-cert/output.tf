#####################################################
# ibm_container_alb_cert - Used to create SSL certificate that
# you store in IBM Cloud Certificate Manager for an Ingress Application Load Balancer (ALB).
# Copyright 2020 IBM
#####################################################

output "id" {
  description = "The unique identifier of the certificate in the format <cluster_name_id>/<secret_name>"
  value       = ibm_container_alb_cert.cert.id
}

output "certificate_manager_instance_id" {
  description = "The IBM Cloud Certificate Manager instance ID from which the certificate was downloaded."
  value       = ibm_container_alb_cert.cert.cloud_cert_instance_id
}

output "status" {
  description = "The Status of the secret."
  value       = ibm_container_alb_cert.cert.status
}
