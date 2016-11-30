FROM babim/alpinebase

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN addgroup memcache && adduser -G memcache -D -H memcache

RUN apk add --no-cache memcached

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

USER memcache
EXPOSE 11211
CMD ["memcached"]
