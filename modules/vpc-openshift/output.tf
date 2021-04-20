#####################################################
# vpc openshift cluster
# Copyright 2020 IBM
#####################################################

output "vpc_openshift_cluster_id" {
  description = "The ID of the cluster"
  value       = ibm_container_vpc_cluster.cluster.id
}