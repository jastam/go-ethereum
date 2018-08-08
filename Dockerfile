# Build Geth in a stock Go builder container
FROM golang:1.10-alpine as builder

RUN apk add --no-cache make gcc musl-dev linux-headers

ADD . /go-ethereum
RUN cd /go-ethereum && make geth

# Pull Geth into a second stage deploy alpine container
FROM alpine:latest

RUN apk add --no-cache ca-certificates
COPY --from=builder /go-ethereum/build/bin/geth /usr/local/bin/

ADD ./genesis.json.template /genesis.json.template
ADD ./UTC--2018-06-13T08-21-07.573900500Z--88e94a4b7bfc62a38d300d98ce1c09f30fb75e3e /UTC--2018-06-13T08-21-07.573900500Z--88e94a4b7bfc62a38d300d98ce1c09f30fb75e3e
ADD ./accountpswd.txt /accountpswd.txt
ADD ./run.sh /run.sh

EXPOSE 8546
CMD ["/run.sh"]
