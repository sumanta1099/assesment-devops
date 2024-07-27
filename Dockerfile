FROM debian:latest
RUN apt-get update && apt-get install -y \
    cowsay \
    fortune \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*
ENV PATH="/usr/games:/usr/local/games:$PATH"
WORKDIR /usr/src/app
COPY wisecow.sh .
RUN chmod +x wisecow.sh
CMD ["./wisecow.sh"]