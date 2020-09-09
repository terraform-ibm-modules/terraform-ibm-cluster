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
		labels            = var.labels
		entitlement       = var.entitlement
    	for_each          = var.worker_zones

		zones {
			name      = each.key
			subnet_id = each.value["subnet_id"]
		}
}