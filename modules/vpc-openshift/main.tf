#####################################################
# vpc openshift cluster provisioning
# Copyright 2020 IBM
#####################################################

resource "ibm_container_vpc_cluster" "cluster" {

        name                            = var.cluster_name
        vpc_id                          = var.vpc_id
        flavor                          = var.worker_pool_flavor
        kube_version                    = var.kube_version
        update_all_workers              = var.update_all_workers
        service_subnet                  = var.service_subnet
        worker_count                    = var.worker_nodes_per_zone
        worker_labels                   = var.worker_labels
        disable_public_service_endpoint = var.disable_public_service_endpoint
        tags                            = var.tags
        wait_till                       = var.wait_till   
        cos_instance_crn                = var.cos_instance_crn
        force_delete_storage            = var.force_delete_storage
        resource_group_id               = var.resource_group_id
        entitlement                     = var.entitlement

        for_each = var.worker_zones
        zones {
               name              = each.key
               subnet_id         = each.value["subnet_id"]
        }

        dynamic kms_config {
          for_each = var.kms_config
            content {
                instance_id      = kms_config.value.instance_id
                crk_id           = kms_config.value.crk_id
                private_endpoint = (kms_config.value.private_endpoint ? true: false)
            }
        }   
}