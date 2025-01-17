FROM apache/tika:2.0.0-full

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get -y install curl \
    tesseract-ocr-eng

RUN apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --chown=root:root assets/entrypoint.sh assets/tika-config.template.xml /
RUN chmod +x /entrypoint.sh

HEALTHCHECK CMD curl -f http://0.0.0.0:9998/tika?hc=1 || exit 1
ENTRYPOINT /entrypoint.sh
