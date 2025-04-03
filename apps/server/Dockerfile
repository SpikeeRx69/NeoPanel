FROM rust:latest as builder
WORKDIR /app

# Install SQLx CLI
RUN cargo install sqlx-cli --no-default-features --features native-tls,postgres

# Copy and build
COPY . .
RUN cargo build --release

FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y libssl3 openssl && rm -rf /var/lib/apt/lists/*

# Copy binaries and migrations
COPY --from=builder /app/target/release/neopanel-api /app/
COPY --from=builder /usr/local/cargo/bin/sqlx /usr/local/bin/sqlx
COPY --from=builder /app/migrations /app/migrations

WORKDIR /app
CMD ["sh", "-c", "sqlx migrate run && ./neopanel-api"]
