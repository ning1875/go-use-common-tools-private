FROM golang:latest as builder
WORKDIR /app
COPY go.mod ./
COPY go.sum ./

RUN cp -R /internal/workspaces/source/.ssh /root/.ssh/
RUN chmod 700 /root/.ssh/ ;chmod -R 400 /root/.ssh/*
COPY .gitconfig /root/.gitconfig


RUN go mod download
COPY . .

RUN CGO_ENABLED=0  GOOS=linux GOARCH=amd64 go build -o main main.go
RUN pwd ; ls -l /app/main

#FROM yauritux/busybox-curl  as runner
FROM alpine as runner
COPY --from=builder /app/main .
ENTRYPOINT [ "./main" ]
