#!/usr/bin/env bash
# ============================================================
# 一键启动 NEPM 全部前后端项目（本地开发）
# 端口分配：
#   AQI-SYS(后端)         8080  ctx:/api
#   networker-backend     8085
#   supervisor-backend    8082
#   nepm-admin(前端)      5173 -> /api 代理 8080
#   nepv-dashboard(前端)  5174 -> /api 代理 8080
#   networker(前端)       8083 -> /api 代理 8085
#   supervisor(前端)      8084 -> /api 代理 8082
# ============================================================
set -u
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
RUN="$ROOT/.run"; LOGS="$RUN/logs"
mkdir -p "$LOGS"

export JAVA_HOME="$(/usr/libexec/java_home -v 17 2>/dev/null)"
export PATH="/Users/qfmmx/environment/apache-maven-3.8.8/bin:$PATH"

start_back() {  # name  dir  port
  local name="$1" dir="$2" port="$3"
  echo "▶ 启动后端 $name (端口 $port) ..."
  nohup mvn -q -f "$dir/pom.xml" spring-boot:run > "$LOGS/$name.log" 2>&1 &
  echo $! > "$RUN/$name.pid"
}

start_front() { # name  dir  port
  local name="$1" dir="$2" port="$3"
  echo "▶ 启动前端 $name (端口 $port) ..."
  ( cd "$dir" && nohup npm run dev > "$LOGS/$name.log" 2>&1 & echo $! > "$RUN/$name.pid" )
}

wait_port() {   # port  name  timeout(s)
  local port="$1" name="$2" max="${3:-90}" i=0
  printf "  等待 %s :%s " "$name" "$port"
  while [ $i -lt "$max" ]; do
    code=$(curl -s -o /dev/null -m 2 -w "%{http_code}" "http://localhost:$port/" 2>/dev/null)
    if [ "$code" != "000" ]; then echo " ✅ 就绪(HTTP $code)"; return 0; fi
    sleep 2; i=$((i+2)); printf "."
  done
  echo " ❌ 超时（见 $LOGS/$name.log）"; return 1
}

echo "=== 后端（Spring Boot, 首次会下载依赖，请耐心）==="
start_back AQI-SYS            "$ROOT/nepm/AQI-SYS"               8080
start_back networker-backend  "$ROOT/network/networker-backend"  8085
start_back supervisor-backend "$ROOT/supervisor/backend"         8082

wait_port 8080 AQI-SYS 180
wait_port 8085 networker-backend 180
wait_port 8082 supervisor-backend 180

echo "=== 前端（Vite）==="
start_front nepm-admin     "$ROOT/nepm/nepm-admin"               5173
start_front nepv-dashboard "$ROOT/nepv-dashboard"                5174
start_front networker      "$ROOT/network/networker"             8083
start_front supervisor     "$ROOT/supervisor/front/supervisor"   8084

wait_port 5173 nepm-admin 60
wait_port 5174 nepv-dashboard 60
wait_port 8083 networker 60
wait_port 8084 supervisor 60

echo
echo "================ 全部启动完成 ================"
echo "管理端     http://localhost:5173"
echo "数据大屏   http://localhost:5174"
echo "网格员端   http://localhost:8083"
echo "监督员端   http://localhost:8084"
echo "日志目录   $LOGS"
echo "停止全部   bash scripts/stop-all.sh"
