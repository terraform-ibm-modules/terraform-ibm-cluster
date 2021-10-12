#####################################################
# Openshift cluster route provisioning
# Copyright 2021 IBM
#####################################################

locals {
  # get json
  data = jsondecode(var.route_data)
}

###################################################################
# Generate openshift token to file
###################################################################
resource "null_resource" "get_oc_token" {
  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<-EOT
      curl -u "apikey:${var.ibmcloud_api_key}" -H "X-CSRF-Token: a" "$(curl ${var.cluster_service_url}/.well-known/oauth-authorization-server | jq -r .issuer)/oauth/authorize?client_id=openshift-challenging-client&response_type=token" -vvv &> /dev/stdout | tee -a resp.log
      token=$(awk -v FS="(#access_token=|&expires_in)" '{print $2}' resp.log)
      echo $token > token.log
      rm -f resp.log
    EOT
  }
}

###################################################################
# Read openshift token from file
###################################################################
data "local_file" "token_file" {
  filename = "token.log"

  depends_on = [null_resource.get_oc_token]
}

###################################################################
# Provision openshift route
###################################################################
resource "restapi_object" "create_route" {
  object_id = local.data.metadata.name
  path      = "/apis/route.openshift.io/v1/namespaces/${var.namespace}/routes"
  data      = var.route_data

  depends_on = [null_resource.get_oc_token]
}