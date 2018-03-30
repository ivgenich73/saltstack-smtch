# Тестовое задание на позицию DevOps engineer

В рамках тестового задания нужно написать скрипт, который будет анализировать логи веб-сервера по расписанию на наличие 50x ошибок.
Используя SaltStack установить на сервере nginx + php-fpm, подготовленный скрипт, запускающийся по расписанию.


## Как реализовано

Разворачивание тестовой среды происходит на двух vagrant-боксах (bento/ubuntu-16.04).

Боксам присвоены ip 192.168.50.10 (master) и 192.168.50.11 (minion) соответственно.

У миньона настроена синхронизированная директория xchng (/xchng).

С помощью saltstate разворачивается и конфигурируется (базово) nginx (install-nginx.sls, config-nginx.sls) и php-fpm (install-phpfpm.sls), а также добавляется cron задание на запуск скрипта (cronjob.sls).

Скрипт написан на python (xchng/analyzer.py) и выполняется ежеминутно.

Результатом выполнения скрипта являются два файла (errors и report) с временной меткой начала выполнения скрипта в имени файла.

Файл report содержит общую статистику (кол-во найденных 50х ошибок).

Файл errors содержит выборку 50x ошибок из журнала.

## Запуск и тестирование

Для запуска окружения необходимо клонировать репозиторий себе на машину и в корневой директории выполнить vagrant up.

### Проверка веб-сервера, php и генерация ошибок

По адресу http://192.168.50.11/ находится дефолтная индекс страница nginx.

По адресу http://192.168.50.11/info.php можно проверить функционирование php-fpm, а также просмотреть инфо.

По адресу http://192.168.50.11/error.php находится страница, которая генерирует ошибку 500 в логи веб-сервера (вызов страницы +1 ошибка в журнале).

### Результат работы скрипта

Скрипт генерирует логи своей работы в папку /xchng (xchng на хосте, синхронизирована).

### Пример

Папка xmpls содержит пример логов скрипта