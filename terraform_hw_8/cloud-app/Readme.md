## Универсальность кода

* **Любое окружение, без изменения кода**

  Все специфичные вещи (cloud_id, folder_id, zone, токен, пароль БД, имя бакета) вынесены в переменные. Чтобы использовать код в другом облаке/папке, достаточно поменять значения в `terraform.tfvars` или передать их через `-var` / `TF_VAR_*`. HCL-файлы менять не нужно.

* **Лучшие практики Terraform для YC**:

  * Отдельные файлы по областям ответственности (provider, network, compute, db, storage, iam). ([oxoi.ru][1])
  * Использование `data "yandex_compute_image"` по `family`, а не хардкод ID образа. ([Yandex Cloud][3])
  * Отдельные `variables.tf` и `outputs.tf`.
  * Использование `random_string` для уникального имени бакета (иначе глобальный namespace S3 может конфликтовать).

* **Все ресурсы из условия есть:**

  1. Облачная сеть и подсеть — `yandex_vpc_network.main`, `yandex_vpc_subnet.public`.
  2. Вычислительный ресурс — `yandex_compute_instance.web`.
  3. СУБД — `yandex_mdb_postgresql_cluster.db` + `yandex_mdb_postgresql_database.app` + `yandex_mdb_postgresql_user.app`.
  4. Объектное хранилище — `yandex_storage_bucket.app_bucket`.
  5. Сервисный аккаунт, роли и static key — `yandex_iam_service_account.storage_sa`, `yandex_resourcemanager_folder_iam_member.storage_sa_storage_editor`, `yandex_iam_service_account_static_access_key.storage_sa_key`.yc_folder_id

## Как запустить

1. Перейти в каталог с `.tf` файлами:

   ```bash
   cd cloud-app
   ```

2. Заполнить `terraform.tfvars` своими значениями.

3. Инициализация:

   ```bash
   terraform init
   ```

4. Просмотр плана:

   ```bash
   terraform plan
   ```

5. Развертывание:

   ```bash
   terraform apply
   ```

6. Посмотреть результата:

   ```bash
   terraform output
   ```

   Вывод: `web_instance_external_ip`, `db_connection_info`, `bucket_name`, `storage_access_key_id` и т.д.

---