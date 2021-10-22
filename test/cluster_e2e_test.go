package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

// An example of how to test the Terraform module to create cos instance in examples/instance using Terratest.
func TestAccIBMClusterE2E(t *testing.T) {
	t.Parallel()

	// Construct the terraform options with default retryable errors to handle the most common retryable errors in
	// terraform testing.
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../examples/classic-kubernetes-e2e",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"cluster_name":       "clusterDemo",
			"metro":              "dal10",
			"worker_pool_flavor": "b3c.16x64",
			"resource_group":     "default",
			"hardware":           "shared",
			"worker_nodes":       1,
			"flavor":             "b3c.16x64",
			"worker_pool_name":   "workerPoolDemo",
			"region":             "us-south",
			"private_vlan_id":    "2988890",
		},
	})

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	/*instanceID := terraform.Output(t, terraformOptions, "cos_instance_id")
	if len(instanceID) <= 0 {
		t.Fatal("Wrong output")
	}
	fmt.Println("COS INstance iD", instanceID)*/
}
