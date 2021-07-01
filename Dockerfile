FROM alpine:3.11.7

ENV GOPATH /go

COPY . /go/src/github.com/hound-search/hound

RUN apk update \
	&& apk add go git subversion libc-dev mercurial bzr openssh tini \
	&& cd /go/src/github.com/hound-search/hound \
	&& go mod download \
	&& go install github.com/hound-search/hound/cmds/houndd \
	&& apk del go \
	&& rm -f /var/cache/apk/* \
	&& rm -rf /go/src /go/pkg

VOLUME ["/data"]

# ssh config
RUN mkdir -p /root/.ssh/
RUN touch /root/.ssh/known_hosts
ARG SSH_KEY
RUN echo "$SSH_KEY" > /root/.ssh/id_ed25519
RUN chmod 600 /root/.ssh/id_ed25519
# COPY ./id_ed25519 /root/.ssh/
RUN ssh-keyscan github.com >> ~/.ssh/known_hosts

EXPOSE 6080

ENTRYPOINT ["/sbin/tini", "--", "/go/bin/houndd", "-conf", "/data/config.json"]
