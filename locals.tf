locals {
  vm_prefix_db = "netology-develop-platform-db"
  vm_prefix_web = "netology-develop-platform-web"

  vm_count_db = 1
  vm_count_web = 2

  vm_names = {
    db = "${local.vm_prefix_db}-${local.vm_count_db}"
    web = "${local.vm_prefix_web}-${local.vm_count_web}"
  }
}
