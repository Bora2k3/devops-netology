### Домашнее задание к занятию "6.4. PostgreSQL"

#### Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

```bash
$ docker run --rm --name postgresql-docker \
    -e POSTGRES_PASSWORD=netology \
    -v my_data:/var/lib/postgresql/data \
    -p 5432:5432 \
    -d postgres:13
$ docker ps
CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS          PORTS                    NAMES
0f1a8ab04779   postgres:13   "docker-entrypoint.s…"   11 seconds ago   Up 10 seconds   0.0.0.0:5432->5432/tcp   postgresql-docker
```

Подключитесь к БД PostgreSQL используя `psql`.

```bash
$ docker exec -it postgresql-docker bash
root@0f1a8ab04779:/# psql -U postgres
psql (13.6 (Debian 13.6-1.pgdg110+1))
Type "help" for help.

postgres=#
```

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

**Найдите и приведите** управляющие команды для:
- вывода списка БД
```bash
postgres-# \l+
                                                                   List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   |  Size   | Tablespace |                Description
-----------+----------+----------+------------+------------+-----------------------+---------+------------+--------------------------------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |                       | 7901 kB | pg_default | default administrative connection database
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +| 7753 kB | pg_default | unmodifiable empty database
           |          |          |            |            | postgres=CTc/postgres |         |            |
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +| 7753 kB | pg_default | default template for new databases
           |          |          |            |            | postgres=CTc/postgres |         |            |
(3 rows)
```
- подключения к БД
```bash
postgres=# \conninfo
You are connected to database "postgres" as user "postgres" via socket in "/var/run/postgresql" at port "5432".
```
<details><summary>вывода списка таблиц</summary>

```bash
postgres=# \dtS
                    List of relations
   Schema   |          Name           | Type  |  Owner
------------+-------------------------+-------+----------
 pg_catalog | pg_aggregate            | table | postgres
 pg_catalog | pg_am                   | table | postgres
 pg_catalog | pg_amop                 | table | postgres
 pg_catalog | pg_amproc               | table | postgres
 pg_catalog | pg_attrdef              | table | postgres
 pg_catalog | pg_attribute            | table | postgres
 pg_catalog | pg_auth_members         | table | postgres
 pg_catalog | pg_authid               | table | postgres
 pg_catalog | pg_cast                 | table | postgres
 pg_catalog | pg_class                | table | postgres
 pg_catalog | pg_collation            | table | postgres
 pg_catalog | pg_constraint           | table | postgres
 pg_catalog | pg_conversion           | table | postgres
 pg_catalog | pg_database             | table | postgres
 pg_catalog | pg_db_role_setting      | table | postgres
 pg_catalog | pg_default_acl          | table | postgres
 pg_catalog | pg_depend               | table | postgres
 pg_catalog | pg_description          | table | postgres
 pg_catalog | pg_enum                 | table | postgres
 pg_catalog | pg_event_trigger        | table | postgres
 pg_catalog | pg_extension            | table | postgres
 pg_catalog | pg_foreign_data_wrapper | table | postgres
 pg_catalog | pg_foreign_server       | table | postgres
 pg_catalog | pg_foreign_table        | table | postgres
 pg_catalog | pg_index                | table | postgres
 pg_catalog | pg_inherits             | table | postgres
 pg_catalog | pg_init_privs           | table | postgres
 pg_catalog | pg_language             | table | postgres
 pg_catalog | pg_largeobject          | table | postgres
 pg_catalog | pg_largeobject_metadata | table | postgres
 pg_catalog | pg_namespace            | table | postgres
 pg_catalog | pg_opclass              | table | postgres
 pg_catalog | pg_operator             | table | postgres
 pg_catalog | pg_opfamily             | table | postgres
 pg_catalog | pg_partitioned_table    | table | postgres
 pg_catalog | pg_policy               | table | postgres
 pg_catalog | pg_proc                 | table | postgres
 pg_catalog | pg_publication          | table | postgres
 pg_catalog | pg_publication_rel      | table | postgres
 pg_catalog | pg_range                | table | postgres
 pg_catalog | pg_replication_origin   | table | postgres
 pg_catalog | pg_rewrite              | table | postgres
 pg_catalog | pg_seclabel             | table | postgres
 pg_catalog | pg_sequence             | table | postgres
 pg_catalog | pg_shdepend             | table | postgres
 pg_catalog | pg_shdescription        | table | postgres
 pg_catalog | pg_shseclabel           | table | postgres
 pg_catalog | pg_statistic            | table | postgres
 pg_catalog | pg_statistic_ext        | table | postgres
 pg_catalog | pg_statistic_ext_data   | table | postgres
 pg_catalog | pg_subscription         | table | postgres
 pg_catalog | pg_subscription_rel     | table | postgres
 pg_catalog | pg_tablespace           | table | postgres
 pg_catalog | pg_transform            | table | postgres
 pg_catalog | pg_trigger              | table | postgres
 pg_catalog | pg_ts_config            | table | postgres
 pg_catalog | pg_ts_config_map        | table | postgres
 pg_catalog | pg_ts_dict              | table | postgres
 pg_catalog | pg_ts_parser            | table | postgres
 pg_catalog | pg_ts_template          | table | postgres
 pg_catalog | pg_type                 | table | postgres
 pg_catalog | pg_user_mapping         | table | postgres
(62 rows)
```
</details>

