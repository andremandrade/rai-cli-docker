FROM golang:1.20-alpine3.17 as builder

RUN apk add git

RUN git clone https://github.com/RelationalAI/rai-cli.git 

WORKDIR /go/rai-cli

RUN sh tidy

RUN go build -o build/rai rai/*

FROM alpine:3.17 as app

RUN adduser -D rai
USER rai

WORKDIR /home/rai/rai-cli

COPY --from=builder /go/rai-cli/build/rai .

ENV PATH="$PATH:/home/rai/rai-cli"

ENTRYPOINT [ "rai" ]
CMD ["--help"]