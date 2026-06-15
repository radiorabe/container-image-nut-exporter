FROM docker.io/hon95/prometheus-nut-exporter:1.2.1@sha256:a9bfbbae3b12a6486e6e4b933a69a79d01342db27346d6b4cd5512f4eef6b111 AS upstream
FROM ghcr.io/radiorabe/ubi9-minimal:0.12.0@sha256:ddf3ac33c48b5005cc325732cb547279a926f29b3db9adcbd844f1cf94dcf831

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
