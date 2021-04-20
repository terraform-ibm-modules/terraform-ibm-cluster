#####################################################
# classic Kubernetes multi-zone cluster
# Copyright 2020 IBM
#####################################################

output "container_cluster_id" {
  description = "The ID of the cluster"
  value       = ibm_container_cluster.cluster.id
}

