resource "yandex_kubernetes_cluster" "my_cluster" {
  name        = "my-cluster"

  network_id = yandex_vpc_network.network_1.id

  master {
    version = "1.21"
    zonal {
      zone      = var.zone_1
      subnet_id = yandex_vpc_subnet.subnet_1.id
    }

    public_ip = true

#    security_group_ids = [yandex_vpc_security_group.group1.id]

    maintenance_policy {
      auto_upgrade = true

      maintenance_window {
        start_time = "15:00"
        duration   = "3h"
      }
    }
  }

  service_account_id      = yandex_iam_service_account.iam_adm.id
  node_service_account_id = yandex_iam_service_account.iam_editor.id

  labels = {
    my_key       = "my_value"
    my_other_key = "my_other_value"
  }

  release_channel = "RAPID"
  network_policy_provider = "CALICO"

  kms_provider {
    key_id = yandex_kms_symmetric_key.key-a.id
  }
}