<details><summary>вывода описания содержимого таблиц</summary>

```bash
postgres=# \dS+
                                            List of relations
   Schema   |              Name               | Type  |  Owner   | Persistence |    Size    | Description
------------+---------------------------------+-------+----------+-------------+------------+-------------
 pg_catalog | pg_aggregate                    | table | postgres | permanent   | 56 kB      |
 pg_catalog | pg_am                           | table | postgres | permanent   | 40 kB      |
 pg_catalog | pg_amop                         | table | postgres | permanent   | 80 kB      |
 pg_catalog | pg_amproc                       | table | postgres | permanent   | 64 kB      |
 pg_catalog | pg_attrdef                      | table | postgres | permanent   | 8192 bytes |
 pg_catalog | pg_attribute                    | table | postgres | permanent   | 456 kB     |
 pg_catalog | pg_auth_members                 | table | postgres | permanent   | 40 kB      |
 pg_catalog | pg_authid                       | table | postgres | permanent   | 48 kB      |
 pg_catalog | pg_available_extension_versions | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_available_extensions         | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_cast                         | table | postgres | permanent   | 48 kB      |
 pg_catalog | pg_class                        | table | postgres | permanent   | 136 kB     |
 pg_catalog | pg_collation                    | table | postgres | permanent   | 240 kB     |
 pg_catalog | pg_config                       | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_constraint                   | table | postgres | permanent   | 48 kB      |
 pg_catalog | pg_conversion                   | table | postgres | permanent   | 48 kB      |
 pg_catalog | pg_cursors                      | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_database                     | table | postgres | permanent   | 48 kB      |
 pg_catalog | pg_db_role_setting              | table | postgres | permanent   | 8192 bytes |
 pg_catalog | pg_default_acl                  | table | postgres | permanent   | 8192 bytes |
 pg_catalog | pg_depend                       | table | postgres | permanent   | 488 kB     |
 pg_catalog | pg_description                  | table | postgres | permanent   | 376 kB     |
 pg_catalog | pg_enum                         | table | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_event_trigger                | table | postgres | permanent   | 8192 bytes |
 pg_catalog | pg_extension                    | table | postgres | permanent   | 48 kB      |
 pg_catalog | pg_file_settings                | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_foreign_data_wrapper         | table | postgres | permanent   | 8192 bytes |
 pg_catalog | pg_foreign_server               | table | postgres | permanent   | 8192 bytes |
 pg_catalog | pg_foreign_table                | table | postgres | permanent   | 8192 bytes |
 pg_catalog | pg_group                        | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_hba_file_rules               | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_index                        | table | postgres | permanent   | 64 kB      |
 pg_catalog | pg_indexes                      | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_inherits                     | table | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_init_privs                   | table | postgres | permanent   | 56 kB      |
 pg_catalog | pg_language                     | table | postgres | permanent   | 48 kB      |
 pg_catalog | pg_largeobject                  | table | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_largeobject_metadata         | table | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_locks                        | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_matviews                     | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_namespace                    | table | postgres | permanent   | 48 kB      |
 pg_catalog | pg_opclass                      | table | postgres | permanent   | 48 kB      |
 pg_catalog | pg_operator                     | table | postgres | permanent   | 144 kB     |
 pg_catalog | pg_opfamily                     | table | postgres | permanent   | 48 kB      |
 pg_catalog | pg_partitioned_table            | table | postgres | permanent   | 8192 bytes |
 pg_catalog | pg_policies                     | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_policy                       | table | postgres | permanent   | 8192 bytes |
 pg_catalog | pg_prepared_statements          | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_prepared_xacts               | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_proc                         | table | postgres | permanent   | 688 kB     |
 pg_catalog | pg_publication                  | table | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_publication_rel              | table | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_publication_tables           | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_range                        | table | postgres | permanent   | 40 kB      |
 pg_catalog | pg_replication_origin           | table | postgres | permanent   | 8192 bytes |
 pg_catalog | pg_replication_origin_status    | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_replication_slots            | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_rewrite                      | table | postgres | permanent   | 656 kB     |
 pg_catalog | pg_roles                        | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_rules                        | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_seclabel                     | table | postgres | permanent   | 8192 bytes |
 pg_catalog | pg_seclabels                    | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_sequence                     | table | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_sequences                    | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_settings                     | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_shadow                       | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_shdepend                     | table | postgres | permanent   | 40 kB      |
 pg_catalog | pg_shdescription                | table | postgres | permanent   | 48 kB      |
 pg_catalog | pg_shmem_allocations            | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_shseclabel                   | table | postgres | permanent   | 8192 bytes |
 pg_catalog | pg_stat_activity                | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_stat_all_indexes             | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_stat_all_tables              | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_stat_archiver                | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_stat_bgwriter                | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_stat_database                | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_stat_database_conflicts      | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_stat_gssapi                  | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_stat_progress_analyze        | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_stat_progress_basebackup     | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_stat_progress_cluster        | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_stat_progress_create_index   | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_stat_progress_vacuum         | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_stat_replication             | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_stat_slru                    | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_stat_ssl                     | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_stat_subscription            | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_stat_sys_indexes             | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_stat_sys_tables              | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_stat_user_functions          | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_stat_user_indexes            | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_stat_user_tables             | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_stat_wal_receiver            | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_stat_xact_all_tables         | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_stat_xact_sys_tables         | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_stat_xact_user_functions     | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_stat_xact_user_tables        | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_statio_all_indexes           | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_statio_all_sequences         | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_statio_all_tables            | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_statio_sys_indexes           | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_statio_sys_sequences         | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_statio_sys_tables            | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_statio_user_indexes          | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_statio_user_sequences        | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_statio_user_tables           | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_statistic                    | table | postgres | permanent   | 248 kB     |
 pg_catalog | pg_statistic_ext                | table | postgres | permanent   | 8192 bytes |
 pg_catalog | pg_statistic_ext_data           | table | postgres | permanent   | 8192 bytes |
 pg_catalog | pg_stats                        | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_stats_ext                    | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_subscription                 | table | postgres | permanent   | 8192 bytes |
 pg_catalog | pg_subscription_rel             | table | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_tables                       | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_tablespace                   | table | postgres | permanent   | 48 kB      |
 pg_catalog | pg_timezone_abbrevs             | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_timezone_names               | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_transform                    | table | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_trigger                      | table | postgres | permanent   | 8192 bytes |
 pg_catalog | pg_ts_config                    | table | postgres | permanent   | 40 kB      |
 pg_catalog | pg_ts_config_map                | table | postgres | permanent   | 56 kB      |
 pg_catalog | pg_ts_dict                      | table | postgres | permanent   | 48 kB      |
 pg_catalog | pg_ts_parser                    | table | postgres | permanent   | 40 kB      |
 pg_catalog | pg_ts_template                  | table | postgres | permanent   | 40 kB      |
 pg_catalog | pg_type                         | table | postgres | permanent   | 120 kB     |
 pg_catalog | pg_user                         | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_user_mapping                 | table | postgres | permanent   | 8192 bytes |
 pg_catalog | pg_user_mappings                | view  | postgres | permanent   | 0 bytes    |
 pg_catalog | pg_views                        | view  | postgres | permanent   | 0 bytes    |
(129 rows)
```
</details>

