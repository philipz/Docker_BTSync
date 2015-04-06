FROM progrium/busybox

RUN wget http://download-cdn.getsyncapp.com/stable/linux-x64/BitTorrent-Sync_x64.tar.gz \
    && gzip -d BitTorrent-Sync_x64.tar.gz \
    && tar xf BitTorrent-Sync_x64.tar -C /usr/bin/ btsync \
    && rm BitTorrent-Sync_x64.tar \
    && mkdir -p /config /data \
    && btsync --dump-sample-config > /config/btsync.conf \
    && adduser -D -h /config -s /sbin/nologin -u 5001 btsync \
    && chown -R btsync:btsync /config /data

COPY btsync.conf /config/btsync.conf

VOLUME /config /data

EXPOSE 8888 51414

CMD ["btsync", "--nodaemon", "--config", "/config/btsync.conf"]
