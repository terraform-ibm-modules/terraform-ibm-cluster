#####################################################
# vpc openshift cluster provisioning
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
    subnet_id = "0717-edb7aee5-d252-4330-98ad-8c99e01a11b7"
  }
}



kms_config = [{
  instance_id      = "4b60eaa9-5a68-4ca7-bda3-23c41a3812af"
  crk_id           = "8191042a-f9fe-4ec3-a36b-991b40201176"
  private_endpoint = false
  },
]

taints = [{
  key    = "dedicated"
  value  = "edge"
  effect = "NoSchedule"
  },
]


tags = ["T1", "T2"]