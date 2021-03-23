#####################################################
# vpc cluster worker-pool configure
# Copyright 2020 IBM
#####################################################

resource "ibm_container_vpc_worker_pool" "test_pool" {
		cluster           = var.cluster_name
		worker_pool_name  = var.worker_pool_name
		flavor            = var.flavor
		vpc_id            = var.virtual_private_cloud
		worker_count      = var.worker_nodes_per_zone
		resource_group_id = var.resource_group_id
		labels            = (var.labels != null ? var.labels : null )
		entitlement       = (var.entitlement != null ? var.entitlement : null)
		
    	dynamic zones {
            for_each = (var.worker_zones != null ? var.worker_zones : {} ) 
            content {
                name             = zones.key
                subnet_id        = zones.value.subnet_id
            }
        }
}