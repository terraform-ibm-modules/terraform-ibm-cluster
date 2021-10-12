#####################################################
# Openshift cluster route provisioning
# Copyright 2021 IBM
#####################################################

output "route_response" {
  value = restapi_object.create_route.api_response
}
