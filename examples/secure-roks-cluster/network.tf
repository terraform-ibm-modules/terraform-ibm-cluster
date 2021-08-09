module "vpc" {
  source  = "terraform-ibm-modules/vpc/ibm//modules/vpc"
  version = "1.0.0"

  name              = "${var.resource_prefix}-vpc"
  resource_group_id = data.ibm_resource_group.resource_group.id
  tags              = ["secure-roks", var.resource_prefix]
}
module "subnet" {
  source  = "terraform-ibm-modules/vpc/ibm//modules/subnet"
  version = "1.0.0"

  for_each            = toset(local.zones)
  name                = "${var.resource_prefix}-subnet-${index(local.zones, each.value)}"
  vpc_id              = module.vpc.vpc_id
  resource_group_id   = data.ibm_resource_group.resource_group.id
  location            = each.value
  ip_range            = (var.number_of_addresses == null && var.ip_ranges != null ? element(var.ip_ranges, index(local.zones, each.value)) : null)
  number_of_addresses = (var.number_of_addresses != null && var.ip_ranges == null ? var.number_of_addresses : null)
}

data "ibm_is_subnet" "subnet" {
  depends_on = [module.subnet]
  for_each   = toset(local.zones)
  name       = "${var.resource_prefix}-subnet-${index(local.zones, each.value)}"
}

module "default_sg_rules" {
  source  = "terraform-ibm-modules/vpc/ibm//modules/security-group"
  version = "1.0.0"

  create_security_group = false
  security_group        = module.vpc.vpc_default_security_group
  resource_group_id     = data.ibm_resource_group.resource_group.id
  security_group_rules  = local.sg_rules
}
data "ibm_is_vpc" "vpc" {
  depends_on = [module.vpc]
  name       = "${var.resource_prefix}-vpc"
}
data "ibm_iam_auth_token" "token" {}

// null resource to remove allow all outbound rule
resource "null_resource" "delete_default_egress_security_rule" {
  provisioner "local-exec" {
    environment = {
      TOKEN               = data.ibm_iam_auth_token.token.iam_access_token
      REGION              = var.region
      SECURITY_GROUP      = module.vpc.vpc_default_security_group
      SECURITY_GROUP_RULE = length(local.default_egress_rule) != 0 ? local.default_egress_rule[0] : ""
    }
    command = <<EOT
          curl -X DELETE "https://$REGION.iaas.cloud.ibm.com/v1/security_groups/$SECURITY_GROUP/rules/$SECURITY_GROUP_RULE?version=2021-08-03&generation=2" -H "Authorization: $TOKEN"
        EOT
  }
}
module "custom_sg_rules" {
  source  = "terraform-ibm-modules/vpc/ibm//modules/security-group"
  version = "1.0.0"

  create_security_group = false
  resource_group_id     = data.ibm_resource_group.resource_group.id
  security_group        = module.vpc.vpc_default_security_group
  security_group_rules  = local.custom_sg_rules
}