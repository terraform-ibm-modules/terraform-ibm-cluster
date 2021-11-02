#####################################################
# classic kubernetes multi-zone cluster provisioning
# Copyright 2020 IBM
#####################################################

/****************************************************
Example Usage -  configuaring multiple zones

worker_zones = {
    <zone_name_1> = {
      public_vlan = "<public_vlan_id>"
      private_vlan = "<private_vlan_id>"
    }
    <zone_name_2> = {
      public_vlan = "<public_vlan_id>"
      private_vlan = "<private_vlan_id>"
    }
}

******************************************************/

worker_zones = {
  dal12 = {
    public_vlan  = "2949448"
    private_vlan = "2949450"
  }
}

taints = [{
  key    = "dedicated"
  value  = "edge"
  effect = "NoSchedule"
  },
]