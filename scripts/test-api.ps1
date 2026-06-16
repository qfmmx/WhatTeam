# ============================================================
# 全量接口冒烟测试（Windows / PowerShell）—— 覆盖三个后端所有路由
# 判定：HTTP 200 → PASS；4xx → WARN；000/5xx → FAIL
# 运行： powershell -ExecutionPolicy Bypass -File scripts\test-api.ps1
# ============================================================
$script:pass=0; $script:warn=0; $script:fail=0
$A="http://localhost:8080/api"   # AQI-SYS
$N="http://localhost:8085/api"   # networker-backend
$S="http://localhost:8082/api"   # supervisor-backend

function Hit([string]$desc,[string]$method,[string]$url,[string]$body=$null) {
  $code=0; $snippet=""
  try {
    $p=@{ Uri=$url; Method=$method; TimeoutSec=8; UseBasicParsing=$true }
    if ($body) { $p.Body=$body; $p.ContentType="application/json" }
    $r=Invoke-WebRequest @p
    $code=[int]$r.StatusCode; $snippet=$r.Content
  } catch {
    if ($_.Exception.Response) { try { $code=[int]$_.Exception.Response.StatusCode } catch {} }
    if ($_.ErrorDetails) { $snippet=$_.ErrorDetails.Message }
  }
  if     ($code -eq 200)      { $tag="[PASS]"; $col="Green";  $script:pass++ }
  elseif ($code -ge 400 -and $code -lt 500) { $tag="[WARN]"; $col="Yellow"; $script:warn++ }
  else   { $tag="[FAIL]"; $col="Red"; $script:fail++ }
  if ($snippet.Length -gt 110) { $snippet=$snippet.Substring(0,110) }
  Write-Host ("{0} [{1}] {2} {3}" -f $tag,$code,$method.PadRight(4),$desc) -ForegroundColor $col
  Write-Host ("        {0} -> {1}" -f $url, ($snippet -replace "\s+"," "))
}

Write-Host "############## AQI-SYS  :8080 (管理端) ##############"
Hit "管理员登录"       POST "$A/admins/login"      '{"adminCode":"AD001","password":"123456"}'
Hit "管理员登录(别名)" POST "$A/auth/admin/login"  '{"adminCode":"AD001","password":"123456"}'
Hit "省份列表"         GET  "$A/gridProvince/listAll"
Hit "城市列表"         GET  "$A/gridCity/listByProvince?provinceId=3"
Hit "网格员列表"       GET  "$A/gridMember/listByCity?provinceId=3&cityId=3"
Hit "统计-分页"        POST "$A/statistics/page"   '{"pageNum":1,"pageSize":5}'
Hit "统计-按ID"        GET  "$A/statistics/1"
Hit "统计-省汇总"      GET  "$A/statistics/provinceTotal"
Hit "统计-AQI分布"     GET  "$A/statistics/aqiDistribute"
Hit "统计-趋势"        GET  "$A/statistics/trend"
Hit "统计-总数"        GET  "$A/statistics/totalCount"
Hit "统计-优良数"      GET  "$A/statistics/goodCount"
Hit "统计-省覆盖率"    GET  "$A/statistics/provinceCoverage"
Hit "统计-市覆盖率"    GET  "$A/statistics/cityCoverage"
Hit "统计-大屏"        GET  "$A/statistics/dashboard"
Hit "反馈-分页"        GET  "$A/feedback?pageNum=1&pageSize=5"
Hit "反馈-详情"        GET  "$A/feedback/38"
Hit "反馈-本市网格员"  GET  "$A/feedback/38/localMembers"
Hit "反馈-跨省网格员"  GET  "$A/feedback/38/crossMembers"
Hit "反馈-指派"        PUT  "$A/feedback/assign"   '{"afId":38,"gmId":1}'
Hit "反馈-改状态"      PUT  "$A/feedback/state"    '{"id":38,"state":1}'

Write-Host "`n############## networker-backend  :8085 (网格员端) ##############"
Hit "网格员登录"       POST "$N/gridMember/login"  '{"loginCode":"gm1001","password":"123456"}'
Hit "反馈-初始化"      GET  "$N/feedback/init"
Hit "反馈-列表"        POST "$N/feedback/list?gmId=1" '{"pageNum":1,"pageSize":5}'
Hit "反馈-指派"        POST "$N/feedback/assign"   '{"afId":1,"gmId":1}'
Hit "反馈-提交处理"    POST "$N/feedback/submit"   '{"afId":1,"aqiValue":80}'

Write-Host "`n############## supervisor-backend  :8082 (监督员端) ##############"
Hit "省份列表"        GET  "$S/region/provinces"
Hit "城市列表"        GET  "$S/region/cities?provinceId=3"
Hit "手机号校验"      GET  "$S/supervisor/checkPhone?phone=13800000000"
Hit "监督员注册"      POST "$S/supervisor/register" ('{"phone":"139' + (Get-Date).ToString('HHmmss') + '","password":"123456","name":"测试员"}')
Hit "监督员登录"      POST "$S/supervisor/login"  '{"phone":"13800000000","password":"123456"}'
Hit "反馈-提交"       POST "$S/aqiFeedback/save"  '{"telId":"13800000000","cityCode":"110100","aqiValue":120,"remark":"测试反馈"}'
Hit "反馈-按手机查"   GET  "$S/aqiFeedback/listByTel?telId=13812345678"
Hit "反馈-按ID查"     GET  "$S/aqiFeedback/1"

Write-Host "`n############## 前端可达性 ##############"
foreach ($pair in @("5173:管理端","5174:数据大屏","8083:网格员端","8084:监督员端")) {
  $port=$pair.Split(":")[0]; $name=$pair.Split(":")[1]
  try { $c=New-Object Net.Sockets.TcpClient; $c.Connect("localhost",[int]$port); $c.Close()
        Write-Host ("[OK] {0} http://localhost:{1}" -f $name,$port) -ForegroundColor Green }
  catch { Write-Host ("[X]  {0} :{1}" -f $name,$port) -ForegroundColor Red }
}

Write-Host "`n==================== 汇总 ===================="
Write-Host ("后端接口 PASS={0}  WARN={1}  FAIL={2} （共 {3} 个）" -f $script:pass,$script:warn,$script:fail,($script:pass+$script:warn+$script:fail))
