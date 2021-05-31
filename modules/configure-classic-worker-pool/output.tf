#####################################################
# classic kubernetes worker-pool configure
# Copyright 2020 IBM
#####################################################

output "classic_worker_pool_id" {
  description = "The ID of the worker pool"
  value       = ibm_container_worker_pool.pool.id
}