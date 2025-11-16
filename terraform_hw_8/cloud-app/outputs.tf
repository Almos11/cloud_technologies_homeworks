output "web_instance_external_ip" {
  description = "Публичный IP веб-сервера"
  value       = yandex_compute_instance.web.network_interface[0].nat_ip_address
}

output "db_connection_info" {
  description = "Параметры подключения к PostgreSQL"
  value = {
    host    = yandex_mdb_postgresql_cluster.db.host[0].fqdn
    port    = 6432
    db_name = yandex_mdb_postgresql_database.app.name
    user    = yandex_mdb_postgresql_user.app.name
  }
}

output "bucket_name" {
  description = "Имя созданного S3 бакета"
  value       = yandex_storage_bucket.app_bucket.bucket
}

output "storage_access_key_id" {
  description = "ID статического access key для Object Storage"
  value       = yandex_iam_service_account_static_access_key.storage_sa_key.access_key
  sensitive   = true
}

output "storage_secret_key" {
  description = "Secret key для Object Storage (использовать аккуратно)"
  value       = yandex_iam_service_account_static_access_key.storage_sa_key.secret_key
  sensitive   = true
}
