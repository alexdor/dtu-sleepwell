FROM golang:1.12-alpine

RUN apk add --no-cache --update git openssh

ENV GO111MODULE=on

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -ldflags="-s -w -extldflags -static" -i -o server

CMD [ "/app/server" ]
