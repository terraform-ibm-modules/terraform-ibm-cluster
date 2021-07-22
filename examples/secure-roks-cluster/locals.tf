locals {
  cos_crn            = var.cos_instance_name != null ? data.ibm_resource_instance.cos_instance[0].id : ibm_resource_instance.cos_instance[0].id
  sysdig_instance_id = var.logdna_name != null ? data.ibm_resource_instance.sysdig_instance[0].guid : module.sysdig_instance[0].sysdig_guid
  logdna_instance_id = var.logdna_name != null ? data.ibm_resource_instance.logdna_instance[0].guid : module.logdna_instance[0].logdna_instance_guid
  zones              = [for index in range(3) : "${var.region}-${index + 1}"]
  worker_zones = {
    element(local.zones, 0) = {
      subnet_id = module.subnet[local.zones[0]].subnet_id
    }
  }
  pool_worker_zones = {
    for zone in slice(local.zones, 1, 3) :
    zone => {
      subnet_id = module.subnet[zone].subnet_id
    }
  }
  kms_config = var.kms_instance != null && var.kms_key != null ? [{
    instance_id      = data.ibm_resource_instance.kms_instance[0].guid
    crk_id           = data.ibm_kms_key.kms_key[0].keys[0].id
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
  rules = [
    {
      name      = "${var.resource_prefix}-ingress-1"
      direction = "inbound"
      tcp = {
        port_min = 30000
        port_max = 32767
      }
    },
    {
      name      = "${var.resource_prefix}-ingress-2"
      direction = "inbound"
      udp = {
        port_min = 30000
        port_max = 32767
      }
    },
    {
      name      = "${var.resource_prefix}-ingress-3"
      direction = "inbound"
      icmp = {
        type = 8
        code = null
      }
    },
    {
      name      = "${var.resource_prefix}-ingress-4"
      direction = "inbound"
      remote    = module.vpc.vpc_default_security_group
    },
    {
      name      = "${var.resource_prefix}-egress-1"
      direction = "outbound"
    }
  ]
}