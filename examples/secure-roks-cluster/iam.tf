# module "roks_kms_authorisation_policy" {
#   source              = "terraform-ibm-modules/iam/ibm//modules/service-authorization"
#   version             = "1.2.2"
#   count               = var.roks_kms_policy ? 0 : 1
#   source_service_name = "containers-kubernetes"
#   target_service_name = "kms"
#   roles               = ["Reader"]
# }

# LMA
resource "ibm_iam_authorization_policy" "kms_authorisation_policy" {
  count               = var.roks_kms_policy ? 0 : 1
  source_service_name = "containers-kubernetes"
  # source_resource_instance_id = module.vpc_ocp_cluster.id
  target_service_name = "kms"
  roles               = ["Reader"]
}
