#!/usr/bin/env bash
# ============================================================
# 全量接口冒烟测试：覆盖三个后端的所有 Controller 路由
# 判定：HTTP 200 → PASS；4xx → WARN(在线/参数或鉴权)；000/5xx → FAIL
# 注：部分写接口(assign/state/save/register/submit)用探测数据，
#     可能返回业务级错误，但只要 HTTP 200 即说明接口连通可用。
# ============================================================
pass=0; warn=0; fail=0
A=http://localhost:8080/api      # AQI-SYS
N=http://localhost:8085/api      # networker-backend
S=http://localhost:8082/api      # supervisor-backend

hit() { # 描述  方法  URL  [JSON body]
  local desc="$1" method="$2" url="$3" body="${4:-}"
  local args=(-s -m 8 -o /tmp/_resp -w "%{http_code}" -X "$method" "$url")
  [ -n "$body" ] && args+=(-H "Content-Type: application/json" -d "$body")
  local code; code=$(curl "${args[@]}" 2>/dev/null)
  local snippet; snippet=$(LC_ALL=C tr '\n' ' ' < /tmp/_resp 2>/dev/null | cut -c1-120)
  local tag
  if [ "$code" = "200" ]; then tag="✅ PASS"; pass=$((pass+1))
  elif [[ "$code" =~ ^4 ]]; then tag="⚠️  WARN"; warn=$((warn+1))
  else tag="❌ FAIL"; fail=$((fail+1)); fi
  printf "%s [%s] %-46s %s\n            ↳ %s\n" "$tag" "$code" "$method ${url#http://localhost}" "$desc" "$snippet"
}

echo "############## AQI-SYS  :8080  (管理端/AQI系统) ##############"
hit "管理员登录"        POST "$A/admins/login"               '{"adminCode":"AD001","password":"123456"}'
hit "管理员登录(别名)"  POST "$A/auth/admin/login"           '{"adminCode":"AD001","password":"123456"}'
hit "省份列表"          GET  "$A/gridProvince/listAll"
hit "城市列表"          GET  "$A/gridCity/listByProvince?provinceId=3"
hit "网格员列表"        GET  "$A/gridMember/listByCity?provinceId=3&cityId=3"
hit "统计-分页"         POST "$A/statistics/page"            '{"pageNum":1,"pageSize":5}'
hit "统计-按ID"         GET  "$A/statistics/1"
hit "统计-省汇总"       GET  "$A/statistics/provinceTotal"
hit "统计-AQI分布"      GET  "$A/statistics/aqiDistribute"
hit "统计-趋势"         GET  "$A/statistics/trend"
hit "统计-总数"         GET  "$A/statistics/totalCount"
hit "统计-优良数"       GET  "$A/statistics/goodCount"
hit "统计-省覆盖率"     GET  "$A/statistics/provinceCoverage"
hit "统计-市覆盖率"     GET  "$A/statistics/cityCoverage"
hit "统计-大屏"         GET  "$A/statistics/dashboard"
hit "反馈-分页"         GET  "$A/feedback?pageNum=1&pageSize=5"
hit "反馈-详情"         GET  "$A/feedback/38"
hit "反馈-本市网格员"   GET  "$A/feedback/38/localMembers"
hit "反馈-跨省网格员"   GET  "$A/feedback/38/crossMembers"
hit "反馈-指派"         PUT  "$A/feedback/assign"            '{"afId":38,"gmId":1}'
hit "反馈-改状态"       PUT  "$A/feedback/state"             '{"id":38,"state":1}'

echo; echo "############## networker-backend  :8085  (网格员端) ##############"
hit "网格员登录"        POST "$N/gridMember/login"           '{"loginCode":"gm1001","password":"123456"}'
hit "反馈-初始化"       GET  "$N/feedback/init"
hit "反馈-列表"         POST "$N/feedback/list?gmId=1"       '{"pageNum":1,"pageSize":5}'
hit "反馈-指派"         POST "$N/feedback/assign"            '{"afId":1,"gmId":1}'
hit "反馈-提交处理"     POST "$N/feedback/submit"            '{"afId":1,"aqiValue":80}'

echo; echo "############## supervisor-backend  :8082  (监督员端) ##############"
hit "省份列表"          GET  "$S/region/provinces"
hit "城市列表"          GET  "$S/region/cities?provinceId=3"
hit "手机号校验"        GET  "$S/supervisor/checkPhone?phone=13800000000"
hit "监督员注册"        POST "$S/supervisor/register"        "{\"phone\":\"139$(date +%H%M%S)\",\"password\":\"123456\",\"name\":\"测试员\"}"
hit "监督员登录"        POST "$S/supervisor/login"           '{"phone":"13800000000","password":"123456"}'
hit "反馈-提交"         POST "$S/aqiFeedback/save"           '{"telId":"13800000000","cityCode":"110100","aqiValue":120,"remark":"测试反馈"}'
hit "反馈-按手机查"     GET  "$S/aqiFeedback/listByTel?telId=13812345678"
hit "反馈-按ID查"       GET  "$S/aqiFeedback/1"

echo; echo "############## 前端可达性 ##############"
for p in 5173:管理端 5174:数据大屏 8083:网格员端 8084:监督员端; do
  port="${p%%:*}"; name="${p##*:}"
  code=$(curl -s -m 5 -o /dev/null -w "%{http_code}" "http://localhost:$port/" 2>/dev/null)
  [ "$code" = "200" ] && echo "✅ $name http://localhost:$port" || echo "❌ $name :$port (HTTP $code)"
done

echo; echo "==================== 汇总 ===================="
echo "后端接口 PASS=$pass  WARN=$warn  FAIL=$fail （共 $((pass+warn+fail)) 个）"
