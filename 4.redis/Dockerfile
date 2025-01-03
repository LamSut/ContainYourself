# base Redis image
FROM redis:7.0

# copy Redis config to container
COPY redis.conf /usr/local/etc/redis/redis.conf

# workdir
WORKDIR /data

# rxpose Redis default port
EXPOSE 6379

# run with config
CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]
