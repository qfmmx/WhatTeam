#!/usr/bin/env bash
# 停止 start-all.sh 启动的全部前后端进程
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
RUN="$ROOT/.run"

echo "=== 按 PID 文件停止 ==="
if [ -d "$RUN" ]; then
  for pidf in "$RUN"/*.pid; do
    [ -e "$pidf" ] || continue
    name=$(basename "$pidf" .pid); pid=$(cat "$pidf")
    if kill -0 "$pid" 2>/dev/null; then
      # 杀掉整个进程组（mvn/npm 会派生子进程）
      pkill -P "$pid" 2>/dev/null
      kill "$pid" 2>/dev/null
      echo "  已停止 $name (pid $pid)"
    fi
    rm -f "$pidf"
  done
fi

echo "=== 兜底：按端口清理 ==="
for port in 8080 8085 8082 5173 5174 8083 8084; do
  pids=$(lsof -nP -iTCP:$port -sTCP:LISTEN -t 2>/dev/null)
  if [ -n "$pids" ]; then kill $pids 2>/dev/null && echo "  释放端口 $port (pid $pids)"; fi
done
echo "完成。"
