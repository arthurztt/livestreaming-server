FROM tiangolo/nginx-rtmp:latest

RUN apt-get update && apt-get install -y gettext-base

RUN mkdir -p /hls/live

COPY nginx.conf.template /etc/nginx/template/nginx.conf.template

ENTRYPOINT ["/bin/sh", "-c", "envsubst '${TWITCH_STEAMING_URL}${TWITCH_STEAMING_KEY}' < /etc/nginx/template/nginx.conf.template > /etc/nginx/nginx.conf && nginx -g 'daemon off;'"]