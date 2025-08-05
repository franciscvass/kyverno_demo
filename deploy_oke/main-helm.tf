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
  #helm_template_values_override = templatefile(
  #  "${path.root}/helm-values-templates/nginx-values.yaml.tpl",
  #  {
  #    min_bw         = 100,
  #    max_bw         = 100,
  #    pub_lb_nsg_id  = module.oke.pub_lb_nsg_id,
  #    state_id       = local.state_id,
  #    #create_cluster = var.create_cluster
  #  }
  #)
  #helm_user_values_override = try(base64decode(var.nginx_user_values_override), var.nginx_user_values_override)
  helm_user_values_override = ""
  kube_config = one(data.oci_containerengine_cluster_kube_config.kube_config.*.content)
  depends_on  = [module.oke]
}


#module "cert-manager" {
#  count  = var.deploy_cert_manager ? 1 : 0
#  source = "./helm-module"
#
#  bastion_host    = module.oke.bastion_public_ip
#  bastion_user    = var.bastion_user
#  operator_host   = module.oke.operator_private_ip
#  operator_user   = var.bastion_user
#  ssh_private_key = tls_private_key.stack_key.private_key_openssh
#
#  deploy_from_operator = true
#  deploy_from_local    = local.deploy_from_local
#
#  deployment_name     = "cert-manager"
#  helm_chart_name     = "cert-manager"
#  namespace           = "cert-manager"
#  helm_repository_url = "https://charts.jetstack.io"
#
#  pre_deployment_commands = []
#  post_deployment_commands = [
#    "cat <<'EOF' | kubectl apply -f -",
#    "apiVersion: cert-manager.io/v1",
#    "kind: ClusterIssuer",
#    "metadata:",
#    "  name: le-clusterissuer",
#    "spec:",
#    "  acme:",
#    "    # You must replace this email address with your own.",
#    "    # Let's Encrypt will use this to contact you about expiring",
#    "    # certificates, and issues related to your account.",
#    "    email: user@oracle.com",
#    "    server: https://acme-staging-v02.api.letsencrypt.org/directory",
#    "    privateKeySecretRef:",
#    "      # Secret resource that will be used to store the account's private key.",
#    "      name: le-clusterissuer-secret",
#    "    # Add a single challenge solver, HTTP01 using nginx",
#    "    solvers:",
#    "    - http01:",
#    "        ingress:",
#    "          ingressClassName: nginx",
#    "EOF"
#  ]
#  deployment_extra_args = ["--wait"]
#
#  helm_template_values_override = templatefile(
#    "${path.root}/helm-values-templates/cert-manager-values.yaml.tpl",
#    {}
#  )
#  helm_user_values_override = try(base64decode(var.cert_manager_user_values_override), var.cert_manager_user_values_override)
#
#  kube_config = one(data.oci_containerengine_cluster_kube_config.kube_config.*.content)
#
#  depends_on = [module.oke]
#}
#
#module "nim_llm" {
#  source = "./helm-module"
#
#  bastion_host    = module.oke.bastion_public_ip
#  bastion_user    = var.bastion_user
#  operator_host   = module.oke.operator_private_ip
#  operator_user   = var.bastion_user
#  ssh_private_key = tls_private_key.stack_key.private_key_openssh
#
#  deploy_from_operator = local.deploy_from_operator
#  deploy_from_local    = local.deploy_from_local
#
#  deployment_name     = "nim-llm"
#  helm_chart_name     = "nim-llm"
#  namespace           = "nim-llm"
#  helm_repository_url = ""
#  #helm_chart_path           = "./ingress-nginx-4.11.0.tgz" or "./ingress-nginx"
#  helm_chart_path           = "./nim-llm"
#
#  pre_deployment_commands  = []
#  post_deployment_commands = []
#
#  # this override the values.yaml file from chart
#  # this is a file present in helm-values-templates folder
#  helm_template_values_override = templatefile(
#    "${path.root}/helm-values-templates/nim_llm_values.yaml",
#    {
#      NGC_API_KEY = var.ngc_api_key
#    }
#  )
#  
#  # this is a file user uploads from ORM 
#  #helm_user_values_override = try(base64decode(var.nginx_user_values_override), var.nginx_user_values_override)
#  helm_user_values_override = try(base64decode(var.nim_user_values_override), var.nim_user_values_override)
#
#  kube_config = one(data.oci_containerengine_cluster_kube_config.kube_config.*.content)
#  depends_on  = [module.oke]
#}
#
#module "training_demo" {
#  source = "./helm-module"
#
#  bastion_host    = module.oke.bastion_public_ip
#  bastion_user    = var.bastion_user
#  operator_host   = module.oke.operator_private_ip
#  operator_user   = var.bastion_user
#  ssh_private_key = tls_private_key.stack_key.private_key_openssh
#
#  deploy_from_operator = local.deploy_from_operator
#  deploy_from_local    = local.deploy_from_local
#
#  deployment_name     = "training-demo"
#  helm_chart_name     = "training-demo"
#  namespace           = "training-demo"
#  helm_repository_url = ""
#  #helm_chart_path           = "./ingress-nginx-4.11.0.tgz" or "./ingress-nginx"
#  helm_chart_path           = "./helm-chart-training"
#
#  pre_deployment_commands  = []
#  post_deployment_commands = []
#
#  # this override the values.yaml file from chart
#  # this is a file present in helm-values-templates folder
#  helm_template_values_override = templatefile(
#    "${path.root}/helm-values-templates/training-values.yaml",
#    {
#      ds_name               = var.ds_name,
#      ds_range              = var.ds_range,
#      hf_token              = var.hf_token,
#      model_name            = var.model_name
#      trainer_docker_image  = var.trainer_docker_image
#    }
#  )
#  
#  # this is a file user uploads from ORM 
#  #helm_user_values_override = try(base64decode(var.nginx_user_values_override), var.nginx_user_values_override)
#  helm_user_values_override = try(base64decode(var.nim_user_values_override), var.nim_user_values_override)
#
#  kube_config = one(data.oci_containerengine_cluster_kube_config.kube_config.*.content)
#  depends_on  = [module.nim_llm]
#}

