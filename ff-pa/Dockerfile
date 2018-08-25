FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y firefox pulseaudio && \
    rm -rf /var/lib/apt/lists/*
RUN echo "enable-shm = no" >> /etc/pulse/client.conf

RUN adduser firefox
ENV HOME /home/firefox

VOLUME /home/firefox
USER firefox

CMD /usr/bin/firefox -p
