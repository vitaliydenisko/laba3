#!/bin/bash

# Масив URL серверів, які відповідають контейнерам
SERVER_URLS=(
    "http://localhost:8080"  # srv1
    "http://localhost:8081"  # srv2
    "http://localhost:8082"  # srv3
)

# Функція для виконання HTTP запиту до певного сервера
make_request() {
    local server_url=$1

    while true; do
        # Генерація випадкової затримки від 5 до 10 секунд
        local delay=$((RANDOM % 6 + 5))

        # Зробити HTTP запит
        echo "Запит до $server_url через $delay секунд..."
        curl -s $server_url > /dev/null

        # Затримка перед наступним запитом
        sleep $delay
    done
}

# Запускаємо асинхронні запити для кожного контейнера
for i in "${!SERVER_URLS[@]}"; do
    server_url="${SERVER_URLS[$i]}"
    echo "Запускаємо запити для сервера: $server_url"
    make_request "$server_url" &  # Запускаємо функцію make_request асинхронно
done

# Чекаємо завершення всіх фонових процесів
wait

