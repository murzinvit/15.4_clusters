 resource "yandex_kubernetes_cluster" "kuber-cluster" {
    name        = "kub-test"
    network_id = yandex_vpc_network.internal.id

    master {
    zonal {
        zone      = "ru-central1-a"
        subnet_id = yandex_vpc_subnet.internal-a.id
    }

    version   = "1.21"
    public_ip = true
    }

    release_channel = "RAPID"
    network_policy_provider = "CALICO"

    node_service_account_id = yandex_iam_service_account.docker-registry.id
    service_account_id      = yandex_iam_service_account.instances-editor.id
    depends_on = [
      yandex_vpc_network.internal, yandex_vpc_subnet.internal-a, yandex_vpc_subnet.internal-b, yandex_vpc_subnet.internal-c
    ]
}

    resource "yandex_kubernetes_node_group" "node-group-0" {
    cluster_id  = yandex_kubernetes_cluster.kuber-cluster.id
    name        = "test-group-auto"
    version     = "1.21"

    instance_template {
    platform_id = "standard-v2"
    network_interface {
      nat         = true
      subnet_ids  = [yandex_vpc_subnet.internal-a.id]
    }

    resources {
    core_fraction = 20
    memory        = 2
    cores         = 2
    }

    boot_disk {
    type = "network-hdd"
    size = 64
    }

    scheduling_policy {
    preemptible = false
    }
    }

    scale_policy {
    auto_scale {
    min = 2
    max = 3
    initial = 2
    }
    }

    allocation_policy {
    location {
    zone = "ru-central1-a"
    }
    }

    maintenance_policy {
    auto_upgrade = false
    auto_repair  = true
    }
}