#####################################################
# Configure logdna to a cluster
# Copyright 2020 IBM
#####################################################

resource "ibm_ob_logging" "logging" {
  cluster              = var.cluster
  instance_id          = var.logdna_instance_id
  private_endpoint     = var.private_endpoint != null ? var.private_endpoint : null
  logdna_ingestion_key = var.logdna_ingestion_key != null ? var.logdna_ingestion_key : null
}
