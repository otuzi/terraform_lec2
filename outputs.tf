output "public_ip_VM_web" {
    value = yandex_compute_instance.vm-1.network_interface[0].nat_ip_address
}

output "public_ip_VM_DB" {
    value = yandex_compute_instance.vm-db.network_interface[0].nat_ip_address
}

output "instance_name_VM_web" {
    value = yandex_compute_instance.vm-1.name
}

output "instance_name_VM_DB" {
    value = yandex_compute_instance.vm-db.name
}

output "FQDN_VM_web" {
    value = yandex_compute_instance.vm-1.fqdn
}

output "FQDN_VM_DB" {
    value = yandex_compute_instance.vm-db.fqdn
}
