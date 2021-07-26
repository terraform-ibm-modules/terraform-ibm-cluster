#####################################################
# vpc cluster worker-pool configure
# Copyright 2020 IBM
#####################################################

output "vpc_worker_pool_ids" {
  description = "List of worker pool IDs"
  value = toset([
    for wp in ibm_container_vpc_worker_pool.pool : wp.id
  ])
}