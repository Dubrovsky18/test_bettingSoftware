nginx (роль)

Что делает
- Ставит nginx и настраивает простой сайт. 

used to:
- Подключи роль в `site.yml` и закинуть свой файл `index.html` в `roles/nginx/files`.
- Конфиг nginx рендерится из `templates/nginx_site.conf.j2`.

Полезные переменные
- `nginx_listen_port` — порт, по умолчанию 80.
- `nginx_server_name` — домен/хост. Можно `localhost`.
- `nginx_root` — корень сайта. Обычно `static_path`.

Где лежит что
- `tasks/` — установка и конфиг.
- `templates/` — jinja2-шаблоны конфигов.
- `files/` — статика, например `index.html` и svg.
- `handlers/` — перезапуск nginx, когда что-то меняется.

Быстрый старт
1) Пробросить нужные переменные в `vars/main.yml`.
2) Запустить плейбук: `ansible-playbook -i inventory/hosts site.yml`.
3) Открыть `http://<host>:<port>` и проверить, что всё живо.


