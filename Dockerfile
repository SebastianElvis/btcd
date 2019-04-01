FROM alpine

LABEL maintainer="Elvis"
ENV GOPATH=/go \
    PROJ_DIR=github.com/btcsuite/btcd

ADD . $GOPATH/src/$PROJ_DIR

RUN apk add --no-cache git go musl-dev \
    && cd $GOPATH/src/$PROJ_DIR \
    && go get -v ./... \
    && go build \
    && go install . ./cmd/... \
    && apk del git go musl-dev \
    && rm -rf /apk /tmp/* /var/cache/apk/* $GOPATH/src/*

EXPOSE 8333 8334
CMD ["/go/bin/btcd", "--help"]

