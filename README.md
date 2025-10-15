# Ansible Static Server Deployment

Полная система развертывания сервера статики с использованием Ansible и Docker.

## Структура проекта

```
├── Dockerfile                          # Docker образ с Ubuntu 24.04
├── docker-compose.yml                  # Docker Compose конфигурация
├── site.yml                           # Основной Ansible плейбук
├── ansible.cfg                        # Конфигурация Ansible
├── inventory/hosts                    # Inventory файл
├── vars/main.yml                      # Переменные для плейбука
├── roles/                            # Ansible роли
│   ├── users/                        # Управление пользователями/группами
│   ├── zsh/                          # Установка zsh/oh-my-zsh
│   ├── ssh/                          # Настройка SSH
│   ├── packages/                     # Установка пакетов
│   ├── nginx/                        # Развертывание nginx
│   └── static/                       # Заливка статики
├── ansible_key                       # Приватный SSH ключ
└──  ansible_key.pub                   # Публичный SSH ключ
```

## Реализованные роли

### 1. Роль `users`
- Создание/удаление пользователей и групп
- Настройка SSH ключей
- Управление группами пользователей
- Настройка паролей и оболочек

### 2. Роль `zsh`
- Установка zsh для пользователей
- Автоматическая установка oh-my-zsh
- Настройка тем и плагинов

### 3. Роль `ssh`
- Запрет входа root пользователя
- Запрет пустых паролей
- Включение VERBOSE логирования
- Отключение X11Forwarding

### 4. Роль `packages`
- Обновление пакетов системы
- Установка дополнительных утилит (htop, ncdu, git, nano)
- Установка nginx

### 5. Роль `nginx`
- Установка и настройка nginx
- Создание vhost для статики
- Настройка gzip сжатия
- Настройка кэширования (1 час)
- Логирование запросов

### 6. Роль `static`
- Копирование статических файлов на сервер
- Настройка правильных прав доступа

# Быстрый старт

## Шаг 1: Запуск окружения
```bash
docker-compose up --build -d
```

## Шаг 2: Запуск Ansible
```bash
ansible-playbook site.yml
```

## Тестирование

### Проверка веб-сервера
- **Структура файлов**: http://localhost/images/
- **Отдельные файлы**: http://localhost/images/filename
- **Пример**: http://localhost/images/31638.svg

## Готово! 🎉

## Конфигурация

### Изменение пользователей (vars/main.yml)
```yaml
users_list:
  - name: newuser
    shell: /bin/bash
    state: present
    ssh_key: "ssh-rsa AAAAB3NzaC1yc2E..."
    groups: ["sudo", "developers"]
```

### Изменение пакетов
```yaml
packages_list:
  - htop
  - ncdu
  - git
  - nano
  - tree
  - vim
```

## Остановка окружения
```bash
docker-compose down
```

## Безопасность

- SSH доступ только для созданных пользователей
- Root логин отключен
- Пароли зашифрованы
- Аутентификация по SSH ключам
- Nginx с базовыми заголовками безопасности

