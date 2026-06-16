# ============================================================
# 一键初始化数据库（Windows / PowerShell）—— 直连本地 MySQL
# 前提：本机 MySQL 已启动，且 mysql 客户端在 PATH（或用 -MysqlExe 指定）
# 把 db\init-all.sql 导入：建 3 库(nepu_environment/nepu/nep) + 8 表 + 种子数据
#
# 运行：
#   powershell -ExecutionPolicy Bypass -File scripts\init-db.ps1
#   powershell -ExecutionPolicy Bypass -File scripts\init-db.ps1 -User root -Password 你的密码
#   powershell -ExecutionPolicy Bypass -File scripts\init-db.ps1 -MysqlExe "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe"
# ============================================================
param(
  [string]$User     = "root",
  [string]$Password = "root",
  [string]$MysqlExe = "mysql"        # mysql 客户端，默认在 PATH
)
$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $PSScriptRoot
$Sql  = Join-Path $Root "db\init-all.sql"
if (-not (Test-Path $Sql)) { Write-Host "[X] 找不到 $Sql" -ForegroundColor Red; exit 1 }

# 密码留空则不带 -p
$pwArg = if ([string]::IsNullOrEmpty($Password)) { "" } else { "-p$Password" }

Write-Host "> 直连本地 MySQL 导入 $Sql ..."
# 用 cmd 的 < 重定向让 mysql 直接读取文件字节，避免 PowerShell 管道改写 UTF-8 编码
& cmd /c "`"$MysqlExe`" -u$User $pwArg --default-character-set=utf8mb4 < `"$Sql`""
if ($LASTEXITCODE -ne 0) { Write-Host "[X] 导入失败（请检查：MySQL 是否已启动 / 账号密码 / mysql 是否在 PATH）" -ForegroundColor Red; exit 1 }

Write-Host "[OK] 初始化完成。校验各库表数量：" -ForegroundColor Green
$check = "SELECT table_schema AS db, COUNT(*) AS tables FROM information_schema.tables WHERE table_schema IN ('nepu_environment','nepu','nep') GROUP BY table_schema;"
& cmd /c "`"$MysqlExe`" -u$User $pwArg -e `"$check`""
