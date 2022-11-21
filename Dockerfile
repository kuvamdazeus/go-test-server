# syntax=docker/dockerfile:1

## Build
FROM golang:1.16-buster AS build

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY *.go ./

RUN go build -o /helloworld

## Deploy
FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /helloworld /helloworld

EXPOSE 8000

USER nonroot:nonroot

ENTRYPOINT ["/helloworld"]