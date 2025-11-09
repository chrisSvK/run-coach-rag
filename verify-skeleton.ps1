# Week-1 Skeleton Verification Script

Write-Host "=== Week-1 Skeleton Verification ===" -ForegroundColor Cyan
Write-Host ""

$errorList = @()

# Check root files
Write-Host "Checking root files..." -ForegroundColor Yellow
$rootFiles = @(".gitignore", "LICENSE", "README.md", "IMPLEMENTATION_SUMMARY.md")
foreach ($file in $rootFiles) {
    if (Test-Path $file) {
        Write-Host "  OK $file" -ForegroundColor Green
    } else {
        Write-Host "  MISSING $file" -ForegroundColor Red
        $errorList += "Missing: $file"
    }
}
Write-Host ""

# Check API files
Write-Host "Checking API files..." -ForegroundColor Yellow
$apiFiles = @(
    "apps/api/app/main.py",
    "apps/api/app/__init__.py",
    "apps/api/pyproject.toml",
    "apps/api/Dockerfile"
)
foreach ($file in $apiFiles) {
    if (Test-Path $file) {
        Write-Host "  OK $file" -ForegroundColor Green
    } else {
        Write-Host "  MISSING $file" -ForegroundColor Red
        $errorList += "Missing: $file"
    }
}
Write-Host ""

# Check Workers files
Write-Host "Checking Workers files..." -ForegroundColor Yellow
$workerFiles = @(
    "apps/workers/worker/celery_app.py",
    "apps/workers/worker/__init__.py",
    "apps/workers/pyproject.toml",
    "apps/workers/Dockerfile"
)
foreach ($file in $workerFiles) {
    if (Test-Path $file) {
        Write-Host "  OK $file" -ForegroundColor Green
    } else {
        Write-Host "  MISSING $file" -ForegroundColor Red
        $errorList += "Missing: $file"
    }
}
Write-Host ""

# Check Web files
Write-Host "Checking Web files..." -ForegroundColor Yellow
$webFiles = @(
    "apps/web/package.json",
    "apps/web/next.config.ts",
    "apps/web/tsconfig.json",
    "apps/web/Dockerfile",
    "apps/web/.eslintrc.json",
    "apps/web/.prettierrc",
    "apps/web/app/page.tsx",
    "apps/web/app/layout.tsx"
)
foreach ($file in $webFiles) {
    if (Test-Path $file) {
        Write-Host "  OK $file" -ForegroundColor Green
    } else {
        Write-Host "  MISSING $file" -ForegroundColor Red
        $errorList += "Missing: $file"
    }
}
Write-Host ""

# Check Infrastructure files
Write-Host "Checking Infrastructure files..." -ForegroundColor Yellow
$infraFiles = @(
    "infra/docker/docker-compose.dev.yml"
)
foreach ($file in $infraFiles) {
    if (Test-Path $file) {
        Write-Host "  OK $file" -ForegroundColor Green
    } else {
        Write-Host "  MISSING $file" -ForegroundColor Red
        $errorList += "Missing: $file"
    }
}
Write-Host ""

# Check CI files
Write-Host "Checking CI files..." -ForegroundColor Yellow
$ciFiles = @(
    ".github/workflows/ci.yml"
)
foreach ($file in $ciFiles) {
    if (Test-Path $file) {
        Write-Host "  OK $file" -ForegroundColor Green
    } else {
        Write-Host "  MISSING $file" -ForegroundColor Red
        $errorList += "Missing: $file"
    }
}
Write-Host ""

# Summary
Write-Host "=== Summary ===" -ForegroundColor Cyan
if ($errorList.Count -eq 0) {
    Write-Host "SUCCESS: All files verified!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Yellow
    Write-Host "  1. docker compose -f infra/docker/docker-compose.dev.yml up --build"
    Write-Host "  2. curl http://localhost:8000/healthz"
    Write-Host "  3. Visit http://localhost:3000"
} else {
    Write-Host "ERRORS: Found issues" -ForegroundColor Red
    foreach ($item in $errorList) {
        Write-Host "  $item" -ForegroundColor Red
    }
}
Write-Host ""
