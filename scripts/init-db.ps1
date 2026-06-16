# ============================================================
# 一键初始化数据库（Windows / PowerShell）
# 把 db\init-all.sql 导入本地 MySQL，建 3 库 + 8 表 + 种子数据
#
# 运行：
#   powershell -ExecutionPolicy Bypass -File scripts\init-db.ps1
#   powershell -ExecutionPolicy Bypass -File scripts\init-db.ps1 -Container mysql -Password root
#   powershell -ExecutionPolicy Bypass -File scripts\init-db.ps1 -Mode cli   # 用本机 mysql 客户端
# ============================================================
param(
  [string]$Container = "mysql",
  [string]$Password  = "root",
  [string]$Mode      = "docker"   # docker | cli
)
$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $PSScriptRoot
$Sql  = Join-Path $Root "db\init-all.sql"
if (-not (Test-Path $Sql)) { Write-Host "[X] 找不到 $Sql" -ForegroundColor Red; exit 1 }

Write-Host "> 导入 $Sql ..."
$check = "SELECT table_schema AS db, COUNT(*) AS tables FROM information_schema.tables WHERE table_schema IN ('nepu_environment','nepu','nep') GROUP BY table_schema;"
if ($Mode -eq "cli") {
  Get-Content $Sql -Raw | mysql -uroot -p"$Password"
  mysql -uroot -p"$Password" -e $check
} else {
  Get-Content $Sql -Raw | docker exec -i $Container mysql -uroot -p"$Password"
  docker exec -i $Container mysql -uroot -p"$Password" -e $check
}
Write-Host "[OK] 初始化完成。" -ForegroundColor Green
