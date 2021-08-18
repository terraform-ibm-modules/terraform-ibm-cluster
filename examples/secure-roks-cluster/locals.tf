locals {
  cos_crn            = var.cos_instance != null ? var.cos_instance : ibm_resource_instance.cos_instance[0].id
  sysdig_instance_id = var.monitoring_instance != null ? var.monitoring_instance : module.monitoring_instance[0].sysdig_guid
  logdna_instance_id = var.logging_instance != null ? var.logging_instance : module.logging_instance[0].logdna_instance_guid
  zones              = [for index in range(3) : "${var.region}-${index + 1}"]
  worker_zones = {
    for zone in local.zones :
    zone => {
      subnet_id = module.subnet[zone].subnet_id
    }
  }
  kms_config = var.kms_instance != null && var.kms_key != null ? [{
    instance_id      = var.kms_instance
    crk_id           = var.kms_key
    private_endpoint = true
    }] : [{
    instance_id      = module.kms[0].kms_instance_guid
    crk_id           = module.kms[0].kms_key_id
    private_endpoint = true
  }]
  timeouts = [{
    create = var.create_timeout
  }]
  sg_rules = [
    for r in local.rules : {
      name       = r.name
      direction  = r.direction
      remote     = lookup(r, "remote", null)
      ip_version = lookup(r, "ip_version", null)
      icmp       = lookup(r, "icmp", null)
      tcp        = lookup(r, "tcp", null)
      udp        = lookup(r, "udp", null)
    }
  ]
  rules = [
    {
      name      = "${var.resource_prefix}-ingress-1"
      direction = "inbound"
      tcp = {
        port_min = 22
        port_max = 22
      }
    },
    {
      name      = "${var.resource_prefix}-ingress-2"
      direction = "inbound"
      icmp = {
        type = 8
        code = null
      }
    },
    {
      name      = "${var.resource_prefix}-egress-1"
      direction = "outbound"
      remote    = module.vpc.vpc_default_security_group
    },
    {
      name      = "${var.resource_prefix}-egress-2"
      direction = "outbound"
      remote    = "161.26.0.0/16"
    },
    {
      name      = "${var.resource_prefix}-egress-3"
      direction = "outbound"
      remote    = "166.8.0.0/14"
    },
    {
      name      = "${var.resource_prefix}-egress-4"
      direction = "outbound"
      remote    = local.subnet_cidrs[0]
    },
    {
      name      = "${var.resource_prefix}-egress-5"
      direction = "outbound"
      remote    = local.subnet_cidrs[1]
    },
    {
      name      = "${var.resource_prefix}-egress-6"
      direction = "outbound"
      remote    = local.subnet_cidrs[2]
    }
  ]
  custom_sg_rules = [
    for r in var.custom_sg_rules : {
      name       = r.name
      direction  = r.direction
      remote     = lookup(r, "remote", null)
      ip_version = lookup(r, "ip_version", null)
      icmp       = lookup(r, "icmp", null)
      tcp        = lookup(r, "tcp", null)
      udp        = lookup(r, "udp", null)
    }
  ]
  default_egress_rule = [
    for _, rule in data.ibm_is_vpc.vpc.security_group[0].rules : rule.rule_id
    if rule.remote == "0.0.0.0/0" && rule.direction == "outbound" && rule.protocol == "all"
  ]
  subnet_cidrs = [for subnet in data.ibm_is_subnet.subnet : subnet.ipv4_cidr_block]
}
