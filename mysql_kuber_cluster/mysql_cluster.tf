resource "yandex_mdb_mysql_cluster" "mysql-cluster" {
  name        = "mysql-cluster"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.network-1.id
  version     = "8.0"

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = 16
  }

  database {
    name = "netology_db"
  }

  maintenance_window {
    type = "WEEKLY"
    day  = "SAT"
    hour = 12
  }

  user {
    name     = "user"
    password = "password"
    permission {
      database_name = "netology_db"
      roles         = ["ALL"]
    }
  }

  host {
    zone      = "ru-central1-a"
    subnet_id = yandex_vpc_subnet.private-subnet-a.id
  }

  host {
    zone      = "ru-central1-b"
    subnet_id = yandex_vpc_subnet.private-subnet-a.id
  }

  depends_on = [
     yandex_vpc_network.network-1,
     yandex_vpc_subnet.private-subnet-a,
    yandex_vpc_subnet.private-subnet-b,
  ]
}