resource "yandex_compute_instance" "nat" {
  name     = var.nat_name
  zone     = var.zone_1
  hostname = "nat"
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.nat_image
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.subnet_1.id
    nat        = true
    ip_address = var.internal_nat_ip
  }

  metadata = {
    user-data = "${file("meta.txt")}"
  }
}