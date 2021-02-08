#####################################################
# Configure Sysdif monitor to a cluster
# Copyright 2020 IBM
#####################################################

/***************************************************
NOTE: To source a particular version of IBM terraform provider, configure the parameter `version` as follows 

terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
      version = "1.20.0"
    }
  }
}

If we dont configure the version parameter, it fetches the latest provider version.
****************************************************/

terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
    }
  }
}