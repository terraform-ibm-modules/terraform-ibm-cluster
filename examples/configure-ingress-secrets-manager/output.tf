# SM Instance
output "ibm_sm_instance" {
  value       = ibm_container_ingress_instance.instance
  description = "The created IBM Cloud Secrets Manager instance"
}

// This allows sm_secret_group data to be referenced by other resources and the terraform CLI
// Modify this if only certain data should be exposed
output "ibm_sm_secret_group" {
  value       = ibm_sm_secret_group.sm_secret_group
  description = "sm_secret_group resource instance"
}

# SM arbitrary secret
# This allows sm_arbitrary_secret data to be referenced by other resources and the terraform CLI
# Modify this if only certain data should be exposed
output "ibm_sm_arbitrary_secret" {
  value       = ibm_sm_arbitrary_secret.sm_arbitrary_secret
  description = "sm_arbitrary_secret resource instance"
  sensitive   = true
}

# SM username password secret
# This allows sm_username_password_secret data to be referenced by other resources and the terraform CLI
# Modify this if only certain data should be exposed
output "ibm_sm_username_password_secret" {
  value       = ibm_sm_username_password_secret.sm_username_password_secret
  description = "sm_username_password_secret resource instance"
  sensitive   = true

}

# Ingress Opaque Secret
# This allows ibm_container_ingress_secret_opaque data to be referenced by other resources and the terraform CLI
# Modify this if only certain data should be exposed
output "ibm_container_ingress_secret_opaque" {
  value       = ibm_container_ingress_secret_opaque.secret_opaque
  description = "ibm_container_ingress_secret_opaque ingress secret"
}