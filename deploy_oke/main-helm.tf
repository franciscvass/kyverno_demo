# Copyright (c) 2022, 2024 Oracle Corporation and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

locals {
  #deploy_from_operator = alltrue([var.create_operator_and_bastion, var.create_cluster])
  #deploy_from_local    = alltrue([!local.deploy_from_operator, anytrue([var.control_plane_is_public, !var.create_cluster])])
  deploy_from_local    = false
  deploy_from_operator = true
}

data "oci_containerengine_cluster_kube_config" "kube_config" {
  count = local.deploy_from_local ? 1 : 0
# cluster_id = var.create_cluster ? module.oke.cluster_id : var.cluster_id
  cluster_id = module.oke.cluster_id
  endpoint   = "PRIVATE_ENDPOINT"
}

module "kyverno" {
  source = "./helm-module"
  bastion_host    = module.oke.bastion_public_ip
  bastion_user    = var.bastion_user
  operator_host   = module.oke.operator_private_ip
  operator_user   = var.bastion_user
  ssh_private_key = tls_private_key.stack_key.private_key_openssh
  deploy_from_operator = true
  #deploy_from_local    = local.deploy_from_local
  deploy_from_local    = false
  deployment_name     = "kyverno"
  helm_chart_name     = "kyverno"
  namespace           = "kyverno"
  helm_repository_url = "https://kyverno.github.io/kyverno/"
  pre_deployment_commands  = []
  post_deployment_commands = []
  deployment_extra_args    = ["--wait"]
  helm_template_values_override = ""
  helm_user_values_override = ""
  kube_config = one(data.oci_containerengine_cluster_kube_config.kube_config.*.content)
  depends_on  = [module.oke]
}


