FROM i386/ubuntu:16.04

RUN apt-get update && \
    apt-get install -y firefox=45.0.2+build1-0ubuntu1 libxmu6 pulseaudio software-properties-common dbus-x11 && \
    add-apt-repository ppa:webupd8team/java && \
    apt-get update && \
    echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer && \
    rm -rf /var/lib/apt/lists/*

RUN echo "enable-shm = no" >> /etc/pulse/client.conf

RUN adduser firefox
ENV HOME /home/firefox

VOLUME /home/firefox
USER firefox

CMD /usr/bin/firefox -p
