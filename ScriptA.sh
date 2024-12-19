#!/bin/bash

# Завершення та очищення контейнера, якщо він присутній
cleanup_container() {
    local name=$1
    if docker ps -a --format "{{.Names}}" | grep -q "^$name$"; then
        echo "Контейнер $name знайдено. Завершую роботу та видаляю."
        docker stop "$name" && docker rm "$name"
    fi
}

# Запуск нового контейнера на заданому ядрі CPU
launch_container() {
    local name=$1
    local core=$2
    echo "Запуск нового контейнера $name на CPU ядро $core."
    cleanup_container "$name"
    docker run -d --name "$name" --cpuset-cpus="$core" vitaliydenysko/http-server:latest /app/http_server
}

# Моніторинг активності контейнера
monitor_container() {
    local name=$1
    local idle_count=0
    while true; do
        local usage=$(docker stats --no-stream --format "{{.CPUPerc}}" "$name" | tr -d '%')
        usage=${usage%%.*} # Обрізаємо дробову частину

        if [ "$usage" -lt 1 ]; then
            ((idle_count++))
            echo "Контейнер $name неактивний. Лічильник бездіяльності: $idle_count хвилин."
        else
            idle_count=0
        fi

        if [ "$idle_count" -ge 2 ]; then
            echo "Контейнер $name неактивний понад 2 хвилини. Завершую роботу контейнера."
            docker stop "$name" && docker rm "$name"
            break
        fi

        sleep 60
    done
}

# Оновлення контейнера до останньої версії
update_image() {
    echo "Перевіряю наявність оновлень для зображення контейнера..."
    docker pull vitaliydenysko/http-server:latest
}

# Основний процес скрипта

# Запуск контейнерів із послідовним моніторингом
launch_container "srv1" 0
sleep 120
monitor_container "srv1"

launch_container "srv2" 1
sleep 120
monitor_container "srv2"

launch_container "srv3" 2
sleep 120
monitor_container "srv3"

# Оновлення зображення після виконання основних дій
update_image
