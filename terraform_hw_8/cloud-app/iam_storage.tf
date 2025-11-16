resource "yandex_iam_service_account" "storage_sa" {
  name        = "${var.project_name}-storage-sa"
  description = "Service account for Object Storage access (S3)"
}

resource "yandex_resourcemanager_folder_iam_member" "storage_sa_storage_editor" {
  folder_id = var.yc_folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.storage_sa.id}"
}

resource "yandex_iam_service_account_static_access_key" "storage_sa_key" {
  service_account_id = yandex_iam_service_account.storage_sa.id
  description        = "Static access key for ${var.project_name} bucket"
}

resource "random_string" "bucket_suffix" {
  length  = 6
  upper   = false
  lower   = true
  numeric = true
  special = false
}

resource "yandex_storage_bucket" "app_bucket" {
  bucket = "${var.bucket_name_prefix}-${random_string.bucket_suffix.result}"

  access_key = yandex_iam_service_account_static_access_key.storage_sa_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.storage_sa_key.secret_key

  default_storage_class = "STANDARD"
  acl                   = "private"
  force_destroy         = true

  labels = {
    project = var.project_name
    purpose = "app-storage"
  }
}
