FROM alpine:latest

COPY ./ /www/
COPY nginx.conf /etc/nginx/nginx.conf

RUN apk update \
    && apk add nginx \
    && adduser -D -g 'www' www \
    && chown -R www:www /var/lib/nginx \
    && chown -R www:www /www

CMD ["nginx", "-g", "daemon off;"]
