nginx_config:
  file.copy:
    - name: /etc/nginx/sites-available/
    - source: /xchng/default
    - force: True
    - makedirs: True

nginx_phpvertestfile:
  file.copy:
    - name: /var/www/html/
    - source: /xchng/info.php
    - force: True
    - subdir: True

nginx_errorgeneratorfile:
  file.copy:
    - name: /var/www/html/
    - source: /xchng/error.php
    - force: True
    - subdir: True

nginx_restart:
  module.run:
    - name: service.restart
    - m_name: nginx