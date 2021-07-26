# Secure ROKS Cluster

## PHASE-1

|Status|Requirement|template|
|------|-----------|--------|
|[ Done ]| roks-on-vpc|[main.tf](main.tf)|
|[ Done ]| tools to manage, alert and monitor|[logging.tf](logging.tf) & [monitoring.tf](monitoring.tf)|
|[ ]| default deny on inbound /outbound ,any, any - until the tunnel comes up | N/A|
|[ Done ]| clarity on how customers use their own keys |[kms.tf](kms.tf)|
|[ ]| Privileged ports should be blocked. | N/A|
|[ In Progress ]| Improved network policies should be published and applied by default for Secure ROKS Cluster.|[network.tf](network.tf)|
|[ Done ]| Logging and monitoring should be set secure by default and pointed to the IBM Cloud default product, with appropriate retention levels for Secure ROKS Cluster.|[logging.tf](logging.tf) & [monitoring.tf](monitoring.tf)|

## Template Functionalities

1. [main.tf](main.tf)

    - Provisions a multizone VPC ROKS Cluster with 3 worker nodes in each zone. (default worker pool - one zone, additional worker pool with two zones).
    - Integrates Cluster with the Logging Instance.
    - Integrates Cluster with Monitoring Instance.
    - Enables Key Management Service (Key Protect).
    - Integrates with COS Instance while Provisioning Cluster

2. [cos.tf](cos.tf) - Provisions / Retieves Object Storage Instance.

3. [logging.tf](logging.tf) - Provisions / Retieves LogDNA instance.

4. [monitoring.tf](monitoring.tf) - Provisions / Retieves Sysdig instance.

5. [kms.tf](kms.tf) - Retrieves Existing Key Protect Instance and Key Details

6. [network.tf](network.tf)

    - Provisions VPC.
    - Provisions Subnets on all three zones.
    - Defines Set of Security Group Rules on Default Security Group. (**More Clarification is required on Rules**)
    - Current Rules are as follows
        |Direction|Protocol|Port or Value|Source type|
        |----|-----|----------|----|
        |Inbound|tcp|30000-32767|any|
        |Inbound|udp|30000-32767|any|
        |Inbound|icmp|8|any|
        |Inbound|All|-|sg_group|
        |Outbound|All|-|-|
7. [iam.tf](iam.tf) - Provides Necessary IAM Authorisation Policies.

## Inputs

|Name|Description|Type|Default|Required|
|-----|----------|----|-------|--------|
|ibmcloud_api_key|IBM-Cloud API Key|string|N/A|Yes|
|region|IBM-Cloud Region|string|N/A|Yes|
|resource_group|Name of Resource Group. If `null` default resource group is considered|string|N/A|No|
|cos_instance_name|Name of Object Storage Instance. If `null` it creates an instance with `<var.resource_prefix>-cos`|string|`null`|No|
|resource_prefix|Prefix to the resource names|string|N/A|Yes|
|flavor|The flavor of the VPC Cluster or worker node.|string|`bx2.4x16`|No|
|ocp_version|Specify the Openshift version|string|`4.6.23_1540_openshift`|No|
|ocp_entitlement|Value that is applied to the entitlements for OCP cluster provisioning|string|N/A|Yes|
|disable_public_service_endpoint|Disable the public service endpoint to prevent public access to the master.|bool|true|No|
|worker_nodes_per_zone|The number of worker nodes per zone.|number|3|No|
|create_timeout|Custom Creation timeout for Cluster|string|N/A|No|
|roks_kms_policy|Determinies if Kubernetes to KMS Service Authorisation policy.If false it creates policy between services|bool|true|No|
|kms_instance|Name of Key Protect Instance. If `null` it creates an instance with `<var.resource_prefix>-kp`|string|`null`|No|
|kms_key|Name of Key Protect Key. If `null` it creates an instance with `<var.resource_prefix>-kp-key`|string|`null`|No|
|standard_key_type|Determines if it is a standard key or not. This variable is only used during creation of KP Key in this module.|bool|`false`|No|
|sysdig_name|"Name of Sysdig Instance. If `null` it creates an instance with `<var.resource_prefix>-sysdig`|string|`null`|No|
|sysdig_access_key|The sysdig monitoring ingestion key that you want to use for your configuration|string|N/A|No|
|logdna_name|Name of logdna_name Instance. If `null` it creates an instance with `<var.resource_prefix>-logdna`|string|`null`|No|
|logdna_ingestion_key|The LogDNA ingestion key that you want to use for your configuration|string|N/A|No|
|private_endpoint|Add this option to connect to your Sysdig and logDNA service instance through the private service endpoint.|bool|true|No|
|activity_tracker_instance_name|Name of Activity Tracker Instance. If null it doesnt create activity tracker instance.|string|`null`|No|
|custom_sg_rules|Custom Security rules. Find `custom_sg_rules` object table for more info. |list(object)|[]|No|
|ip_ranges|Ordered List of ip_ranges on which subnets has to be created. If subnets are created in us-south region, elements in ip_ranges should be equivalent to respective ip range of [`us-south-1`, `us-south-2`, `us-south-3`]|list(string)||Yes|

### custom_sg_rules object

|Name|Description|Type|Default|Required|
|-----|----------|----|-------|--------|
|name|Name of Security Group Rule|string|N/A|Yes|
|direction|Direction of Security Group Rule (`inbound`/`outbound`)|string|N/A|Yes|
|remote|Security group id - an IP address, a CIDR block, or a single security group identifier.|string|N/A|No|
|ip_version|P version|string|N/A|no|
|icmp|A nested block describing the `icmp` protocol of this security group rule. Conflicts with `tcp` and `udp`|object|N/A|No|
|tcp|A nested block describing the `tcp` protocol of this security group rule. Conflicts with `icmp` and `udp`|object|N/A|No|
|udp|A nested block describing the `udp` protocol of this security group rule. Conflicts with `icmp` and `tcp`|object|N/A|No|

### icmp object

|Name|Description|Type|Default|Required|
|-----|----------|----|-------|--------|
|type|The ICMP traffic type to allow. Valid values from 0 to 254.|int|N/A|Yes|
|code|The ICMP traffic code to allow. Valid values from 0 to 255.|int|N/A|No|

### tcp object

|Name|Description|Type|Default|Required|
|-----|----------|----|-------|--------|
|port_min|The inclusive lower bound of TCP port range. Valid values are from 1 to 65535.|int|N/A|Yes|
|port_max|The inclusive upper bound of TCP port range. Valid values are from 1 to 65535.|int|N/A|Yes|

## udp object

|Name|Description|Type|Default|Required|
|-----|----------|----|-------|--------|
|port_min|The inclusive lower bound of UDP port range. Valid values are from 1 to 65535.|int|N/A|Yes|
|port_max|The inclusive upper bound of UDP port range. Valid values are from 1 to 65535.|int|N/A|Yes|

### Notes

- While creating custom security group rules, If any of the icmp , tcp or udp is not specified it creates a rule with protocol ALL.
- To create KMS Key using this template both `kms_instance` and `kms_key` should be `null`

## Usage

```bash
terraform init

terraform plan

terraform apply

terraform destroy
```
