FROM ghcr.io/fullaxx/novnc:jammy

RUN apt-get update && \
    apt-get install -y \
      fluxbox \
      libgtk-3-0 \
      libx11-6 \
      libxext6 \
      libxrender1 \
      libxrandr2 \
      libxi6 \
      libxfixes3 \
      libxcursor1 \
      libxinerama1 \
      libglib2.0-0 \
      libegl1 \
      libvulkan1 \
      wget \
      curl \
      ca-certificates \
      && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/app
WORKDIR /opt/app

COPY start.sh /usr/local/bin/start-wrapper.sh
COPY config.txt /opt/app/config.txt

RUN chmod +x /usr/local/bin/start-wrapper.sh

EXPOSE 8080

CMD ["/usr/local/bin/start-wrapper.sh"]