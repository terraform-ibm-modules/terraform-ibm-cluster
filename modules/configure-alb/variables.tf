#####################################################
# ibm_container_alb - Enable or disable an Ingres application load balancer (ALB) that is set up in your cluster.
# Copyright 2020 IBM
#####################################################

variable "alb_id" {
  description = "The unique identifier of the ALB. To retrieve the ID, run ibmcloud ks alb ls"
  type        = string
}

variable "enable" {
  description = "If set to true, the default Ingress ALB in your cluster is enabled and configured with the IBM-provided Ingress subdomain. If set to false, the default Ingress ALB is disabled in your cluster. "
  type        = bool
  default     = true
}

variable "user_ip" {
  type        = string
  description = "For a private ALB only. The private ALB is deployed with an IP address from a user-provided private subnet. If no IP address is provided, the ALB is deployed with a random IP address from a private subnet in the IBM Cloud account."
  default     = null
}

