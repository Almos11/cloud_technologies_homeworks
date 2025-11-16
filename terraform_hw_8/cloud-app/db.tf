resource "yandex_mdb_postgresql_cluster" "db" {
  name        = "${var.project_name}-pg"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.main.id

  config {
    version = 15

    resources {
      resource_preset_id = "s1.micro"
      disk_type_id       = "network-ssd"
      disk_size          = 10 # GB
    }
  }

  maintenance_window {
    type = "ANYTIME"
  }

  host {
    zone      = var.default_zone
    subnet_id = yandex_vpc_subnet.public.id
  }

  labels = {
    project = var.project_name
    role    = "db"
  }
}

resource "yandex_mdb_postgresql_user" "app" {
  cluster_id = yandex_mdb_postgresql_cluster.db.id
  name       = var.db_user
  password   = var.db_password
}

resource "yandex_mdb_postgresql_database" "app" {
  cluster_id = yandex_mdb_postgresql_cluster.db.id
  name       = var.db_name
  owner      = yandex_mdb_postgresql_user.app.name
}
