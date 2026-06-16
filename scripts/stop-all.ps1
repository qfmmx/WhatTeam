# ============================================================
# 停止 start-all.ps1 启动的全部前后端（Windows / PowerShell）
# 运行： powershell -ExecutionPolicy Bypass -File scripts\stop-all.ps1
# ============================================================
$Root = Split-Path -Parent $PSScriptRoot
$Run  = Join-Path $Root ".run"

Write-Host "=== 按端口清理 ==="
$ports = 8080,8085,8082,5173,5174,8083,8084
foreach ($port in $ports) {
  try {
    $conns = Get-NetTCPConnection -LocalPort $port -State Listen -ErrorAction SilentlyContinue
    foreach ($c in $conns) {
      Stop-Process -Id $c.OwningProcess -Force -ErrorAction SilentlyContinue
      Write-Host ("  释放端口 {0} (pid {1})" -f $port,$c.OwningProcess)
    }
  } catch {}
}

Write-Host "=== 清理 PID 文件 ==="
if (Test-Path $Run) {
  Get-ChildItem "$Run\*.pid" -ErrorAction SilentlyContinue | ForEach-Object {
    $procId = Get-Content $_
    Stop-Process -Id $procId -Force -ErrorAction SilentlyContinue
    Remove-Item $_ -Force
  }
}
Write-Host "完成。" -ForegroundColor Green
