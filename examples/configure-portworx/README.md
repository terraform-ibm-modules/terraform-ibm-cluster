# Portworx Example

This example illustrates how to use the Portworx Terraform module.

## Compatibility

This module is verified to run on Terraform version 0.12. It has not been tested on later versions.

## Requirements

- Have an IBM Cloud account with required privileges
- Access to IBM Cloud
  - [Create an IBM Cloud API key](https://cloud.ibm.com/docs/account?topic=account-userapikey#create_user_key)
  - [Create an IBM Cloud Classic Infrastructure API Key](https://cloud.ibm.com/docs/account?topic=account-classic_keys)

  In the terminal window, export the following environment variables to let the IBM Provider to retrieve the credentials.

  ```bash
  export IAAS_CLASSIC_USERNAME="< Your IBM Cloud Username/Email here >"
  export IAAS_CLASSIC_API_KEY="< Your IBM Cloud Classic API Key here >"
  export IC_API_KEY="< IBM Cloud API Key >"
  ```

- [IBM Cloud CLI](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment#install-ibm-cloud-cli) installed
  - [Login to IBM Cloud with the CLI](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment#login-to-ibm-cloud)
- [IBM Cloud CLI Plugin](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment#ibm-cloud-cli-plugins) for `kubernetes-service` and `container-service` installed
- [Terraform](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment#install-terraform) **version 0.12** installed
- [IBM Cloud Terraform Provider](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment#configure-access-to-ibm-cloud) installed
- Utility tools such as:
  - [jq](https://stedolan.github.io/jq/download/)
  - [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- OpenShift or Kubernetes cluster

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Inputs

| Name                           | Description  | Default | Required |
| ------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | -------- |
| `ibmcloud_api_key`             | This requires an ibmcloud api key found here: `https://cloud.ibm.com/iam/apikeys`    |         | Yes       |
| `resource_group_name`          | The resource group name where the cluster is housed                                  |         | Yes      |
| `region`                       | The region that resources will be provisioned in. Ex: `"us-east"` `"us-south"` etc.  |         | Yes      |
| `cluster_id`                   | The id of the cluster to install on |  | Yes       |
| `worker_nodes`                 | Number of worker nodes in the cluster                                        |                 | Yes       |
| `storage_capacity`             | The capacity of the volume in GBs |   `200`    | Yes      |
| `storage_profile`              | **Optional**: Storage profile used for creating storage. If this is set to a custom profile, you must update the `storage_iops` |  
| `storage_iops`                 | **Optional:** The number of iops for a custom class. **Note:** This is used only if a user provides a custom `storage_profile` |   `10`    | Yes      |
 `10iops-tier`    | Yes      |
| `unique_id`                    | The id of the `portworx-service`  |  | Yes       |
| `create_external_etcd`         | Set this value to `true` or `false` to create an external etcd | `false` | Yes |
| `etcd_username`                | Username needed for etcd. Only used if `create_external_etcd` is set to `true`                         | `portworxuser`     | yes |
| `etcd_password`                | Password needed for etcd. Only used if `create_external_etcd` is set to `true`                         | `portworxpassword` | Yes |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## How to input variable values through a file

Set the required variables in an `terraform.tfvars` file, such as: 

```hcl
ibmcloud_api_key        = "<api-key>"

// Cluster parameters
worker_nodes            = 4  // Number of workers

// Storage parameters
storage_capacity        = 200  // In GBs
storage_iops            = 10   // Must be a number, it will not be used unless a storage_profile is set to a custom profile
storage_profile         = "10iops-tier"

// Portworx parameters
resource_group_name     = "default"
region                  = "us-east"
cluster_id              = "<cluster-id>"
unique_id               = "roks-px-tf"
create_external_etcd    = false
```

## Usage

To review the plan for the configuration defined (no resources actually provisioned)

`terraform plan`

To execute and start building the configuration defined in the plan (provisions resources)

`terraform apply`

To destroy the VPC and all related resources

`terraform destroy`

## Verification

To verify installation on the cluster you need `kubectl`, then execute:

After the service shows as active in the IBM Cloud resource view, verify the deployment:

```bash
kubectl get pods -n kube-system | grep 'portworx\|stork'
```

This should display something like the following:

```console
portworx-647c5                            1/1     Running     0          9m33s
portworx-api-h7dnr                        1/1     Running     0          9m33s
portworx-api-ndpxb                        1/1     Running     0          9m33s
portworx-api-srnjk                        1/1     Running     0          9m33s
portworx-gzgqc                            1/1     Running     0          9m33s
portworx-pvc-controller-b8c88b4d7-6rnq6   1/1     Running     0          9m33s
portworx-pvc-controller-b8c88b4d7-9bfxk   1/1     Running     0          9m33s
portworx-pvc-controller-b8c88b4d7-nqqpr   1/1     Running     0          9m33s
portworx-vxphk                            1/1     Running     0          9m33s
stork-6f74dcf5fc-mxwxb                    1/1     Running     0          9m33s
stork-6f74dcf5fc-svnrl                    1/1     Running     0          9m33s
stork-6f74dcf5fc-z9qlc                    1/1     Running     0          9m33s
stork-scheduler-7d755b5475-grzr2          1/1     Running     0          9m33s
stork-scheduler-7d755b5475-nl25m          1/1     Running     0          9m33s
stork-scheduler-7d755b5475-trhhb          1/1     Running     0          9m33s
```

Using one of the portworx pods, check the status of the storage cluster

```bash
kubectl exec portworx-647c5 -it -n kube-system -- /opt/pwx/bin/pxctl status
```

This should produce output like:

```console
Status: PX is operational
License: PX-Enterprise IBM Cloud (expires in 1201 days)
Node ID: 5d65ce5b-1333-4b0c-b469-ccf7df1ce94a
  IP: 172.26.0.10 
  Local Storage Pool: 1 pool
  POOL    IO_PRIORITY  RAID_LEVEL  USABLE    USED     STATUS  ZONE      REGION
  0       LOW          raid0       400 GiB   18 GiB   Online  us-east-1 us-east
  Local Storage Devices: 1 device
  Device  Path      Media Type               Size     Last-Scan
  0:1     /dev/vdd  STORAGE_MEDIUM_MAGNETIC  400 GiB  18 Dec 20 04:43 UTC
  * Internal kvdb on this node is sharing this storage device /dev/vdd  to store its data.
  total   -         400 GiB
  Cache Devices:
    * No cache devices
Cluster Summary
  Cluster ID: pwx-iaf
  Cluster UUID: 45fc03a8-7e82-497d-bc2a-0844dca1459f
  Scheduler: kubernetes
  Nodes: 3 node(s) with storage (3 online)
  IP           ID                                   SchedulerNodeName  StorageNode  Used    Capacity  Status  StorageStatus Version         Kernel                      OS
  172.26.0.9   f96e278c-fd06-42a8-9684-0d91bc0bde9c 172.26.0.9         Yes          18 GiB  400 GiB   Online  Up            2.6.1.6-3409af2 3.10.0-1160.6.1.el7.x86_64  Red Hat
  172.26.0.10  5d65ce5b-1333-4b0c-b469-ccf7df1ce94a 172.26.0.10        Yes          18 GiB  400 GiB   Online  Up (This node 2.6.1.6-3409af2 3.10.0-1160.6.1.el7.x86_64  Red Hat
  172.26.0.11  1b56ec6c-6dcd-4807-a9cd-cf1ae12e7635 172.26.0.11        Yes          18 GiB  400 GiB   Online  Up            2.6.1.6-3409af2 3.10.0-1160.6.1.el7.x86_64  Red Hat
  Warnings: 
      WARNING: Internal Kvdb is not using dedicated drive on nodes [172.26.0.11 172.26.0.9 172.26.0.10]. This configuration is not recommended for production clusters.
Global Storage Pool
  Total Used      :  53 GiB
  Total Capacity  :  1.2 TiB
```

To review classificiation:

```bash
kubectl exec -it <portworx_pod> -n kube-system -- /opt/pwx/bin/pxctl cluster provision-status
```

## Cleanup

Run in the cluster:

```bash
curl -fsL https://install.portworx.com/px-wipe | bash
```

When the test is complete, execute: `terraform destroy`.

There are some directories and files you may want to manually delete, these are: `rm -rf terraform.tfstate* .terraform .kube`