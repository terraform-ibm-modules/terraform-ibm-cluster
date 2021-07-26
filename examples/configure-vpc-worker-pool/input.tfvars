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

worker_pools = {
  pool_name_1 = {
    flavor = "bx2.16.64"
    worker_count = 1
  }
  pool_name_2 = {
    flavor = "bx2.4x16"
    worker_count = 1
  }
}

******************************************************/

worker_zones = {
  us-south-2 = {
    subnet_id = "0727-8b3e0eb1-7769-4972-a997-2f46893d4089"
  }
}

worker_pool_data = {
  w1 = {
    flavor       = "bx2.8x32"
    worker_count = 1
  }
}