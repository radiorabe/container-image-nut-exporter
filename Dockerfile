FROM docker.io/hon95/prometheus-nut-exporter:1.2.1 as upstream
FROM ghcr.io/radiorabe/ubi9-minimal:0.7.3

COPY --from=upstream /app/prometheus-nut-exporter /usr/local/bin/prometheus-nut-exporter

ENV TZ=Europe/Zurich \
    HTTP_PATH=/metrics \
    HTTP_PORT='9614'

RUN    microdnf install -y \
         shadow-utils \
    && microdnf clean all \
    && useradd -u 1001 -r -g 0 -s /sbin/nologin \
         -c "Default Application User" default \
    && microdnf remove -y \
         libsemanage \
         shadow-utils
         
USER 1001
EXPOSE 9614
ENTRYPOINT /usr/local/bin/prometheus-nut-exporter
