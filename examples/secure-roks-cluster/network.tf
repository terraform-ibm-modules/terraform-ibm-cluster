module "vpc" {
  source  = "terraform-ibm-modules/vpc/ibm//modules/vpc"
  version = "1.0.0"

  name              = "${var.resource_prefix}-vpc"
  resource_group_id = data.ibm_resource_group.resource_group.id
}
module "subnet" {
  source  = "terraform-ibm-modules/vpc/ibm//modules/subnet"
  version = "1.0.0"

  for_each            = toset(local.zones)
  name                = "${var.resource_prefix}-subnet-${index(local.zones, each.value)}"
  vpc_id              = module.vpc.vpc_id
  resource_group_id   = data.ibm_resource_group.resource_group.id
  location            = each.value
  number_of_addresses = 256
}
module "security_group" {
  source  = "terraform-ibm-modules/vpc/ibm//modules/security-group"
  version = "1.0.0"

  create_security_group = true
  name                  = "${var.resource_prefix}-sg"
  vpc_id                = module.vpc.vpc_id
  resource_group_id     = data.ibm_resource_group.resource_group.id
  security_group_rules  = local.sg_rules
}
module "custom_sg_rules" {
  source  = "terraform-ibm-modules/vpc/ibm//modules/security-group"
  version = "1.0.0"

  create_security_group = false
  resource_group_id     = data.ibm_resource_group.resource_group.id
  security_group        = module.security_group.security_group_id[0]
  security_group_rules  = local.custom_sg_rules
}