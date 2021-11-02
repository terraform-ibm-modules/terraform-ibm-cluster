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
  us-south-1 = {
    subnet_id = "0717-0d4f6c2d-8ec0-422f-a9ea-a7b773887f8c"
  }
}

taints = [{
  key    = "dedicated"
  value  = "edge"
  effect = "NoSchedule"
  },
]