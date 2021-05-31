#####################################################
# vpc cluster worker-pool configure
# Copyright 2020 IBM
#####################################################

output "vpc_worker_pool_id" {
  description = "The ID of the worker pool"
  value       = ibm_container_vpc_worker_pool.pool.id
}