# Укажите базовый образ
FROM node:14

# Установите рабочую директорию
WORKDIR /app

# Скопируйте package.json и package-lock.json
COPY package*.json ./

# Установите зависимости
RUN npm install

# Скопируйте все остальные файлы
COPY . .

# Сборка приложения
RUN npm run build

# Установите nginx
FROM nginx:alpine

# Копируем сборку React приложения в корневую директорию nginx
COPY --from=0 /app/dist /usr/share/nginx/html

# Копируем конфигурацию nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Запустите nginx
CMD ["nginx", "-g", "daemon off;"]
