FROM golang:1.17-alpine AS builder

WORKDIR /build

# Copiar archivos de dependencias
COPY go.mod go.sum ./

# Descargar dependencias
RUN go mod download

# Copiar código fuente
COPY main.go .

# Compilar la aplicación
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app main.go

# Imagen final
FROM alpine:latest

WORKDIR /root/

# Copiar binario compilado desde el stage builder
COPY --from=builder /build/app .

EXPOSE 8080

CMD ["./app"]
