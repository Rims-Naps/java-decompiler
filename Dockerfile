FROM docker.io/library/debian AS runtimebase

RUN set -xe \
    && apt-get update \
    && apt-get install -y openjdk-21-jre procyon-decompiler unzip astyle \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

FROM runtimebase AS dependencies

ARG CFR_URL=https://github.com/leibnitz27/cfr/releases/download/0.152/cfr-0.152.jar
ARG VINEFLOWER_URL=https://github.com/Vineflower/vineflower/releases/download/1.11.2/vineflower-1.11.2.jar

RUN set -xe \
    && apt-get update \
    && apt-get install -y curl \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /dependencies

RUN set -xe \
    && mkdir -p ./out \
    && curl -q -s -S -L --create-dirs -o ./out/cfr.jar $CFR_URL \
    && curl -q -s -S -L --create-dirs -o ./out/vineflower.jar $VINEFLOWER_URL

FROM runtimebase AS runtime

COPY --from=dependencies /dependencies/out /opt

# Set default directories inside the container
ENV INFILES="/infiles" \
    LIBFILES="/libfiles" \
    OUTFILES="/outfiles" \
    JAVA_XMX="2G"

COPY ./src/init /init

RUN chmod 540 /init

# The ENTRYPOINT is still the init script, so decompilation will run automatically
ENTRYPOINT ["/init"]
