#####################################################
# Openshift cluster route provisioning
# Copyright 2021 IBM
#####################################################

output "route_response" {
  value = module.openshift_cluster_route.route_response
}