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
      subnet_id = "0717-0d4f6c2d-8ec0-422f-a9ea-a7b773887f8c"
    }
}



kms_config = [{
       instance_id      = "12043812-757f-4e1e-8436-6af3245e6a69"
       crk_id           = "0792853c-b9f9-4b35-9d9e-ffceab51d3c1"
       private_endpoint = false
     },
]




tags = ["T1","T2"]