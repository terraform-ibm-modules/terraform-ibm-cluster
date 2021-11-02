# Claasic kubernets multi-zone cluster

## Template Functionalities

1. [main.tf](main.tf)

    - Provisions a classic kubernetes multi zone cluster with one worker node per zone.
    - Integrates Cluster with the Logging Instance.
    - Integrates Cluster with Monitoring Instance.

2. [logging.tf](logging.tf) - Provisions / Retrieves LogDNA instance.

3. [monitoring.tf](monitoring.tf) - Provisions / Retieves Sysdig instance.


## Inputs

| Name                              | Description                                                    | Type   | Default | Required |
|-----------------------------------|----------------------------------------------------------------|--------|---------|----------|
| cluster\_name                     | Name of the cluster                                            | string | n/a     | yes      |
| metro                             | The zone where the worker node is created.                     | string | n/a     | yes      |
| hardware                          | The level of hardware isolation for your worker node.          | string | n/a     | yes      |
| worker\_zones                     | Map(Map(zones)) where each zone has its public & private VLANs | map    | n/a     | yes      |
| resource\_group                   |  Name of the resource group.                                   | string | n/a     | no       |
| worker\_nodes\_per\_zone          | Number of workser nodes.                                       | number | 1       | no       |
| worker\_pool\_flavor              | The machine type for your worker node.                         | string | n/a     | no       |
| public\_vlan\_id                  | The ID of the public VLAN                                      | string | n/a     | no       |
| private\_vlan\_id                 | The ID of the private VLAN.                                    | string | n/a     | no       |
| master\_service\_public\_endpoint | Used to enable the public service endpoint.                    | string | n/a     | no       |
| master\_service\_private\_endpoint| Used to enable the private service endpoint.                   | string | n/a     | no       |
| force\_delete\_storage            | Set to delete persistent storage of cluster                    | bool   | false   | no       |
| gateway\_enabled                  | Set to to  create a gateway-enabled cluster.                   | bool   | false   | no       |
| encrypt\_local\_disk              | On set, worker node disks are encrypted with AES 256           | bool   | true    | no       |
| subnet\_id                        | List of subnets                                                | list   | n/a     | no       |
| update\_all\_workers              | Kubernetes version of the worker nodes is updated              | bool   | false   | no       |
| tags                              | List of tags to attach                                         | list   | n/a     | no       |
| kube\_version                     | Kubernetes version                                             | string | n/a     | no       |
| wait_till_albs                    | Use to avoid long wait cluster creation time                   | bool   | n/a     | no       |
| create_timeout                    | Timeout duration for creation                                  | string | n/a     | no       |
| update_timeout                    | Timeout duration for updation                                  | string | n/a     | no       |
| delete_timeout                    | Timeout duration for deletion                                  | string | n/a     | no       |
| worker\_nodes                     | Number of worker nodes.                                        | number | n/a     | yes      |
| flavor                            | The machine type for your worker node.                         | string | n/a     | yes      |
| worker\_pool\_name                | Name of the worker pool                                        | string | n/a     | yes      |
| encrypt\_local\_disk              | Set this to encrypt th elocal disk                             | string | n/a     | no       |
| labels                            | labels to add to the worker nodes in the worker pool           | map    | n/a     | no       |
| sysdig\_name                      | Name of the sysdig to attach to a cluster.                     | string | n/a     | yes      |
| region                            | Region where sysdig is provisioned.                            | string | n/a     | no       |
| private_endpoint                  | Use to connect to LogDNA instance through private endpoint     | bool   | n/a     | no       |
| sysdig_access_key                 | sysdig access key                                              | string | n/a     | no       |
| logDNA_name                       | Name of the logdna to attach to a cluster.                     | string | n/a     | yes      |
| logdna_ingestion_key              | LogDNA ingestion key                                           | string | n/a     | no       |
| taints                            |A nested block that sets or removes Kubernetes taints for all worker nodes in a worker pool|list(string)| n/a  | no  |


## taints Inputs

| Name                | Description                                           | Type   | Default | Required |
|---------------------|-------------------------------------------------------|--------|---------|----------|
|  key                | Key for taint.                                        | string | n/a     | yes      |
|  value              | Value for taint.                                      | string | n/a     | yes      |
|  private_endpoint   | Effect for taint. Accepted values are NoSchedule, PreferNoSchedule, and NoExecute| string   | n/a     | yes       |


## Usage

```bash
terraform init

terraform plan

terraform apply

terraform destroy
```
