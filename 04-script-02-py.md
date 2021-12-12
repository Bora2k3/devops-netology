### Домашнее задание к занятию "4.2. Использование Python для решения типовых DevOps задач"

#### Обязательные задания

#### 1. Есть скрипт:
	```python
    #!/usr/bin/env python3
	a = 1
	b = '2'
	c = a + b
	```
	* Какое значение будет присвоено переменной c?
	* Как получить для переменной c значение 12?
	* Как получить для переменной c значение 3?
* Какое значение будет присвоено переменной c? - Интерпретатор выдаст ошибку - попытка сложения целочисленного значения со строковым. 
* Как получить для переменной c значение 12?
```python
#!/usr/bin/env python3
a = 1
b = '2'
c = str(a) + b # Если допустим строковый результат
c = (a + int(b)) * int(b) * int(b) # Если допустим только целочисленный результат

```
* Как получить для переменной c значение 3?
```python
#!/usr/bin/env python3
a = 1
b = '2'
c = a + int(b)

```

#### 2. Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?

	```python
    #!/usr/bin/env python3

    import os

	bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
	result_os = os.popen(' && '.join(bash_command)).read()
    is_change = False
	for result in result_os.split('\n'):
        if result.find('modified') != -1:
            prepare_result = result.replace('\tmodified:   ', '')
            print(prepare_result)
            break

	```

```python
#!/usr/bin/env python3
import os

basedir = "~/netology/sysadm-homeworks"
bash_command = [f"cd {basedir}", "git status "]
result_os = os.popen(' && '.join(bash_command)).read()
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('modified:', basedir)
        print(prepare_result)

```
```shell
% python3 test.py
    ~/netology/sysadm-homeworks   README.md
```

#### 3. Доработать скрипт выше так, чтобы он мог проверять не только локальный репозиторий в текущей директории, а также умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.

```python
#!/usr/bin/env python3

import os
import sys

basedir = ""
try:
    basedir = sys.argv[1]
except:
    print("Incorrect repository path")

if basedir != "":
        bash_command = [f"cd {basedir}",  "git status "]
        result_os1 = os.listdir(basedir);

        if result_os1.__contains__(".git"):
                result_os = os.popen(' && '.join(bash_command)).read()
                for result in result_os.split('\n'):
                    if result.find('modified') != -1:
                        prepare_result = result.replace('modified:', basedir)
                        print(prepare_result)
        else:
                print("There is no git repository on the entered path")

```
```shell
% python3 test2.py Documents/DevOps/git/devops-netology
    Documents/DevOps/git/devops-netology   README.md
% python3 test2.py Documents/DevOps/
There is no git repository on the entered path
```


#### 4. Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем, что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. Проблема в том, что отдел, занимающийся нашей инфраструктурой очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена. Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков. Мы хотим написать скрипт, который опрашивает веб-сервисы, получает их IP, выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. Также, должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена - оповестить об этом в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. Будем считать, что наша разработка реализовала сервисы: drive.google.com, mail.google.com, google.com.

```python
#!/usr/bin/env python3

import socket
from string import whitespace

hosts = ["drive.google.com", "mail.google.com", "google.com"]
fileList = []

with open('host_test.log') as file:
    for f in file:
        fileList.append(f)

with open('host_test.log', 'w+') as file:
    for i in hosts:
        result = socket.gethostbyname(i)
        added = 0
        for y in fileList:
            inList = y.find(" {}".format(i))
            if (inList != -1):
                ipstr=y.replace('\n', '').split("  ")[1].translate({None: whitespace})
                if (ipstr == result):
                    print(" {}  {}\n".format(i, result))
                    file.write(" {}  {}\n".format(i, result))
                    added = 1
                    break
                else:
                    print("[ERROR] {} IP mismatch: {}  {}\n".format(i, ipstr, result))
                    file.write("[ERROR] {} IP mismatch: {}  {}\n".format(i, ipstr, result))
                    added = 1
                    break
        if (added == 0):
            print(" {}  {}\n".format(i, result))
            file.write(" {}  {}\n".format(i, result))

```
```shell
% python3 host_test.py
 drive.google.com  142.250.185.78

 mail.google.com  142.250.186.69

 google.com  142.250.184.238

 % python3 host_test.py
 drive.google.com  142.250.185.78

[ERROR] mail.google.com IP mismatch: 142.250.186.69  142.250.186.101

 google.com  142.250.184.238

 % python3 host_test.py
 drive.google.com  142.250.185.78

 mail.google.com  142.250.186.101

 google.com  142.250.184.238
```

#### Дополнительное задание (со звездочкой*) - необязательно к выполнению

