FROM debian:bullseye

RUN apt update &&\
	apt upgrade -y &&\
	apt install -y nginx\
	openssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/CN=127.0.0.1"

EXPOSE 443

COPY conf/rel-fila_conf /etc/nginx/sites-available/

RUN ln -s /etc/nginx/sites-available/rel-fila_conf /etc/nginx/sites-enabled/ && \
	unlink /etc/nginx/sites-enabled/default && \
	mkdir /var/www/rel-fila

RUN chmod 755 /var/www/rel-fila
RUN chown -R www-data:www-data /var/www/rel-fila

ENTRYPOINT ["nginx", "-g", "daemon off;"]
