# FS Cloud Compliant Secure Cluster

## PHASE-1

|Status|Requirement|template|
|------|-----------|--------|
|[ Done ]| roks-on-vpc|[main.tf](main.tf)|
|[ Done ]| tools to manage, alert and monitor|[logging.tf](logging.tf) & [monitoring.tf](monitoring.tf)|
|[ ]| default deny on inbound /outbound ,any, any - until the tunnel comes up | N/A|
|[ Done ]| clarity on how customers use their own keys |[kms.tf](kms.tf)|
|[ ]| Privileged ports should be blocked. | N/A|
|[ In Progress ]| Improved network policies should be published and applied by default for FS Cloud customers.|[network.tf](network.tf)|
|[ Done ]| Logging and monitoring should be set secure by default and pointed to the IBM Cloud default product, with appropriate retention levels for FS Cloud.|[logging.tf](logging.tf) & [monitoring.tf](monitoring.tf)|

## Template Functionalities

1. [main.tf](main.tf)

    - Provisions a multizone VPC ROKS Cluster with 3 worker nodes in each zone. (default worker pool - one zone, additional worker pool with two zones).
    - Integrates Cluster with the Logging Instance.
    - Integrates Cluster with Monitoring Instance.
    - Enables Key Management Service (Key Protect).
    - Retrieves Existing Object Storage Details and uses COS Instance while Provisioning Cluster

2. [logging.tf](logging.tf) - Provisions / Retieves LogDNA instance.

3. [monitoring.tf](monitoring.tf) - Provisions / Retieves Sysdig instance.

4. [kms.tf](kms.tf) - Retrieves Existing Key Protect Instance and Key Details

5. [network.tf](network.tf)

    - Provisions VPC.
    - Provisions Subnets on all three zones.
    - Defines Set of Security Group Rules. (**More Clarification is required on Rules**)
6. [iam.tf](iam.tf) - Provides Necessary IAM Authorisation Policies.

## Inputs

|Name|Description|Type|Default|Required|
|-----|----------|----|-------|--------|
|ibmcloud_api_key|IBM-Cloud API Key|string|N/A|Yes|
|ibm_region|IBM-Cloud Region|string|N/A|Yes|
|resource_group|Name of Resource Group. If null default resource group is considered|string|N/A|No|
|cos_instance_name|Name of Object Storage Instance|string|N/A|Yes|
|resource_prefix|Prefix to the resource names|string|N/A|Yes|
|flavor|The flavor of the VPC Cluster or worker node.|string|`bx2.4x16`|No|
|ocp_version|Specify the Openshift version|string|`4.6.23_1540_openshift`|No|
|ocp_entitlement|Value that is applied to the entitlements for OCP cluster provisioning|string|N/A|Yes|
|disable_public_service_endpoint|Disable the public service endpoint to prevent public access to the master.|bool|false|No|
|worker_nodes_per_zone|The number of worker nodes per zone.|number|3|No|
|create_timeout|Custom Creation timeout for Cluster|string|N/A|No|
|roks_kms_policy|Determinies if Kubernetes to KMS Service Authorisation policy.If false it creates policy between services|bool|true|No|
|kms_instance|Name of Key Protect Instance|string|N/A|No|
|kms_key|Name of Key Protect Key|string|N/A|No|
|sysdig_name|"Name of Sysdig Instance. If null it creates an instance with `<var.resource_prefix>-sysdig`|string|N/A|No|
|sysdig_access_key|The sysdig monitoring ingestion key that you want to use for your configuration|string|N/A|No|
|logDNA_name|Name of logDNA_name Instance. If null it creates an instance with `<var.resource_prefix>-logdna`|string|N/A|No|
|logdna_ingestion_key|The LogDNA ingestion key that you want to use for your configuration|string|N/A|No|
|private_endpoint|Add this option to connect to your Sysdig and logDNA service instance through the private service endpoint.|string|N/A|No|

### Note: If kms_instance, kms_key are not provided, KMS will not be enabled on the Cluster

## Usage

```bash
terraform init

terraform plan

terraform apply

terraform destroy
```
