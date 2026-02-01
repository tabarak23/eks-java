FROM nginx:1.25-alpine

LABEL project="vprofile"
LABEL maintainer="tabarak23"

#removing default config
RUN rm -f /etc/nginx/conf.d/default.conf

#adding custom reverse-proxy config
COPY Docker-files/web/nginvproapp.conf \
     /etc/nginx/conf.d/vproapp.conf
