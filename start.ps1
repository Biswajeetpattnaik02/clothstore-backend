# start.ps1
Param()

# 1) Rebuild Docker images
Write-Host "🐳 Rebuilding Docker images…" -ForegroundColor Cyan
docker-compose down --remove-orphans
docker-compose build --no-cache

# 2) Start containers in detached mode
Write-Host "🚀 Starting the stack in detached mode…" -ForegroundColor Cyan
docker-compose up -d

# 3) Poll each service port until it’s listening
$checks = @{
  "mysql"           = 3306
  "auth-service"    = 8080
  "product-service" = 8081
  "api-gateway"     = 80
}

Write-Host "`n⏳ Waiting for services to become available…" -ForegroundColor Yellow
foreach ($name in $checks.Keys) {
  $port = $checks[$name]
  while (-not (Test-NetConnection -ComputerName 'localhost' -Port $port -InformationLevel Quiet)) {
    Start-Sleep -Seconds 1
  }
  Write-Host "  ✅ $name is up on port $port" -ForegroundColor Green
}

# 4) All done!
Write-Host "`n✅ All done! Services are up." -ForegroundColor Green

# 5) Attach to logs
Write-Host "`n📄 Streaming logs (Ctrl+C to exit) ..." -ForegroundColor Cyan
docker-compose logs -f
