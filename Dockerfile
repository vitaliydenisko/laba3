# Етап 1: Збірка 
FROM ubuntu:20.04 as builder

# Встановлення залежностей
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    make \
    curl \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Завантаження файлів з GitHub
WORKDIR /app
RUN wget https://raw.githubusercontent.com/vitaliydenisko/laba3/branchHTTPserver/http_server.cpp \
    && wget https://raw.githubusercontent.com/vitaliydenisko/laba3/branchHTTPserver/funca.cpp \
    && wget https://raw.githubusercontent.com/vitaliydenisko/laba3/branchHTTPserver/funca.h \ 
    && wget https://raw.githubusercontent.com/vitaliydenisko/laba3/branchHTTPserver/httplib.h

# Компіляція програми
RUN g++ -o http_server http_server.cpp -std=c++17 -lpthread 

# Етап 2: Створення кінцевого образу
FROM alpine:latest

# Копіювання виконуваного файлу із попереднього етапу
WORKDIR /usr/local/bin
COPY --from=builder /app/http_server /app/

# Відкриття порту
EXPOSE 8080

# Запуск програми
CMD ["./http_server"]

