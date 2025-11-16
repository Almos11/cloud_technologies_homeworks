resource "yandex_vpc_network" "main" {
  name = "${var.project_name}-network"
  labels = {
    project = var.project_name
  }
}

resource "yandex_vpc_subnet" "public" {
  name           = "${var.project_name}-subnet-public"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = [var.public_subnet_cidr]

  labels = {
    project = var.project_name
  }
}