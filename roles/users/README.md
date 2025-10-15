users
Что делает:
- Создаёт пользователей, группы и настраивает им шелл/пароли/ключи. Типа “принеси создай”.

used to:
- Подключить роль в `site.yml`.
- Определить список users в переменной `users_list`.

Структура `users_list`

```yaml
users_list:
  - name: alice
    state: present           # или absent
    shell: /bin/bash         # по умолчанию bash
    ssh_key: ansible_key.pub # ssh key 
    groups: ["sudo"]        # дополнительные группы
    password: "<хеш>"       # опционально, можно omit
```

Где лежит что
- `tasks/` — создание пользователей и групп, управление домашками.
- `defaults/`/`vars/` — дефолтные и оверрайд-переменные.

Быстрый старт
1) Заполнить `users_list` (см. `vars/main.yml`).
2) Прогнать плейбук(роль) и проверять логин.

