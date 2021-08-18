# Secure Red Hat OpenShift on IBM Cloud cluster

Use this IBM Cloud Provider Plug-in for Terraform template to create a Red Hat OpenShift on IBM Cloud cluster with certain secure settings enabled by default, such as the following.

* Creates a Virtual private network (VPC) for the cluster.
* Sets up worker nodes across zones for higher availability.
* Automatically enables forwarding logging and monitoring data to your observability instances.
* Encrypts the cluster secrets with your own Key Management Service provider key.

## Phase 1 status

Review the status of the templates in the following table.

|Status|Requirement|Template|
|------|-----------|--------|
|[ Done ]| Creating a Red Hat OpenShift on IBM Cloud cluster in a VPC.|[main.tf](main.tf)|
|[ Done ]| IBM Cloud Observability tools to manage, alert, and monitor the health of your cluster.|[logging.tf](logging.tf) & [monitoring.tf](monitoring.tf)|
|[ ]| Default deny on inbound/outbound,any, any - until the tunnel comes up. | N/A|
|[ Done ]| Clarity on how users can provide their own keys to manage encryption for the cluster. |[kms.tf](kms.tf)|
|[ ]| Block privileged ports. | N/A|
|[ In Progress ]| Document and apply default network policies for the VPC and cluster.|[network.tf](network.tf)|
|[ Done ]| Set up forwarding of cluster logs and metrics to IBM Cloud Monitoring and Log Analysis instances.|[logging.tf](logging.tf) & [monitoring.tf](monitoring.tf)|

## Template functionalities

1. [main.tf](main.tf)

    - Provisions a multizone Red Hat OpenShift on IBM Cloud cluster in a virtual private cloud (VPC) with 3 worker nodes in each zone. The `default` worker pool has 3 worker nodes in one zone. Another worker pool is created across the two other zones in the region, with three worker nodes per zone.
    - Integrates the cluster with an IBM Cloud Log Analysis instance.
    - Integrates the cluster with an IBM Cloud Monitoring instance.
    - Enables IBM Key Protect for IBM Cloud as the Key Management Service (KMS) provider for the cluster.
    - Integrates with an IBM Cloud Object Storage instance during cluster provisioning.

2. [cos.tf](cos.tf) - Provisions or retrieves the Object Storage instance.

3. [logging.tf](logging.tf) - Provisions or retrieves the Log Analysis instance.

4. [monitoring.tf](monitoring.tf) - Provisions or retrieves the Monitoring instance.

5. [kms.tf](kms.tf) - Retrieves an existing Key Protect instance and details about the root key.

6. [network.tf](network.tf)

    - Provisions a Virtual Private Cloud (VPC).
    - Provisions three VPC Subnets across three zones in the region.
    - Defines a set of Security Group rules on default security group and removes allow ALL default outbound rule.
    - Current Rules are shown in the following table. These rules are added before creating cluster.

        |Direction|Protocol|Port or Value|Source / Destination type|
        |----|-----|----------|----|
        |Inbound|tcp|22-22|any|
        |Inbound|icmp|8|any|
        |Outbound|All|-|sg_group|
        |Outbound|All|-|161.26.0.0/16|
        |Outbound|All|-|166.8.0.0/14|
        |Outbound|All|-|All three subnet CIDRS|


7. [iam.tf](iam.tf) - Sets up the required IAM service authorization policies between Kubernetes Service and Key Protect.

## Inputs

Review the following variables that you can customize in your Terraform templates to create the related IBM Cloud resources for your secure OpenShift cluster.

