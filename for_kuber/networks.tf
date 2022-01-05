resource "yandex_vpc_network" "network_1" {
  name = "network-1"
}

resource "yandex_vpc_subnet" "subnet_1" {
  name           = var.subnet_1_name
  zone           = var.zone_1
  network_id     = yandex_vpc_network.network_1.id
  v4_cidr_blocks = ["10.10.1.0/24"]
}

resource "yandex_vpc_subnet" "subnet_2" {
  name           = var.subnet_2_name
  zone           = var.zone_1
  network_id     = yandex_vpc_network.network_1.id
  v4_cidr_blocks = ["10.10.2.0/24"]
  route_table_id = yandex_vpc_route_table.subnet_2_rt.id
}

resource "yandex_vpc_route_table" "subnet_2_rt" {
  network_id = yandex_vpc_network.network_1.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "10.10.1.254"
  }
}