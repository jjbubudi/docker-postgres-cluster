FROM postgres:12.2-alpine

RUN apk update && \
  apk add tini gettext python3 py3-psutil py3-psycopg2 && \
  pip3 install patroni[etcd,consul,kubernetes] && \
  PGHOME=/home/postgres && \
  mkdir -p $PGHOME && \
  chown postgres $PGHOME && \
  sed -i "s|/var/lib/postgresql.*|$PGHOME:/bin/bash|" /etc/passwd

ADD entrypoint.sh /

EXPOSE 5432 8008
VOLUME ["/var/lib/postgresql/data"]

USER postgres
WORKDIR /home/postgres
ADD patroni.yaml /home/postgres
ENTRYPOINT ["/sbin/tini", "/entrypoint.sh"]
