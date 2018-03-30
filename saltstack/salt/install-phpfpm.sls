phpfpm_install:
  pkg.installed:
    - name: php-fpm

phpfpm_chngsecurity:
  file.replace:
    - name: /etc/php/7.0/fpm/php.ini
    - pattern: ;cgi.fix_pathinfo=1
    - repl: cgi.fix_pathinfo=0

phpfpm_restart:
  module.run:
    - name: service.restart
    - m_name: php7.0-fpm