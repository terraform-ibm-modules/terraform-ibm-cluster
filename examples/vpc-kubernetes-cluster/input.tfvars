#####################################################
# vpc kubernetes cluster provisioning
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
    <zone_name> = {
      subnet_id = "<subnetID>"
    }
}

kms_config = [{
       instance_id      = "<kms_instance_id>"
       crk_id           = "<root_key_id>"
       private_endpoint = <bool_value>
     },
]

tags = ["<Tag-1>","<Tag-2>"]