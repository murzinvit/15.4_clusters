resource "yandex_iam_service_account" "web_iam_account" {
  name      = "web-iam-account"
}

resource "yandex_resourcemanager_folder_iam_binding" "web_adm" {
  folder_id = var.folder_id
  role      = "admin"
  members = [
    "serviceAccount:${yandex_iam_service_account.web_iam_account.id}",
  ]
  depends_on = [
    yandex_iam_service_account.web_iam_account,
  ]
}

resource "yandex_compute_instance_group" "web_ig" {
  name                = "web-ig"
  folder_id           = var.folder_id
  deletion_protection = false
  service_account_id  = yandex_iam_service_account.web_iam_account.id

  instance_template {
    platform_id = "standard-v1"
    name = "site-node-{instance.index}-{instance.short_id}"
    resources {
      memory = 2
      cores  = 2
    }
    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "fd827b91d99psvq5fjit"
        size     = 4
      }
    }
    network_interface {
      subnet_ids = [yandex_vpc_subnet.subnet_1.id]
    }

    metadata = {
      user-data = "${file("meta.txt")}"
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = ["ru-central1-a"]
  }

  deploy_policy {
    max_unavailable = 2
    max_creating    = 2
    max_expansion   = 2
    max_deleting    = 2
  }
  depends_on = [
    yandex_iam_service_account.web_iam_account, yandex_resourcemanager_folder_iam_binding.web_adm,
  ]
}