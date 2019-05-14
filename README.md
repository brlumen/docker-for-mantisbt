`MantisBT` is an open source issue tracker that provides
a delicate balance between simplicity and power.

## Example docker-compose.yml
The examples suppose you will have the data for your containers in `/srv/mantis`. Adapt for your server.

```
mantisbt:
  image: brlumen/docker-for-mantisbt:php5.5-xdebug
  environment:
        PHP_XDEBUG_ENABLED: 1
        XDEBUG_CONFIG: "remote_host=192.168.0.202
                        remote_port=9001
                        remote_autostart=on
                        remote_enable=on
                        remote_handler=dbgp
                        remote_mode=req
                        idekey=PHPSTORM
                        output_buffering=off
                        remote_log=/var/log/xdebug/xdebug.log
                        default_enable = 1"
        ports:
          - "8989:80"
        links:
          - mysql
          - phpmyadmin
        restart: always
        volumes:
          - /srv/mantis/config:/var/www/html/config
          - /srv/mantis/custom:/var/www/html/custom
          - /srv/mantis/plugins/TelegramBot:/var/www/html/plugins/TelegramBot
          - /srv/mantis/html:/var/www/html/
          - /srv/mantis/log:/var/log/xdebug

mysql:
  image: mariadb:latest
  environment:
    - MYSQL_ROOT_PASSWORD=root
    - MYSQL_DATABASE=bugtracker
    - MYSQL_USER=mantisbt
    - MYSQL_PASSWORD=mantisbt
  volumes:
	- /srv/mantis/mysql:/var/lib/mysql
  restart: always
```

> You can use `mysql`/`postgres` instead of `mariadb`.

```
postgres:
  image: postgres:latest
  environment:
    - POSTGRES_USER=root
    - POSTGRES_PASSWORD=root
    - POSTGRES_DB=bugtracker
  restart: always
  volumes:
    - /srv/mantis/pgsql:/var/lib/postgresql/data
```

## Install

```
$ firefox http://localhost:8989/admin/install.php
>>> username: administrator
>>> password: root
```

```
==================================================================================
Installation Options
==================================================================================
Type of Database                                        MySQL/MySQLi
Hostname (for Database Server)                          mysql
Username (for Database)                                 mantisbt
Password (for Database)                                 mantisbt
Database name (for Database)                            bugtracker
Admin Username (to create Database if required)         root
Admin Password (to create Database if required)         root
Print SQL Queries instead of Writing to the Database    [ ]
Attempt Installation                                    [Install/Upgrade Database]
==================================================================================
```

```
==================================================================================
Installation Options
==================================================================================
Type of Database                                        POSTGRES
Hostname (for Database Server)                          postgres
Username (for Database)                                 mantisbt
Password (for Database)                                 mantisbt
Database name (for Database)                            bugtracker
Admin Username (to create Database if required)         root
Admin Password (to create Database if required)         root
Print SQL Queries instead of Writing to the Database    [ ]
Attempt Installation                                    [Install/Upgrade Database]
==================================================================================
```

## Email

Append following to `/srv/mantis/config/config_inc.php`

```
$g_phpMailer_method = PHPMAILER_METHOD_SMTP;
$g_administrator_email = 'admin@example.org';
$g_webmaster_email = 'webmaster@example.org';
$g_return_path_email = 'mantisbt@example.org';
$g_from_email = 'mantisbt@example.org';
$g_smtp_host = 'smtp.example.org';
$g_smtp_port = 25;
$g_smtp_connection_mode = 'tls';
$g_smtp_username = 'mantisbt';
$g_smtp_password = '********';
```
