# Домашнее задание к занятию «Основы Terraform. Yandex Cloud»

------

### Задание 1
В качестве ответа всегда полностью прикладывайте ваш terraform-код в git.  Убедитесь что ваша версия **Terraform** =1.5.Х (версия 1.6.Х может вызывать проблемы с Яндекс провайдером) 

1. Изучите проект. В файле variables.tf объявлены переменные для Yandex provider.
2. Создайте сервисный аккаунт и ключ. [service_account_key_file](https://terraform-provider.yandexcloud.net).
4. Сгенерируйте новый или используйте свой текущий ssh-ключ. Запишите его открытую(public) часть в переменную **vms_ssh_public_root_key**.
5. Инициализируйте проект, выполните код. Исправьте намеренно допущенные синтаксические ошибки. Ищите внимательно, посимвольно. Ответьте, в чём заключается их суть.
6. Подключитесь к консоли ВМ через ssh и выполните команду ``` curl ifconfig.me```.
Примечание: К OS ubuntu "out of a box, те из коробки" необходимо подключаться под пользователем ubuntu: ```"ssh ubuntu@vm_ip_address"```. Предварительно убедитесь, что ваш ключ добавлен в ssh-агент: ```eval $(ssh-agent) && ssh-add``` Вы познакомитесь с тем как при создании ВМ создать своего пользователя в блоке metadata в следующей лекции.;
8. Ответьте, как в процессе обучения могут пригодиться параметры ```preemptible = true``` и ```core_fraction=5``` в параметрах ВМ.

В качестве решения приложите:

- скриншот ЛК Yandex Cloud с созданной ВМ, где видно внешний ip-адрес;

    ![VM create](<images/Screenshot 2024-02-18 at 09.47.19.png>)
    ![yandex lk](<images/Screenshot 2024-02-18 at 09.47.43.png>)

- скриншот консоли, curl должен отобразить тот же внешний ip-адрес;

    ![curl in VM](<images/Screenshot 2024-02-18 at 09.48.43.png>)

- ответы на вопросы.


### Задание 2

1. Замените все хардкод-**значения** для ресурсов **yandex_compute_image** и **yandex_compute_instance** на **отдельные** переменные. К названиям переменных ВМ добавьте в начало префикс **vm_web_** .  Пример: **vm_web_name**.
2. Объявите нужные переменные в файле variables.tf, обязательно указывайте тип переменной. Заполните их **default** прежними значениями из main.tf. 
3. Проверьте terraform plan. Изменений быть не должно. 

**Ответ**

В файле variables.tf, необходимо внести следующие строки: 

```
variable "vm_web_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "my image"
}

variable "vm_web_instance" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "my instance"
}
```
В файл main.tf, необходимо скорректировать строки: 

```
data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image
}
resource "yandex_compute_instance" "vm-1" {
  name        = var.vm_web_instance
```

### Задание 3

1. Создайте в корне проекта файл 'vms_platform.tf' . Перенесите в него все переменные первой ВМ.
2. Скопируйте блок ресурса и создайте с его помощью вторую ВМ в файле main.tf: **"netology-develop-platform-db"** ,  ```cores  = 2, memory = 2, core_fraction = 20```. Объявите её переменные с префиксом **vm_db_** в том же файле ('vms_platform.tf').  ВМ должна работать в зоне "ru-central1-b"
3. Примените изменения.

**Ответ**

Значения хранящиеся в файле `vms_platform.tf`: 

```
## vars VM compute
variable "vm_web_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "my image"
}

variable "vm_web_instance" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "my instance"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "<your_ssh_ed25519_key>"
  description = "ssh-keygen -t ed25519"
}

## vars db VM
variable "vm_db_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "my image"
}

variable "vm_db_instance" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "my instance"
}

variable "vm_db_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vms_db_ssh_root_key" {
  type        = string
  default     = "<your_ssh_ed25519_key>"
  description = "ssh-keygen -t ed25519"
}
```

### Задание 4

1. Объявите в файле outputs.tf **один** output , содержащий: instance_name, external_ip, fqdn для каждой из ВМ в удобном лично для вас формате.
2. Примените изменения.

В качестве решения приложите вывод значений ip-адресов команды ```terraform output```.

**Ответ**

Вывод значений output-s:
```
Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:

FQDN_VM_DB = "fhmf0k6anqi9j1homi31.auto.internal"
FQDN_VM_web = "fhmgtcpb2ppucflm5jk4.auto.internal"
instance_name_VM_DB = "netology-develop-platform-db"
instance_name_VM_web = "netology-develop-platform-web"
public_ip_VM_DB = "158.160.59.25"
public_ip_VM_web = "158.160.49.234"
```

### Задание 5

1. В файле locals.tf опишите в **одном** local-блоке имя каждой ВМ, используйте интерполяцию ${..} с НЕСКОЛЬКИМИ переменными по примеру из лекции.
2. Замените переменные внутри ресурса ВМ на созданные вами local-переменные.
3. Примените изменения.

**Ответ**

Файл `locals.tf`:
```
locals {
  vm_prefix_db = "netology-develop-platform-db"
  vm_prefix_web = "netology-develop-platform-web"

  vm_count_db = 1
  vm_count_web = 2

  vm_names = {
    db = "${local.vm_prefix_db}-${local.vm_count_db}"
    web = "${local.vm_prefix_web}-${local.vm_count_web}"
  }
}
```

Так же необходимо скорректировать файл `main.tf`:

Для VM Web:
```
resource "yandex_compute_instance" "vm-1" {
  name = local.vm_names["web"]
  ...
```
Для VM DB:
```
resource "yandex_compute_instance" "vm-db" {
  name = local.vm_names["db"]
  ...
```

### Задание 6

1. Вместо использования трёх переменных  ".._cores",".._memory",".._core_fraction" в блоке  resources {...}, объедините их в единую map-переменную **vms_resources** и  внутри неё конфиги обеих ВМ в виде вложенного map.  
   ```
   пример из terraform.tfvars:
   vms_resources = {
     web={
       cores=
       memory=
       core_fraction=
       ...
     },
     db= {
       cores=
       memory=
       core_fraction=
       ...
     }
   }
   ```
3. Создайте и используйте отдельную map переменную для блока metadata, она должна быть общая для всех ваших ВМ.
   ```
   пример из terraform.tfvars:
   metadata = {
     serial-port-enable = 1
     ssh-keys           = "ubuntu:ssh-ed25519 AAAAC..."
   }
   ```  
  
5. Найдите и закоментируйте все, более не используемые переменные проекта.
6. Проверьте terraform plan. Изменений быть не должно.

**Ответ**

Содержание файла `terraform.tfvars`:
```
vms_resources = {
  web={
    cores= 1
    memory= 1
    core_fraction= 5
  },
  db= {
    cores= 2
    memory= 4
    core_fraction= 20
  }
}

metadata = {
  serial-port-enable = 1
  ssh-keys           = "ubuntu:ssh-ed25519"
}
```
------