- выхода из psql
```bash
postgres=# \q
root@0f1a8ab04779:/#
```

#### Задача 2

Используя `psql` создайте БД `test_database`.

```bash
root@0f1a8ab04779:/# psql -U postgres
psql (13.6 (Debian 13.6-1.pgdg110+1))
Type "help" for help.

postgres=# CREATE DATABASE test_database;
CREATE DATABASE
```

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/master/06-db-04-postgresql/test_data).

Восстановите бэкап БД в `test_database`.

```bash
vagrant@debian:~$ docker cp ../../vagrant_data/test_dump.sql postgresql-docker:/tmp
vagrant@debian:~$ docker exec -it postgresql-docker bash
root@0f1a8ab04779:/# psql -U postgres -f /tmp/test_dump.sql  test_database
SET
SET
SET
SET
SET
 set_config
------------

(1 row)

SET
SET
SET
SET
SET
SET
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
ALTER TABLE
COPY 8
 setval
--------
      8
(1 row)

ALTER TABLE
```

Перейдите в управляющую консоль `psql` внутри контейнера.

```bash
root@0f1a8ab04779:/# psql -U postgres
psql (13.6 (Debian 13.6-1.pgdg110+1))
Type "help" for help.

```

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

```bash
postgres=# \c test_database
You are now connected to database "test_database" as user "postgres".
test_database=# \dt
         List of relations
 Schema |  Name  | Type  |  Owner
--------+--------+-------+----------
 public | orders | table | postgres
(1 row)

test_database=# ANALYZE VERBOSE public.orders;
INFO:  analyzing "public.orders"
INFO:  "orders": scanned 1 of 1 pages, containing 8 live rows and 0 dead rows; 8 rows in sample, 8 estimated total rows
ANALYZE
```

Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` 
с наибольшим средним значением размера элементов в байтах.

```bash
test_database=# SELECT avg_width FROM pg_stats WHERE tablename='orders';
 avg_width
