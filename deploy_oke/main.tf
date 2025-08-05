
provider "oci" {
  config_file_profile = "ION-FRA"
  region           = "eu-frankfurt-1"
  alias = "home"
}

provider "oci" {
  config_file_profile = "ION-FRA"
  region           = "eu-frankfurt-1"
}

module "oke" {

  source  = "oracle-terraform-modules/oke/oci"
  #version = "5.1.0"
   kubernetes_version                = "v1.32.1"

  providers             = { oci.home = oci.home 
                            oci = oci }
  compartment_id        = "ocid1.compartment.oc1..aaaaaaaars7ft6qwfjeft6c2yo35copu7plbgvjyzooqcgqqb2l2negsww4q"
  
  bastion_allowed_cidrs = ["92.180.8.168/32"]

  operator_image_type = "platform"
  #operator_image_os = "Oracle Autonomous Linux"
  #operator_image_os_version = "8"
  operator_shape = {"shape" =  "VM.Standard.E5.Flex"}

  #operator_image_type = "custom"
  #### MIND this for other REGIONS
  #operator_image_id   = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa6yqha6dmkapv4kpccyuhbncj65mkpdcgoimuoebny2o2avawqb2a"

  bastion_image_type  = "platform"
  #bastion_image_os = "Oracle Autonomous Linux"
  #bastion_image_os_version = "8"
  bastion_shape = {"shape" = "VM.Standard.E5.Flex"}

  #bastion_image_type  = "custom"
  #bastion_image_id    = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaakc66dq6s6qyyrgptgbrxfjzwkqrubenkqmjmxhpyn7wuczrwr3ya"
  
  create_vcn            = true
  vcn_name              = "OKE-VCN-KYVERNO"
  #vcn_id                = "ocid1.vcn.oc1.eu-frankfurt-1.amaaaaaawe6j4fqaamskaf3qmh5baewf6m6nlvnphhblumbz3tylewnxsmca"
  
  # if use existent vcn
  #ig_route_table_id     = "ocid1.routetable.oc1.eu-frankfurt-1.aaaaaaaaj6jfo4eoi5uc2mvmvc5f63shupybip555ehceyf3y7qq5a2pvfaq"
  #nat_route_table_id    = "ocid1.routetable.oc1.eu-frankfurt-1.aaaaaaaaofqgsznw7auahltt7hovk24k67embuiyvdctpkmmjtplfu4wmmoa"
  
  ssh_private_key_path  = "/Users/fvass/.ssh/id_rsa"
  ssh_public_key_path   = "/Users/fvass/.ssh/id_rsa.pub"
  

  cluster_name          = "kyverno-cluster-demo"
  cluster_type          = "enhanced"
  cni_type              = "npn"
  # node pool
  worker_pool_size = 1
  worker_pool_mode = "node-pool"
  worker_pools = var.worker_pools

  output_detail = true
  allow_worker_ssh_access = true
  #workers_defined_tags = {
  #    "DynamicGroup.Application" = "yes"
  #  }
}

output "apiserver_private_host" {
  value = module.oke.apiserver_private_host
}

output "bastion_public_ip" {
  value = module.oke.bastion_public_ip
}

output "operator_private_ip" {
  value = module.oke.operator_private_ip
}

output "ssh_to_operator" {
  value = module.oke.ssh_to_operator
}

