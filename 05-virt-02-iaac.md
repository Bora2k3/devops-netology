### Домашнее задание к занятию "5.2. Применение принципов IaaC в работе с виртуальными машинами"

#### Задача 1

- Опишите своими словами основные преимущества применения на практике IaaC паттернов.
```
- Скорость и уменьшение затрат: позволяет быстрее конфигурировать инфраструктуру и направлен на обеспечение прозрачности.
- Восстановление в аварийных ситуациях: эффективный способ отслеживания вашей инфраструктуры и повторного развертывания
последнего работоспособного состояния после сбоя или катастрофы любого рода.
- Безопасность и документирование: за провижен всех вычислительных, сетевых и служб хранения отвечает код,
они каждый раз будут развертываться одинаково. Т.к. код можно версионировать, IaaC позволяет документировать, регистрировать
и отслеживать каждое изменение конфигурации вашего сервера.
- Масштабируемость и стандартизация: развертывания инфраструктуры с помощью IaaC повторяемы и предотвращают проблемы во время
выполнения, вызванных дрейфом конфигурации или отсутствием зависимостей. IaaC полностью стандартизирует сетап инфраструктуры,
что снижает вероятность ошибок или отклонений.
```
- Какой из принципов IaaC является основополагающим?
```
Идемпотентность - свойство объекта или операции при повторном применении операции к объекту давать тот же результат,
что и при первом.
```

#### Задача 2

- Чем Ansible выгодно отличается от других систем управление конфигурациями?
```
- При неуспешной доставке конфигурации на сервер, оповестит об этом.
- Для описания конфигурационных файлов используется удобный для чтения формат YAML.
- Работает без агента на клиентах, используя ssh для доступа.
- Ansible Galaxy - огромное комьюнити, где можно найти практически любое решение.
```
- Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?
```
Имееют права на жизнь оба метода. И различные инструменты управления конфигурацией заточены под тот или иной метод.
Например, Chef, Puppet, CFEngine используют pull, Pulumi, Otter, Terraform, Ansible - push, а SaltStack, DSC - push/pull.
По моему мнению push надёжней, т.к. централизованно управляет конфигурацией и исключает ситуации, когда прямое изменеие
на сервере не отразится в репозитории, что может привести к непредсказуемым ситуациям. Хотя бытует мнение, что pull безопаснее,
поскольку учетные данные кластера недоступны за его пределами. Но если кто-то проникнет в ваш репозиторий git и сможет push'ить
туда код, то он сможет развернуть все, что пожелает (независимо от выбранного подхода, будет это pull или push),
и внедриться в системы кластера. Таким образом, наиболее важными компонентами, требующими защиты, являются git-репозиторий
и CI/CD-системы, а не учетные данные кластера.

```

#### Задача 3

Установить на личный компьютер:

- VirtualBox
- Vagrant
- Ansible

*Приложить вывод команд установленных версий каждой из программ, оформленный в markdown.*

```
xxx@NextCloud:~$ virtualboxvm -h
Oracle VM VirtualBox VM Runner v6.1.30
(C) 2005-2021 Oracle Corporation
All rights reserved.
```
```
xxx@NextCloud:~$ vagrant -v
Vagrant 2.2.19
```
```
xxx@NextCloud:~$ ansible --version
ansible [core 2.12.1]
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/xxx/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /home/xxx/.local/lib/python3.9/site-packages/ansible
  ansible collection location = /home/xxx/.ansible/collections:/usr/share/ansible/collections
  executable location = /home/xxx/.local/bin/ansible
  python version = 3.9.2 (default, Feb 28 2021, 17:03:44) [GCC 10.2.1 20210110]
  jinja version = 3.0.3
  libyaml = True
```

#### Задача 4 (*)

Воспроизвести практическую часть лекции самостоятельно.

- Создать виртуальную машину.
- Зайти внутрь ВМ, убедиться, что Docker установлен с помощью команды
```
docker ps
```

```
xxx@NextCloud:~/Documents/VM/05-virt-02-iaac/vagrant$ vagrant up
Bringing machine 'server1.netology' up with 'virtualbox' provider...
==> server1.netology: Importing base box 'bento/ubuntu-20.04'...
==> server1.netology: Matching MAC address for NAT networking...
==> server1.netology: Checking if box 'bento/ubuntu-20.04' version '202112.19.0' is up to date...
==> server1.netology: Setting the name of the VM: server1.netology
==> server1.netology: Clearing any previously set network interfaces...
==> server1.netology: Preparing network interfaces based on configuration...
    server1.netology: Adapter 1: nat
    server1.netology: Adapter 2: hostonly
==> server1.netology: Forwarding ports...
    server1.netology: 22 (guest) => 20011 (host) (adapter 1)
    server1.netology: 22 (guest) => 2222 (host) (adapter 1)
==> server1.netology: Running 'pre-boot' VM customizations...
==> server1.netology: Booting VM...
==> server1.netology: Waiting for machine to boot. This may take a few minutes...
    server1.netology: SSH address: 127.0.0.1:2222
    server1.netology: SSH username: vagrant
    server1.netology: SSH auth method: private key
    server1.netology: Warning: Remote connection disconnect. Retrying...
    server1.netology: Warning: Connection reset. Retrying...
    server1.netology: 
    server1.netology: Vagrant insecure key detected. Vagrant will automatically replace
    server1.netology: this with a newly generated keypair for better security.
    server1.netology: 
    server1.netology: Inserting generated public key within guest...
    server1.netology: Removing insecure key from the guest if it's present...
    server1.netology: Key inserted! Disconnecting and reconnecting using new SSH key...
==> server1.netology: Machine booted and ready!
==> server1.netology: Checking for guest additions in VM...
==> server1.netology: Setting hostname...
==> server1.netology: Configuring and enabling network interfaces...
==> server1.netology: Mounting shared folders...
    server1.netology: /vagrant => /home/podkovka/Documents/VM/05-virt-02-iaac/vagrant
==> server1.netology: Running provisioner: ansible...
    server1.netology: Running ansible-playbook...

PLAY [nodes] *******************************************************************

TASK [Gathering Facts] *********************************************************
ok: [server1.netology]

TASK [Create directory for ssh-keys] *******************************************
ok: [server1.netology]

TASK [Adding rsa-key in /root/.ssh/authorized_keys] ****************************
An exception occurred during task execution. To see the full traceback, use -vvv. The error was: If you are using a module and expect the file to exist on the remote, see the remote_src option
fatal: [server1.netology]: FAILED! => {"changed": false, "msg": "Could not find or access '~/.ssh/id_rsa.pub' on the Ansible Controller.\nIf you are using a module and expect the file to exist on the remote, see the remote_src option"}
...ignoring

TASK [Checking DNS] ************************************************************
changed: [server1.netology]

TASK [Installing tools] ********************************************************
ok: [server1.netology] => (item=git)
ok: [server1.netology] => (item=curl)

TASK [Installing docker] *******************************************************
changed: [server1.netology]

TASK [Add the current user to docker group] ************************************
changed: [server1.netology]

PLAY RECAP *********************************************************************
server1.netology           : ok=7    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=1   

xxx@NextCloud:~/Documents/VM/05-virt-02-iaac/vagrant$ vagrant ssh
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-91-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

 System information disabled due to load higher than 1.0


This system is built by the Bento project by Chef Software
More information can be found at https://github.com/chef/bento
Last login: Fri Jan 18 19:08:53 2022 from 10.0.2.2
vagrant@server1:~$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
vagrant@server1:~$
```