FROM nginx:1.15.0-alpine

RUN rm -f /etc/nginx/conf.d/*

ADD nginx.conf /etc/nginx/conf.d/app.conf

EXPOSE 80

CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
