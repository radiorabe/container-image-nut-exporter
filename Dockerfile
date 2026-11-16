FROM docker.io/hon95/prometheus-nut-exporter:1.2.1@sha256:a9bfbbae3b12a6486e6e4b933a69a79d01342db27346d6b4cd5512f4eef6b111 AS upstream
FROM ghcr.io/radiorabe/ubi9-minimal:0.12.1@sha256:9a3f83629f9dd656727266b28ceb962824a337c34dab911ff4f0fce75acea642

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
