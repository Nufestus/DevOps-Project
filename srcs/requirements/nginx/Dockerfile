FROM debian:bookworm

RUN apt-get update -y \
    && apt-get install nginx openssl -y

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/CN=aammisse.42.fr"

COPY ./conf/nginx.conf /etc/nginx/conf.d

COPY ./tools/nginx.sh .

RUN chmod +x nginx.sh

CMD ["./nginx.sh"]