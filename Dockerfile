FROM debian:latest
RUN apt-get update && apt-get install -y \
    cowsay \
    fortune \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*
ENV PATH="/usr/games:/usr/local/games:$PATH"
RUN echo "PATH is: $PATH"
RUN ls -l /usr/games && ls -l /usr/local/games && ls -l /usr/local/bin && ls -l /usr/bin && ls -l /bin
RUN echo "Checking cowsay installation" && cowsay "Cowsay is installed"
RUN echo "Checking fortune installation" && fortune
RUN echo "Checking netcat installation" && nc -h
WORKDIR /usr/src/app
COPY wisecow.sh .
RUN chmod +x wisecow.sh
CMD ["./wisecow.sh"]
