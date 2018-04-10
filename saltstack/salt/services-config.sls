php7.0-fpm:
    service.running:
        - watch:
            - file: /etc/php/7.0/fpm/php.ini
    file.replace:
        - name: /etc/php/7.0/fpm/php.ini
        - pattern: ;cgi.fix_pathinfo=1
        - repl: cgi.fix_pathinfo=0

copy php version check file:
    file.managed:
        - name: /var/www/html/info.php
        - source: salt://files/info.php

copy error generator file:
    file.managed:
        - name: /var/www/html/error.php
        - source: salt://files/error.php

nginx:
    service.running:
        - watch:
            - file: /etc/nginx/sites-available/default
    file.managed:
        - name: /etc/nginx/sites-available/default
        - source: salt://files/default