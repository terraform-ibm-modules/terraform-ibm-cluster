# Opt-Out Integrations on IBM Cloud cluster

Use this IBM Cloud Provider Plug-in for Terraform template to integrate Logging, Monitoring on IBM Cloud Clusters
## Template functionalities

1. [main.tf](main.tf)

    - Integrates the cluster with an IBM Cloud Log Analysis instance.
    - Integrates the cluster with an IBM Cloud Monitoring instance.

## Inputs

Review the following variables that you can customize in your Terraform templates to create the related IBM Cloud resources for your secure OpenShift cluster.

|Name|Description|Type|Default|Required|
|-----|----------|----|-------|--------|
|ibmcloud_api_key|[IBM Cloud IAM API key](https://cloud.ibm.com/docs/account?topic=account-userapikey#create_user_key).|string|N/A|Yes|
|cluster|Id of the cluster.|string|N/A|Yes|
|monitoring_instance| GUID of the IBM Cloud Monitoring instance. If set to `null`, an instance is created with the following naming convention: `<var.resource_prefix>-sysdig`|string|`null`|No|
|monitoring_access_key|The IBM Cloud Monitoring ingestion key that you want to use for your configuration.|string|N/A|No|
|logging_instance|GUID of IBM Cloud Log Analysis instance. If set to `null`, an instance is created with the following naming convention: `<var.resource_prefix>-logdna`|string|`null`|No|
|logging_ingestion_key|The IBM Cloud Log Analysis ingestion key that you want to use for your configuration.|string|N/A|No|
|private_endpoint|Add this option to connect to your Log Analysis and Monitoring service instances through the private cloud service endpoint.|bool|N/A|No|

## Usage

```bash
terraform init

terraform plan

terraform apply

terraform destroy
```