-----------
         4
        16
         4
(3 rows)

```

**Приведите в ответе** команду, которую вы использовали для вычисления и полученный результат.

#### Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили
провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).

Предложите SQL-транзакцию для проведения данной операции.

```bash
test_database=# CREATE TABLE orders_more_499_price (CHECK (price > 499)) INHERITS (orders);
CREATE TABLE
test_database=# INSERT INTO orders_more_499_price SELECT * FROM orders WHERE price > 499;
INSERT 0 3
test_database=# CREATE TABLE orders_less_499_price (CHECK (price <= 499)) INHERITS (orders);
CREATE TABLE
test_database=# INSERT INTO orders_LESS_499_price SELECT * FROM orders WHERE price <= 499;
INSERT 0 5
test_database=# DELETE FROM ONLY orders;
DELETE 8
test_database=# \dt
                 List of relations
 Schema |         Name          | Type  |  Owner
--------+-----------------------+-------+----------
 public | orders                | table | postgres
 public | orders_less_499_price | table | postgres
 public | orders_more_499_price | table | postgres
(3 rows)

```

Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?

Да, прописав правила вставки, например:
```postgresql
CREATE RULE orders_insert_to_more AS ON INSERT TO orders WHERE ( price > 499 ) DO INSTEAD INSERT INTO orders_more_499_price VALUES (NEW.*);
CREATE RULE orders_insert_to_less AS ON INSERT TO orders WHERE ( price <= 499 ) DO INSTEAD INSERT INTO orders_less_499_price VALUES (NEW.*);
```

#### Задача 4

Используя утилиту `pg_dump` создайте бекап БД `test_database`.

```bash
export PGPASSWORD=netology && pg_dump -h localhost -U postgres test_database > /tmp/test_database_backup.sql
```

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?

Например, добавить свойство UNIQUE
```bash
title character varying(80) NOT NULL UNIQUE,
```