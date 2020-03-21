#!/bin/bash
set -e
envsubst < /home/postgres/patroni.yaml > /home/postgres/patroni.out.yaml
exec /usr/bin/patroni /home/postgres/patroni.out.yaml
