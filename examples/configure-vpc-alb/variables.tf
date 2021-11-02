#####################################################
# ibm_container_vpc_alb - Enable or disable an Application Load Balancer (ALB) for a VPC cluster.
# Copyright 2020 IBM
#####################################################

variable "alb_id" {
  description = "The unique identifier of the ALB. To retrieve the ID, run ibmcloud ks alb ls"
  type        = string
}

variable "enable" {
  description = "If set to true, the default Ingress ALB in your cluster is enabled and configured with the IBM-provided Ingress subdomain. If set to false, the default Ingress ALB is disabled in your cluster. "
  type        = bool
  default     = false
}

variable "resource_group" {
  type        = string
  description = "Name of the resource group."
  default     = "Default"
}

