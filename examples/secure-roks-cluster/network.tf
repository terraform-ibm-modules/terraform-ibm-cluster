module "vpc" {
  source  = "terraform-ibm-modules/vpc/ibm//modules/vpc"
  version = "1.0.0"

  name              = "${var.resource_prefix}-vpc"
  resource_group_id = data.ibm_resource_group.resource_group.id
}
module "subnet" {
  source  = "terraform-ibm-modules/vpc/ibm//modules/subnet"
  version = "1.0.0"

  for_each          = toset(local.zones)
  name              = "${var.resource_prefix}-subnet-${index(local.zones, each.value)}"
  vpc_id            = module.vpc.vpc_id
  resource_group_id = data.ibm_resource_group.resource_group.id
  location          = each.value
  ip_range          = element(var.ip_ranges, index(local.zones, each.value))
}

module "custom_sg_rules" {
  source  = "terraform-ibm-modules/vpc/ibm//modules/security-group"
  version = "1.0.0"

  create_security_group = false
  resource_group_id     = data.ibm_resource_group.resource_group.id
  security_group        = module.vpc.vpc_default_security_group
  security_group_rules  = local.custom_sg_rules
}