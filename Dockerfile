# Виберіть базовий образ
FROM gcc:latest

# Скопіюйте вихідний код
WORKDIR /app
COPY . .

# Скомпілюйте HTTP сервер
RUN g++ -o http_server http_server.cpp -std=c++17 -lpthread

# Запустіть HTTP сервер
CMD ["./http_server"]

