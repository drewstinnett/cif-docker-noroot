#FROM python:3.6-alpine
FROM python:3.6.8-alpine3.8
LABEL developer="Wes Young <wes@csirtgadgets.org>"
LABEL docker_maintainer="Drew Stinnett <drew.stinnett@duke.edu>"


ENV DOCKER_BUILD=yes
ENV CIF_VERSION=3.0.7
ENV LANG=C.UTF-8
ENV CIF_ANSIBLE_ES=localhost:9200
ENV CIF_ENABLE_INSTALL=1
ENV ARCHIVE_URL=https://github.com/csirtgadgets/bearded-avenger/archive

# Disable this once ready to deploy
# ENV CFLAGS="-O0"

VOLUME /usr/share/GeoIP

RUN apk add --update \
    shadow g++ make python3-dev shadow libxml2-dev libxslt-dev \
    bash libffi-dev openssl-dev wget geoip curl && \
    mkdir -p /var/log/cif && \
    mkdir -p /var/log/gunicorn && \
    mkdir -p /var/lib/cif && \
    mkdir -p /etc/cif && \
    mkdir -p /home/cif && \
    touch /home/cif/.cif.yml && \
    mkdir -p /var/run/cif && \
    useradd -m -s /bin/bash cif && \
    touch /home/cif/.profile && \
    chown -R cif /home/cif && \
    chown -R cif /etc/cif && \
    chown -R cif /var/log/gunicorn && \
    chown -R cif /var/log/cif && \
    chown -R cif /var/lib/cif && \
    chown -R cif /var/run/cif && \
    cd /tmp && \
    wget --quiet ${ARCHIVE_URL}/${CIF_VERSION}.tar.gz -O ba.tar.gz && \
    tar -zxf ba.tar.gz  && \
    cd /tmp/bearded-avenger-${CIF_VERSION} && \
    pip3 install --upgrade --no-cache-dir pip && \
    pip3 install --no-cache-dir -r ./dev_requirements.txt && \
    python3 setup.py install && \
    mkdir -p /inactive_hunters && \
    cd /inactive_hunters && \
    wget https://raw.githubusercontent.com/JesseBowling/cifv3_scripts/master/logging_hunter.py && \
    chmod 755 logging_hunter.py && \
    mv /usr/local/lib/python3.6/site-packages/cif-${CIF_VERSION}-py3.6.egg/cif/hunter/*.py /inactive_hunters/ && \
    mv __init__.py /usr/local/lib/python3.6/site-packages/cif-${CIF_VERSION}-py3.6.egg/cif/hunter/ && \
    chown -R cif /usr/local/lib/python3.6/site-packages/cif-${CIF_VERSION}-py3.6.egg/cif/hunter/ && \
    chown -R cif /inactive_hunters && \
    rm -rf /var/cache/apk/*  \
    rm -f /tmp/ba.tar.gz

COPY cif-helpers /cif-helpers
USER cif
ENTRYPOINT ["/cif-helpers/entrypoint-http"]
