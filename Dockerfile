FROM debian:bullseye-slim
MAINTAINER Johnny Chadda <johnny@chadda.se>

ENV DEBIAN_FRONTEND="noninteractive" HOME="/root" LC_ALL="C.UTF-8" LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      cron python3 python3-pip libmagic1 && \
    rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install -U pip s3cmd python-magic && \
  rm -rf /tmp/pip_build_root/

RUN mkdir -p /data

ADD s3cmd.cfg /root/.s3cfg
ADD run.sh /

ENTRYPOINT ["/run.sh"]
CMD ["start"]
