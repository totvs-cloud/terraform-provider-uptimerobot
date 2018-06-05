FROM golang

WORKDIR /go/src/github.com/louy/terraform-provider-uptimerobot

ADD . .

RUN go get -v
