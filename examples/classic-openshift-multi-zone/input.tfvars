#####################################################
# classic kubernetes multi-zone cluster provisioning
# Copyright 2020 IBM
#####################################################

/****************************************************
Example Usage

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

worker_zones = {
    dal12 = {
      public_vlan = "<public_vlan_id>"
      private_vlan = "<private_vlan_id>"
    }
}

kms_config = [{
       instance_id      = "<kms_instance_id>"
       crk_id           = "<root_key_id>"
       private_endpoint = <bool_value>
     },
]


workers_info = [{
       id           = "<worker_node-id>"
       version      = "<Kubernetes version that you want to update your worker nodes to>"
   },
]

webhook = [{
       level = "<Notification level, such as Normal or Warning>"
       type  = "<he webhook type. Currently, Slack is supported>"
       url   = "< The URL for the webhook.>"
   },
]

tags = ["<Tag-1>","<Tag-2>"]

subnet_id = ["<subnetID>"]



******************************************************/

worker_zones = {
  dal12 = {
    public_vlan  = "2949448"
    private_vlan = "2949450"
  }
}

kms_config = [{
  instance_id      = "12043812-757f-4e1e-8436-6af3245e6a69"
  crk_id           = "0792853c-b9f9-4b35-9d9e-ffceab51d3c1"
  private_endpoint = false
  },
]


workers_info = [{
  id      = "kube-btgbsard0ss76j8snblg-c2-default-000001a7"
  version = "4.3.23_openshift"
  },
]

webhook = [{
  level = "Normal"
  type  = "slack"
  url   = "https://hooks.slack.com/services/yt7rebjhgh2r4rd44fjk"
  },
]

taints = [{
  key    = "dedicated"
  value  = "edge"
  effect = "NoSchedule"
  },
]

tags = ["T1", "T2"]

subnet_id = ["1147081"]
