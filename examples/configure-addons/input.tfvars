#####################################################
# Configure Add-ons to a cluster
# Copyright 2020 IBM
#####################################################

/****************************************************
Example Usage -  configuaring multiple add_ons

add_ons = {
    <add_on_name_1> = {
      version = "<version_number_1>"
    }
    <add_on_name_2> = {
      version = "<version_number_2>"
    }
}

******************************************************/

add_ons = {
  istio = {
    version = "1.7"
  }
}