Так получилось, что мы очень часто вносим правки в конфигурацию своей системы прямо на сервере. Но так как вся наша команда разработки держит файлы конфигурации в github и пользуется gitflow, то нам приходится каждый раз переносить архив с нашими изменениями с сервера на наш локальный компьютер, формировать новую ветку, коммитить в неё изменения, создавать pull request (PR) и только после выполнения Merge мы наконец можем официально подтвердить, что новая конфигурация применена. Мы хотим максимально автоматизировать всю цепочку действий. Для этого нам нужно написать скрипт, который будет в директории с локальным репозиторием обращаться по API к github, создавать PR для вливания текущей выбранной ветки в master с сообщением, которое мы вписываем в первый параметр при обращении к py-файлу (сообщение не может быть пустым). При желании, можно добавить к указанному функционалу создание новой ветки, commit и push в неё изменений конфигурации. С директорией локального репозитория можно делать всё, что угодно. Также, принимаем во внимание, что Merge Conflict у нас отсутствуют и их точно не будет при push, как в свою ветку, так и при слиянии в master. Важно получить конечный результат с созданным PR, в котором применяются наши изменения. 

#### Ваш скрипт:
```python
#!/usr/bin/env python3

import os
import subprocess
import sys
import time
import requests
import json
import re
from datetime import datetime


def git_exec(command):
    print(command)
    if command.find("git commit") >= 0:
        command_splitted = ["git", "commit", "-m"]
        command_splitted.append(command.split('git commit -m ')[1])
    else:
        command_splitted = command.split()
    command_e = subprocess.Popen(command_splitted, stdout=subprocess.PIPE,
                                 stderr=subprocess.STDOUT, cwd=resolved_path, text=True)
    e = command_e.communicate()[0].split('\n')[0]
    if e.find('fatal:') >= 0:
        print(
            f'В папке {resolved_path} нет git репозитория. Поищите в другой папке.')
        exit()
    return e


token = ""
if token == "":
    print(f"""
\t!!! Задайте токе в теле скрипта, переменная "token" !!!

\thttps://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token
""")
    exit()

try:
    if sys.argv[1]:
        message = " ".join(sys.argv[1:])
except IndexError:
    print(
        f"Введите сообщение для реквеста, например:\n\n\t{sys.argv[0]} поправил конфиг, была ошибка синтаксиса\n")
    exit()

path = "./"
resolved_path = os.path.normpath(os.path.abspath(
    os.path.expanduser(os.path.expandvars(path))))

try:
    origin_push_url = git_exec("git remote get-url --push origin")
except FileNotFoundError:
    print(
        f'Не могу найти папку {path}'
    )
    exit()

if origin_push_url.find('fatal:') >= 0:
    print(
        f'В папке {resolved_path} нет git репозитория. Поищите в другой папке.')
    exit()

gh_acc, gh_repo = re.split('git@github.com:|/|.git', origin_push_url)[1:3]

repo_url = f'https://api.github.com/repos/{gh_acc}/{gh_repo}'

headers = {"Authorization": f"token {token}",
           "Accept": "application/vnd.github.v3+json"}

git_status = subprocess.Popen(["git", "status", "--porcelain"], stdout=subprocess.PIPE,
                              stderr=subprocess.STDOUT, cwd=resolved_path, text=True).communicate()[0].split('\n')

cur_time = datetime.now()
branch_name = f"""{datetime.strftime(cur_time, "%Y-%m-%d_%H%M%S")}-config-local-edit"""
date_commit_text = datetime.strftime(cur_time, "%Y-%m-%d %H:%M:%S")

# exit()
if len(git_status) > 1 or git_status[0] != '':
    git_exec(f"git checkout -b {branch_name}")
    git_exec(f"git add .")
    git_exec(f"git commit -m 'config local edit at {date_commit_text}'")
    git_exec(f"git push --set-upstream origin {branch_name}")
    r = requests.get(f"{repo_url}/branches/{branch_name}", headers=headers)
    git_exec(f"git checkout main")
    while r.status_code >= 300:
        r = requests.get(f"{repo_url}/branches/{branch_name}", headers=headers)
        print(f'Репозитой пока не создан. Ответ GitHub: {r}, {r.content}')
        time.sleep(1)
    payload = {"title": branch_name, "body": message,
               "head": branch_name, "base": "main"}
    r = requests.post(f"{repo_url}/pulls", headers=headers,
                      data=json.dumps(payload))
    if r.status_code >= 300:
        print(
            f"Что-то пошло не так! Ответ GitHub API на создание Pull Request: {r}\n\n{r.content}\n")
        exit()
    else:
        print(f'Ответ GitHub на создание Pull Request: {r}')
        git_exec(f"git branch -D {branch_name}")
    pull_req_merge_url = f"{r.json()['url']}/merge"
    payload = {"commit_title": f"MERGED {branch_name} into main"}
    r = requests.put(pull_req_merge_url, headers=headers,
                     data=json.dumps(payload))
    if r.status_code >= 300:
        print(
            f"Что-то пошло не так! Ответ GitHub API на мерж Pull Request: {r}\n\n{r.content}\n")
        exit()
    else:
        print(f'Ответ GitHub на мерж Pull Request: {r}')
        git_exec(f"git push origin -d {branch_name}")
        print(f'\nЗагружаем изменения main:\n')
        os.popen(f"cd {resolved_path} && git pull").read()
        print(f'\n')
```

#### Вывод скрипта при запуске при тестировании:
```
???
```