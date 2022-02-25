### Домашнее задание к занятию "6.5. Elasticsearch"

#### Задача 1

В этом задании вы потренируетесь в:
- установке elasticsearch
- первоначальном конфигурировании elastcisearch
- запуске elasticsearch в docker

Используя докер образ [centos:7](https://hub.docker.com/_/centos) как базовый и 
[документацию по установке и запуску Elastcisearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/targz.html):

- составьте Dockerfile-манифест для elasticsearch
- соберите docker-образ и сделайте `push` в ваш docker.io репозиторий
- запустите контейнер из получившегося образа и выполните запрос пути `/` c хост-машины

Требования к `elasticsearch.yml`:
- данные `path` должны сохраняться в `/var/lib`
- имя ноды должно быть `netology_test`

В ответе приведите:
- текст Dockerfile манифеста
```dockerfile
FROM centos:7

EXPOSE 9200 9300

USER 0

RUN export ES_HOME="/var/lib/elasticsearch" && \
    yum -y install wget && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.17.0-linux-x86_64.tar.gz && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.17.0-linux-x86_64.tar.gz.sha512 && \
    sha512sum -c elasticsearch-7.17.0-linux-x86_64.tar.gz.sha512 && \
    tar -xzf elasticsearch-7.17.0-linux-x86_64.tar.gz && \
    rm -f elasticsearch-7.17.0-linux-x86_64.tar.gz* && \
    mv elasticsearch-7.17.0 ${ES_HOME} && \
    useradd -m -u 1000 elasticsearch && \
    chown elasticsearch:elasticsearch -R ${ES_HOME} && \
    yum -y remove wget && \
    yum clean all

COPY --chown=elasticsearch:elasticsearch config/* /var/lib/elasticsearch/config/
    
USER 1000

ENV ES_HOME="/var/lib/elasticsearch" \
    ES_PATH_CONF="/var/lib/elasticsearch/config"
WORKDIR ${ES_HOME}

CMD ["sh", "-c", "${ES_HOME}/bin/elasticsearch"]
```
```bash
$ docker build . -t podkovka/devops-elasticsearch:7.17
$ docker login -u "podkovka" -p "***" docker.io
$ docker push podkovka/devops-elasticsearch:7.17
```
- ссылку на образ в репозитории dockerhub
https://hub.docker.com/repository/docker/podkovka/devops-elasticsearch
- ответ `elasticsearch` на запрос пути `/` в json виде
```bash
$ docker run --rm -d --name elastic -p 9200:9200 -p 9300:9300 podkovka/devops-elasticsearch:7.17
$ docker ps
CONTAINER ID   IMAGE                                COMMAND                  CREATED          STATUS          PORTS                                            NAMES
5262d69644f7   podkovka/devops-elasticsearch:7.17   "sh -c ${ES_HOME}/bi…"   7 seconds ago   Up 6 seconds   0.0.0.0:9200->9200/tcp, 0.0.0.0:9300->9300/tcp   elastic
$ curl -X GET 'localhost:9200/'
```
```json
{
  "name" : "netology_test",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "1jxOaMjeQASfgV6f8TOKSg",
  "version" : {
    "number" : "7.17.0",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "bee86328705acaa9a6daede7140defd4d9ec56bd",
    "build_date" : "2022-01-28T08:36:04.875279988Z",
    "build_snapshot" : false,
    "lucene_version" : "8.11.1",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}
```
Подсказки:
- возможно вам понадобится установка пакета perl-Digest-SHA для корректной работы пакета shasum
- при сетевых проблемах внимательно изучите кластерные и сетевые настройки в elasticsearch.yml
- при некоторых проблемах вам поможет docker директива ulimit
- elasticsearch в логах обычно описывает проблему и пути ее решения

Далее мы будем работать с данным экземпляром elasticsearch.

#### Задача 2

В этом задании вы научитесь:
- создавать и удалять индексы
- изучать состояние кластера
- обосновывать причину деградации доступности данных

Ознакомьтесь с [документацией](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html) 
и добавьте в `elasticsearch` 3 индекса, в соответствии со таблицей:

| Имя | Количество реплик | Количество шард |
|-----|-------------------|-----------------|
| ind-1| 0 | 1 |
| ind-2 | 1 | 2 |
| ind-3 | 2 | 4 |

```bash
$ curl -X PUT "localhost:9200/ind-1?pretty" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0
  }
}
'
```
```bash
$ curl -X PUT "localhost:9200/ind-2?pretty" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "number_of_shards": 2,
    "number_of_replicas": 1
  }
}
'
```
```bash
$ curl -X PUT "localhost:9200/ind-3?pretty" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "number_of_shards": 4,
    "number_of_replicas": 2
  }
}
'
```
Получите список индексов и их статусов, используя API и **приведите в ответе** на задание.
```bash
$ curl 'localhost:9200/_cat/indices?v'
health status index            uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   .geoip_databases S1DKUc-ZQveldv2h1TUPAw   1   0         41            0     68.3mb         68.3mb
green  open   ind-1            QPj0D8erSI-AfTEYyOuO8w   1   0          0            0       226b           226b
yellow open   ind-3            mQ-LzoMaSWCDAuwnzFS1Eg   4   2          0            0       604b           604b
yellow open   ind-2            QYDwZVqoR3ulaN7P6m4Tgw   2   1          0            0       452b           452b
```
Получите состояние кластера `elasticsearch`, используя API.
```bash
$ curl -X GET "localhost:9200/_cluster/health?pretty"
{
  "cluster_name" : "elasticsearch",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 10,
  "active_shards" : 10,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 10,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 50.0
}
```
Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?
```
Первичный шард и реплика не могут находиться на одном узле, если копия не назначена. Таким образом, один узел не может размещать копии
```
Удалите все индексы.
```bash
$ curl -X DELETE 'http://localhost:9200/_all'
```

**Важно**

При проектировании кластера elasticsearch нужно корректно рассчитывать количество реплик и шард,
иначе возможна потеря данных индексов, вплоть до полной, при деградации системы.

#### Задача 3

В данном задании вы научитесь:
- создавать бэкапы данных
- восстанавливать индексы из бэкапов

Создайте директорию `{путь до корневой директории с elasticsearch в образе}/snapshots`.
```bash
$ docker exec -u root -it elastic bash
[root@78b9c79f6a2f elasticsearch]# mkdir $ES_HOME/snapshots
```

Используя API [зарегистрируйте](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-register-repository.html#snapshots-register-repository) 
данную директорию как `snapshot repository` c именем `netology_backup`.
```bash
# echo path.repo: [ "/var/lib/elasticsearch/snapshots" ] >> "$ES_HOME/config/elasticsearch.yml"
# chown elasticsearch:elasticsearch /var/lib/elasticsearch/snapshots
$ docker restart elastic
$ curl -X PUT "localhost:9200/_snapshot/netology_backup?pretty" -H 'Content-Type: application/json' -d'
{
  "type": "fs",
  "settings": {
    "location": "/var/lib/elasticsearch/snapshots",
    "compress": true
  }
}'
{"acknowledged":true}
```

**Приведите в ответе** запрос API и результат вызова API для создания репозитория.

Создайте индекс `test` с 0 реплик и 1 шардом и **приведите в ответе** список индексов.

```bash
$ curl -X PUT "localhost:9200/test?pretty" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0
  }
}
'
$ $ curl 'localhost:9200/_cat/indices?v'
health status index            uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   .geoip_databases S1DKUc-ZQveldv2h1TUPAw   1   0         41            0     68.3mb         68.3mb
green  open   test             z-KFN9TDRNiDeZiwiSjt3A   1   0          0            0       226b           226b
```

[Создайте `snapshot`](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html) 
состояния кластера `elasticsearch`.

```bash
$ curl -X PUT "localhost:9200/_snapshot/netology_backup/snapshot_1?wait_for_completion=true&pretty"
```

**Приведите в ответе** список файлов в директории со `snapshot`ами.
```bash
$ docker exec -it elastic ls -l /var/lib/elasticsearch/snapshots/
total 28
-rw-r--r-- 1 elasticsearch elasticsearch 1422 Feb 20 12:18 index-0
-rw-r--r-- 1 elasticsearch elasticsearch    8 Feb 20 12:18 index.latest
drwxr-xr-x 6 elasticsearch elasticsearch 4096 Feb 20 12:18 indices
-rw-r--r-- 1 elasticsearch elasticsearch 9688 Feb 20 12:18 meta--3PjnnAUQAKLY_SmssKV4g.dat
-rw-r--r-- 1 elasticsearch elasticsearch  452 Feb 20 12:18 snap--3PjnnAUQAKLY_SmssKV4g.dat
```

Удалите индекс `test` и создайте индекс `test-2`. **Приведите в ответе** список индексов.

```bash
$ curl -X DELETE "localhost:9200/test?pretty"
$ curl -X PUT "localhost:9200/test-2?pretty" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0
  }
}
'
$ curl 'localhost:9200/_cat/indices?pretty'
green open .geoip_databases S1DKUc-ZQveldv2h1TUPAw 1 0 41 0 38.6mb 38.6mb
green open test-2           Xw_SdQXLQZuWJ8xHFxP8vw 1 0  0 0   226b   226b
```

[Восстановите](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html) состояние
кластера `elasticsearch` из `snapshot`, созданного ранее. 

**Приведите в ответе** запрос к API восстановления и итоговый список индексов.
```bash
curl -X POST "localhost:9200/_snapshot/netology_backup/snapshot_1/_restore?pretty" -H 'Content-Type: application/json' -d'
{
  "indices": "*",
  "include_global_state": true
}
'
```
```bash
$ curl 'localhost:9200/_cat/indices?pretty'
green open .geoip_databases fcVEZmMuTvmGLIeMVcRHIw 1 0 41 0 38.6mb 38.6mb
green open test             MtWpG0_HR_uliyAcAaBVyw 1 0  0 0   226b   226b
```
** из-за ошибок пришлось закрыть индексы, чтобы прошло восстановление
```bash
$ curl -X POST "localhost:9200/.ds-ilm-history-5-2022.02.20-000001/_close?pretty"
$ curl -X POST "localhost:9200/.ds-.logs-deprecation.elasticsearch-default-2022.02.20-000001/_close?pretty"
```
Подсказки:
- возможно вам понадобится доработать `elasticsearch.yml` в части директивы `path.repo` и перезапустить `elasticsearch`