terraform {
  required_version = ">= 1.3.0"

  required_providers {
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = ">= 2.2.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.9.0"
    }

    null = {
      source  = "hashicorp/null"
      version = ">= 3.2.1"
    }

    oci = {
      configuration_aliases = [oci.home]
      source                = "oracle/oci"
      version               = ">= 4.119.0"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 3.4.3"
    }

    time = {
      source  = "hashicorp/time"
      version = ">= 0.9.1"
    }
  }
}