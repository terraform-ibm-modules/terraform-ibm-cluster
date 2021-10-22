########################################################
# kubernetes classic cluster worker pool configuration
# Copyright 2020 IBM
########################################################

/****************************************************
Example Usage

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

tags = ["T1", "T2"]

subnet_id = ["1147081"]
