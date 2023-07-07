#####################################################
# Openshift cluster route provisioning
# Copyright 2021 IBM
#####################################################

/***************************************************
NOTE: To source a particular version of IBM terraform provider, configure the parameter `version` as follows

terraform {
  required_version = ">=0.15.3"
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
      version = "1.54.0"
    }
  }
}

If we dont configure the version parameter, it fetches the latest provider version.
****************************************************/

terraform {
  required_providers {
    restapi = {
      source  = "fmontezuma/restapi"
      version = "1.14.1"
    }
    ibm = {
      source = "IBM-Cloud/ibm"
    }
  }
}