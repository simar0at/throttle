FROM debian:bookworm-slim

COPY . /root/throttle
ARG EMAIL
ENV DEBIAN_FRONTEND=noninteractive \
    EMAIL=${EMAIL:-actions\ bot\ <actions_bot@github.com>}
RUN apt update && apt -y full-upgrade &&\
    apt install -y alien git git-buildpackage && \
    cd /root/throttle && gbp dch --new-version $(git tag | tail -1 | sed s~TS-~~) && debian/rules binary && \
    cd .. && alien --to-rpm throttle_*_amd64.deb