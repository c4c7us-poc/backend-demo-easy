FROM golang:1.17 AS builder

WORKDIR /build

COPY go.mod go.sum ./

RUN go mod download

COPY main.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o app main.go

FROM alpine:3.16

WORKDIR /app

COPY --from=builder /build/app .

EXPOSE 8080

CMD ["./app"]
