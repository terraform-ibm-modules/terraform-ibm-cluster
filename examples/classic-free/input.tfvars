########################################################
# kubernetes classic free cluster
# Copyright 2020 IBM
########################################################

taints = [{
  key    = "dedicated"
  value  = "edge"
  effect = "NoSchedule"
  },
]