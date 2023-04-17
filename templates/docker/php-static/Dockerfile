# FROM alpine:3.14
FROM nginx:alpine
# RUN apk add --no-cache nginx
WORKDIR /app
COPY . .
# this file needs to exist
COPY ./nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
