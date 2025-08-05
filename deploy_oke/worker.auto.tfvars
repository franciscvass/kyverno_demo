worker_pools = {
  wg_np-vm-ol8 = {
    description = "OKE-managed Node Pool with OKE Oracle Linux 8 image",
    create      = true,
    mode        = "node-pool",
    size        = 1,
    size_max    = 3,
    os          = "Oracle Linux",
    os_version  = "8",
    autoscale   = true,
    shape = "VM.Standard.E3.Flex"
  }
  wg_np-vm-ol8-1 = {
    description = "OKE-managed Node Pool 1",
    create      = true,
    mode        = "node-pool",
    size        = 0,
    size_max    = 3,
    os          = "Oracle Linux",
    os_version  = "8",
    autoscale   = true,
    shape = "VM.Standard.E3.Flex"
  }
}