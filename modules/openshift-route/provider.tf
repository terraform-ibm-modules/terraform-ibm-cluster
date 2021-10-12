#####################################################
# Openshift cluster route provisioning
# Copyright 2021 IBM
#####################################################

provider "restapi" {
  uri   = var.cluster_service_url
  debug = true
  headers = {
    Authorization = format("Bearer %v", chomp(element(tolist(data.local_file.token_file.*.content), 0)))
  }
}