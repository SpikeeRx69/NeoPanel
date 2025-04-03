#!/bin/bash
set -e

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Install dependencies
apt update
apt install -y git docker.io docker-compose-plugin

# Clone your repository
git clone https://github.com/SpikeeRx69/NeoPanel.git /opt/neopanel
cd /opt/neopanel

# Generate secrets if they don't exist
if [ ! -f .env ]; then
  cat > .env <<EOF
POSTGRES_USER=neopanel
POSTGRES_PASSWORD=$(openssl rand -hex 16)
POSTGRES_DB=neopanel
DATABASE_URL=postgres://neopanel:\${POSTGRES_PASSWORD}@db:5432/neopanel
JWT_SECRET=$(openssl rand -hex 32)
EOF
fi

# Start services
docker compose up -d --build

echo ""
echo "✅ Installation complete!"
echo "🌐 Access the panel at: http://$(curl -s ifconfig.me):3000"
