
variable "worker_pools" {
  default     = {}
  description = "Tuple of OKE worker pools where each key maps to the OCID of an OCI resource, and value contains its definition."
  type        = any
}