|Name|Description|Type|Default|Required|
|-----|----------|----|-------|--------|
|ibmcloud_api_key|[IBM Cloud IAM API key](https://cloud.ibm.com/docs/account?topic=account-userapikey#create_user_key).|string|N/A|Yes|
|region|[IBM Cloud region for the VPC cluster](https://cloud.ibm.com/docs/openshift?topic=openshift-regions-and-zones#zones-vpc).|string|N/A|Yes|
|resource_group|Name of the [IBM Cloud resource group](https://cloud.ibm.com/docs/account?topic=account-rgs) to create the resources in. If set to `null`, the default resource group is used.|string|`null`|No|
|cos_instance|CRN of the IBM Cloud Object Storage instance. If set to `null`, an instance is created with the following naming convention: `<var.resource_prefix>-cos`|string|`null`|No|
|resource_prefix|Prefix to use for created resource names.|string|N/A|Yes|
|flavor|The flavor for the VPC worker nodes to create in the cluster. To list available flavors, run `ibmcloud ks flavors --zone <vpc_region>-1`.|string|`bx2.4x16`|No|
|ocp_version|Specify the Red Hat OpenShift on IBM Cloud version. To list versions, run `ibmcloud ks versions`.|string|`4.6_openshift`|No|
|ocp_entitlement|The value that is used to decide how your worker nodes are entitled to run OpenShift Container Platform. For more information, see the [`--entitlement` option description in the docs](https://cloud.ibm.com/docs/openshift?topic=openshift-kubernetes-service-cli#cli_cluster-create-vpc-gen2).|string|N/A|Yes|
|disable_public_service_endpoint|Disable the public cloud service endpoint to prevent public access to the master.|bool|true|No|
|worker_nodes_per_zone|The number of worker nodes per zone.|number|3|No|
|create_timeout|Custom creation [timeout](https://www.terraform.io/docs/language/resources/syntax.html#operation-timeouts) for the cluster.|string|N/A|No|
|wait_till| The stage when you want Terraform to mark the cluster resource creation as completed. More details [here](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/container_vpc_cluster#wait_till)|string|`IngressReady`|No|
|roks_kms_policy|Indicates if a Kubernetes Service to Key Protect service authorization policy exists in IAM. If false, a policy between the services is created.|bool|true|No|
|kms_instance|GUID of the Key Protect instance to use to encrypt the secrets in the cluster. If set to `null`, an instance is created with the following naming convention: `<var.resource_prefix>-kp`|string|`null`|No|
|kms_key|Key ID of the root key in the Key Protect instance to use. If set to `null`, an instance is created with the following naming convention: `<var.resource_prefix>-kp-key`|string|`null`|No|
|standard_key_type|Determines if the root key is a standard key or not. This variable is used only during creation of a Key Protect root key in this module.|bool|`false`|No|
|monitoring_instance| GUID of the IBM Cloud Monitoring instance. If set to `null`, an instance is created with the following naming convention: `<var.resource_prefix>-sysdig`|string|`null`|No|
|monitoring_access_key|The IBM Cloud Monitoring ingestion key that you want to use for your configuration.|string|N/A|No|
|logging_instance|GUID of IBM Cloud Log Analysis instance. If set to `null`, an instance is created with the following naming convention: `<var.resource_prefix>-logdna`|string|`null`|No|
|logging_ingestion_key|The IBM Cloud Log Analysis ingestion key that you want to use for your configuration.|string|N/A|No|
|private_endpoint|Add this option to connect to your Log Analysis and Monitoring service instances through the private cloud service endpoint.|bool|N/A|No|
|activity_tracker_instance|GUID of the IBM Cloud Activity Tracker instance. If set to `null`, a instance is created with the following naming convention: `<var.resource_prefix>-at`|string|`null`|No|
|custom_sg_rules|Custom VPC security group rules. For more information, review the following [`custom_sg_rules` object](#custom_sg_rules-object). |list(object)|[]|No|
|ip_ranges|An ordered list of IP address ranges on which the three VPC subnets are created, for the region. If the subnets are created in the `us-south` region, the IP address ranges must match the IP address ranges of the region's zones, [`us-south-1`, `us-south-2`, `us-south-3`].Conflicts with `number_of_addresses` argument For more information, see [Designing an address plan in the VPC documentation](https://cloud.ibm.com/docs/vpc?topic=vpc-vpc-addressing-plan-design).|list(string)|null|No|
|number_of_addresses|Number of IPV4 Addresses. Conflicts with `ip_ranges` argument|number|`null`|No|

### custom_sg_rules object

For more information about security groups, see the [VPC documentation](https://cloud.ibm.com/docs/vpc?topic=vpc-using-security-groups).

|Name|Description|Type|Default|Required|
|-----|----------|----|-------|--------|
|name|Name of security group rule.|string|N/A|Yes|
|direction|Direction of security group rule. Accepted values are `inbound` or `outbound`.|string|N/A|Yes|
|remote|The ID of the security group, which might be an IP address, a CIDR block, or a single security group identifier.|string|N/A|No|
|ip_version|The IP version. Accepted values are `ipv4` and `ipv6`.<!--verify what this means?-->|string|N/A|no|
|icmp|A nested block that describes the `icmp` protocol of this security group rule. You cannot use this object if you use `tcp` or `udp`. For more information, see the following [`icmp` object](#icmp-object).|object|N/A|No|
|tcp|A nested block that describes the `tcp` protocol of this security group rule. You cannot use this object if you use `icmp` or `udp`. For more information, see the following [`tcp` object](#tcp-object).|object|N/A|No|
|udp|A nested block that describes the `udp` protocol of this security group rule. You cannot use this object if you use `icmp` or `tcp`. For more information, see the following [`udp` object](#udp-object).|object|N/A|No|

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

### udp object

|Name|Description|Type|Default|Required|
|-----|----------|----|-------|--------|
|port_min|The inclusive lower bound of UDP port range. Valid values are from 1 to 65535.|int|N/A|Yes|
|port_max|The inclusive upper bound of UDP port range. Valid values are from 1 to 65535.|int|N/A|Yes|

### Notes on the input variables

- For the custom security group rules: If none of the `icmp`, `tcp`, and `udp` objects are specified, the template creates a rule with a protocol to allow **ALL**.
- For the template to create a KMS instance and root key, you must leave empty both `kms_instance` and `kms_key` objects.

## Usage

```bash
terraform init

terraform plan

terraform apply

terraform destroy
```
