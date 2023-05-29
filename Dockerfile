FROM golang:1.20-alpine3.17 as builder

RUN apk add git

RUN git clone --depth 1 --branch v0.1.6-alpha https://github.com/RelationalAI/rai-cli.git 

WORKDIR /go/rai-cli

RUN sh tidy

RUN go build -o build/rai rai/*

FROM alpine:3.17 as app

RUN adduser -D rai
USER rai

WORKDIR /home/rai/rai-cli

COPY --from=builder /go/rai-cli/build/rai .

ENV PATH="$PATH:/home/rai/rai-cli"

RUN echo 'rai $@ 2>&1 || { echo "ERROR: Failed on rai $@"; exit 1; }' > run-rai

ENTRYPOINT ["sh", "run-rai" ]
CMD ["--help"]
