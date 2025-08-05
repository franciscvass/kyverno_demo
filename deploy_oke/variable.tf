variable ssh_private_key_path {
  type = string
}

variable ssh_public_key_path {
  type = string
}


variable "worker_pools" {
  default     = {}
  description = "Tuple of OKE worker pools where each key maps to the OCID of an OCI resource, and value contains its definition."
  type        = any
}

variable "bastion_user" {
  type        = string
  default     = "opc"
  description = "User for SSH access through bastion host."
}



variable "compartment_id" {
  type        = string
  default     = null
  description = "A compartment OCID automatically populated by Resource Manager."
}

variable "state_id" {
  type        = string
  default     = "null"
  description = "Optional Terraform state_id used to identify the resources of this deployment."
}


