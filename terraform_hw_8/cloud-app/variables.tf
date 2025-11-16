variable "yc_token" {
  description = "IAM-токен Yandex Cloud (yc iam create-token)"
  type        = string
  sensitive   = true
}

variable "yc_cloud_id" {
  description = "Cloud ID (yc config list)"
  type        = string
}

variable "yc_folder_id" {
  description = "Folder ID (yc config list)"
  type        = string
}

variable "default_zone" {
  description = "Зона доступности по умолчанию"
  type        = string
  default     = "ru-central1-a"
}

variable "project_name" {
  description = "Логическое имя проекта (префикс для ресурсов)"
  type        = string
  default     = "cloud-app"
}

variable "public_subnet_cidr" {
  description = "CIDR-диапазон для публичной подсети"
  type        = string
  default     = "10.10.0.0/24"
}

variable "vm_user" {
  description = "Пользователь ОС для SSH (обычно ubuntu)"
  type        = string
  default     = "ubuntu"
}

variable "ssh_public_key_path" {
  description = "Путь до публичного SSH ключа (для доступа на ВМ)"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

variable "db_name" {
  description = "Имя базы данных в PostgreSQL"
  type        = string
  default     = "appdb"
}

variable "db_user" {
  description = "Имя пользователя БД"
  type        = string
  default     = "appuser"
}

variable "db_password" {
  description = "Пароль пользователя БД"
  type        = string
  sensitive   = true
}

variable "bucket_name_prefix" {
  description = "Префикс имени бакета (фактическое имя будет с суффиксом)"
  type        = string
  default     = "cloud-app-bucket"
}