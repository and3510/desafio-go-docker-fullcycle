# Estágio de Compilação (Builder)
FROM golang:alpine AS builder

WORKDIR /app

# Copia o código para o container
COPY . .

# Compila o binário
# -ldflags "-s -w": Remove informações de debug para deixar o binário menor
# -o fullcycle: Nome do binário de saída
RUN go build -ldflags "-s -w" -o fullcycle main.go

# Estágio Final (A imagem que vai para o Docker Hub)
FROM scratch

# Copia apenas o binário do estágio anterior
COPY --from=builder /app/fullcycle /fullcycle

# Comando de execução
ENTRYPOINT ["/fullcycle"]
