resource "ibm_iam_authorization_policy" "kms_authorisation_policy" {
  count               = var.roks_kms_policy ? 0 : 1
  source_service_name = "containers-kubernetes"
  target_service_name = "kms"
  roles               = ["Reader"]
}
