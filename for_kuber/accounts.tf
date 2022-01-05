resource "yandex_iam_service_account" "iam_adm" {
  name      = "iam-account"
}

resource "yandex_resourcemanager_folder_iam_binding" "iam_binding_adm" {
  folder_id = var.folder_id
  role      = "admin"
  members = [
    "serviceAccount:${yandex_iam_service_account.iam_adm.id}",
  ]
  depends_on = [
    yandex_iam_service_account.iam_adm,
  ]
}

resource "yandex_iam_service_account" "iam_editor" {
  name      = "iam-editor"
}

resource "yandex_resourcemanager_folder_iam_binding" "iam_binding_editor" {
  folder_id = var.folder_id
  role      = "editor"
  members = [
    "serviceAccount:${yandex_iam_service_account.iam_editor.id}",
  ]
  depends_on = [
    yandex_iam_service_account.iam_editor,
  ]
}

resource "yandex_kms_symmetric_key" "key-a" {
  name              = "example-symetric-key"
  description       = "description for key"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" // equal to 1 year
}