# ============================================================
# 一键启动 NEPM 全部前后端（Windows / PowerShell）
# 端口：AQI-SYS 8080 | networker-backend 8085 | supervisor-backend 8082
#       nepm-admin 5173 | nepv-dashboard 5174 | networker 8083 | supervisor 8084
#
# 运行： powershell -ExecutionPolicy Bypass -File scripts\start-all.ps1
# 前置： 已装 JDK17、Maven、Node；已执行 init-db.ps1
# ============================================================
$Root = Split-Path -Parent $PSScriptRoot
$Run  = Join-Path $Root ".run"
$Logs = Join-Path $Run  "logs"
New-Item -ItemType Directory -Force -Path $Logs | Out-Null

function Test-Port([int]$Port) {
  try { $c = New-Object Net.Sockets.TcpClient; $c.Connect("localhost",$Port); $c.Close(); return $true }
  catch { return $false }
}

function Wait-Port([int]$Port,[string]$Name,[int]$Timeout=180) {
  Write-Host -NoNewline ("  等待 {0} :{1} " -f $Name,$Port)
  for ($i=0; $i -lt $Timeout; $i+=3) {
    if (Test-Port $Port) { Write-Host " [OK]" -ForegroundColor Green; return $true }
    Start-Sleep 3; Write-Host -NoNewline "."
  }
  Write-Host (" [超时] 见 {0}\{1}.log" -f $Logs,$Name) -ForegroundColor Yellow; return $false
}

function Start-Back([string]$Name,[string]$Dir,[int]$Port) {
  Write-Host (">> 启动后端 {0} (端口 {1})" -f $Name,$Port)
  $mvn = if (Test-Path "$Dir\mvnw.cmd") { "$Dir\mvnw.cmd" } else { "mvn" }
  $log = "$Logs\$Name.log"
  $p = Start-Process -FilePath "cmd.exe" -ArgumentList "/c","`"$mvn`" -f `"$Dir\pom.xml`" spring-boot:run > `"$log`" 2>&1" `
                     -WindowStyle Hidden -PassThru
  $p.Id | Out-File -Encoding ascii "$Run\$Name.pid"
}

function Start-Front([string]$Name,[string]$Dir,[int]$Port) {
  Write-Host (">> 启动前端 {0} (端口 {1})" -f $Name,$Port)
  $log = "$Logs\$Name.log"
  $p = Start-Process -FilePath "cmd.exe" -ArgumentList "/c","cd /d `"$Dir`" && npm run dev > `"$log`" 2>&1" `
                     -WindowStyle Hidden -PassThru
  $p.Id | Out-File -Encoding ascii "$Run\$Name.pid"
}

Write-Host "=== 后端（Spring Boot，首次会下载依赖，请耐心）==="
Start-Back "AQI-SYS"            "$Root\nepm\AQI-SYS"               8080
Start-Back "networker-backend"  "$Root\network\networker-backend"  8085
Start-Back "supervisor-backend" "$Root\supervisor\backend"         8082
Wait-Port 8080 "AQI-SYS" 180            | Out-Null
Wait-Port 8085 "networker-backend" 180  | Out-Null
Wait-Port 8082 "supervisor-backend" 180 | Out-Null

Write-Host "=== 前端（Vite）==="
Start-Front "nepm-admin"     "$Root\nepm\nepm-admin"               5173
Start-Front "nepv-dashboard" "$Root\nepv-dashboard"                5174
Start-Front "networker"      "$Root\network\networker"             8083
Start-Front "supervisor"     "$Root\supervisor\front\supervisor"   8084
Wait-Port 5173 "nepm-admin" 60     | Out-Null
Wait-Port 5174 "nepv-dashboard" 60 | Out-Null
Wait-Port 8083 "networker" 60      | Out-Null
Wait-Port 8084 "supervisor" 60     | Out-Null

Write-Host ""
Write-Host "================ 全部启动完成 ================" -ForegroundColor Green
Write-Host "管理端     http://localhost:5173"
Write-Host "数据大屏   http://localhost:5174"
Write-Host "网格员端   http://localhost:8083"
Write-Host "监督员端   http://localhost:8084"
Write-Host "日志目录   $Logs"
Write-Host "停止全部   powershell -ExecutionPolicy Bypass -File scripts\stop-all.ps1"
