FROM debian:buster
ENV DEBIAN_FRONTEND=noninteractive

# prereqs
RUN sed -i -e's/ main/ main contrib non-free/g' /etc/apt/sources.list && \
    apt-get -qq update && apt-get -qq upgrade && \
    apt-get -qq install -y \
        wget gnupg git \
        lame \
        python3 python3-pip && \
    wget -q -O - https://apt.mopidy.com/mopidy.gpg | apt-key add - && \
    wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/buster.list && \
    apt-get -qq update && \
    apt-get -qq install -y \
        libspotify12 libspotify-dev && \
    pip3 install --upgrade git+https://github.com/putty182/spotify-ripper && \
    apt-get remove --autoremove --purge -y gcc libspotify-dev git && \
    apt-get -qq clean

# the scripts
COPY root/start.sh /start.sh

# make some volumes
RUN mkdir /config /music
VOLUME ["/config", "/music"]
WORKDIR /music
EXPOSE 3000/tcp

ENTRYPOINT ["/start.sh"]