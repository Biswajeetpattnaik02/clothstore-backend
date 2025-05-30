#!/usr/bin/env bash
set -euo pipefail

echo "🛠  Building Java services…"

for svc in auth-service product-service api-gateway; do
  echo "→ Packaging $svc"
  (cd "$svc" && mvn clean package -DskipTests)
done

echo "🐳 Rebuilding Docker images…"
docker-compose down --remove-orphans
docker-compose build --no-cache

echo "🚀 Starting the stack…"
docker-compose up -d

echo "✅ All done! Services are up."
