FROM debian:buster
ENV DEBIAN_FRONTEND=noninteractive

# prereqs
RUN apt-get -qq update && apt-get -qq upgrade && \
    apt-get -qq install -y \
        wget gnupg git \
        lame faac fdkaac ffmpeg flac opus-tools sox vorbis-tools \
        python3 python3-pip

RUN wget -q -O - https://apt.mopidy.com/mopidy.gpg | apt-key add - && \
    wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/buster.list && \
    apt-get -qq update && \
    apt-get -qq install -y \
        libspotify12 libspotify-dev && \
    apt-get -qq clean

# the scripts
COPY root/start.sh /start.sh

# make some volumes
RUN mkdir /config /music
VOLUME ["/config", "/music"]
WORKDIR /music
EXPOSE 3000/tcp

ENTRYPOINT ["/start.sh"]