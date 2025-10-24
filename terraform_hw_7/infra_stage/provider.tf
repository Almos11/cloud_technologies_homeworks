# Объявление провайдера
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
    random = {
      source = "hashicorp/random"
    }
  }
  required_version = ">= 1.00"
}

provider "yandex" {
  zone      = "ru-central1-a"
  folder_id = "b1g7s2dabdfmgbf4h02c"
  token     = "<token>"
}

provider "random" {
}
