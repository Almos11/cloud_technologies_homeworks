data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

resource "yandex_compute_instance" "web" {
  name        = "${var.project_name}-vm"
  platform_id = "standard-v1"
  zone        = var.default_zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 20
      type     = "network-ssd"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    nat       = true
  }

  metadata = {
    "ssh-keys" = "${var.vm_user}:${file(var.ssh_public_key_path)}"

    "user-data" = <<-EOF
      #cloud-config
      packages:
        - nginx
      runcmd:
        - sed -i 's/Welcome to nginx/Welcome from Terraform!/' /var/www/html/index.nginx-debian.html || true
        - systemctl enable nginx
        - systemctl restart nginx
    EOF
  }

  labels = {
    project = var.project_name
    role    = "web"
  }
}
