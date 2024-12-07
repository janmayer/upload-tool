FROM golang:alpine AS builder

RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest
RUN xcaddy build --with github.com/greenpau/caddy-security

RUN go install github.com/tus/tusd/cmd/tusd@latest


FROM alpine
COPY --from=builder /go/caddy /usr/bin/caddy
COPY --from=builder /go/bin/tusd /usr/bin/tusd
