module "roks_kms_authorisation_policy" {
  source              = "terraform-ibm-modules/iam/ibm//modules/service-authorization"
  count               = var.roks_kms_policy ? 0 : 1
  source_service_name = "containers-kubernetes"
  target_service_name = "kms"
  roles               = ["Reader"]
}
