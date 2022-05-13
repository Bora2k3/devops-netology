### Домашнее задание к занятию "09.05 Gitlab"

#### Подготовка к выполнению

1. Необходимо [зарегистрироваться](https://about.gitlab.com/free-trial/)
2. Создайте свой новый проект
3. Создайте новый репозиторий в gitlab, наполните его [файлами](./repository)
4. Проект должен быть публичным, остальные настройки по желанию

#### Основная часть

#### DevOps

В репозитории содержится код проекта на python. Проект - RESTful API сервис. Ваша задача автоматизировать сборку образа с выполнением python-скрипта:
1. Образ собирается на основе [centos:7](https://hub.docker.com/_/centos?tab=tags&page=1&ordering=last_updated)
2. Python версии не ниже 3.7
3. Установлены зависимости: `flask` `flask-jsonpify` `flask-restful`  
[requirements](https://gitlab.com/Bora2k3/09-ci-05-gitlab/-/blob/main/requirements.txt)
4. Создана директория `/python_api`
5. Скрипт из репозитория размещён в /python_api
6. Точка вызова: запуск скрипта  
[Dockerfile](https://gitlab.com/Bora2k3/09-ci-05-gitlab/-/blob/main/Dockerfile)  
7. Если сборка происходит на ветке `master`: Образ должен пушится в docker registry вашего gitlab `python-api:latest`, иначе этот шаг нужно пропустить  
[.gitlab-ci.yml](https://gitlab.com/Bora2k3/09-ci-05-gitlab/-/blob/main/.gitlab-ci.yml)  
[image](https://gitlab.com/Bora2k3/09-ci-05-gitlab/container_registry/3044801)  
```bash
$ docker pull registry.gitlab.com/bora2k3/09-ci-05-gitlab:latest
latest: Pulling from bora2k3/09-ci-05-gitlab
2d473b07cdd5: Pull complete
5076eea21a1e: Pull complete
d78c34ae7e60: Pull complete
6b1bb6a909ea: Pull complete
d59805949ffe: Pull complete
3c2d1c960e09: Pull complete
Digest: sha256:32600250883f6a4b33a7bf62cca7efef139a2bea00d93892d71666a3504f27c0
Status: Downloaded newer image for registry.gitlab.com/bora2k3/09-ci-05-gitlab:latest
registry.gitlab.com/bora2k3/09-ci-05-gitlab:latest

$ docker run -d --name 09-ci-05-gitlab -p 5290:5290 registry.gitlab.com/bora2k3/09-ci-05-gitlab:latest

$ curl localhost:5290/get_info
{"version": 3, "method": "GET", "message": "Already started"}
```

#### Product Owner

Вашему проекту нужна бизнесовая доработка: необходимо поменять JSON ответа на вызов метода GET `/rest/api/get_info`, необходимо создать Issue в котором указать:
1. Какой метод необходимо исправить
2. Текст с `{ "message": "Already started" }` на `{ "message": "Running"}`
3. Issue поставить label: feature  
[Issue](https://gitlab.com/Bora2k3/09-ci-05-gitlab/-/issues/1)

#### Developer

Вам пришел новый Issue на доработку, вам необходимо:
1. Создать отдельную ветку, связанную с этим issue
2. Внести изменения по тексту из задания
3. Подготовить Merge Requst, влить необходимые изменения в `master`, проверить, что сборка прошла успешно  
[Merge request](https://gitlab.com/Bora2k3/09-ci-05-gitlab/-/merge_requests/1)

#### Tester

Разработчики выполнили новый Issue, необходимо проверить валидность изменений:
1. Поднять докер-контейнер с образом `python-api:latest` и проверить возврат метода на корректность
```bash
$ curl localhost:5290/get_info
{"version": 3, "method": "GET", "message": "Running"}
```
2. Закрыть Issue с комментарием об успешности прохождения, указав желаемый результат и фактически достигнутый  
[Issue closed](https://gitlab.com/Bora2k3/09-ci-05-gitlab/-/issues/1)

#### Итог

После успешного прохождения всех ролей - отправьте ссылку на ваш проект в гитлаб, как решение домашнего задания  
[GitLab project](https://gitlab.com/Bora2k3/09-ci-05-gitlab)

#### Необязательная часть

Автомазируйте работу тестировщика, пусть у вас будет отдельный конвейер, который автоматически поднимает контейнер и выполняет проверку, например, при помощи curl. На основе вывода - будет приниматься решение об успешности прохождения тестирования
