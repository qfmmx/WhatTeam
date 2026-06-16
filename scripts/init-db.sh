#!/usr/bin/env bash
# ============================================================
# 一键初始化数据库：把 db/init-all.sql 导入本地 MySQL
# 创建 3 个库(nepu_environment / nepu / nep) + 8 张表 + 种子数据
#
# 用法：
#   bash scripts/init-db.sh                  # 默认 Docker 容器名 mysql、root 密码 root
#   bash scripts/init-db.sh <容器名> <密码>   # 自定义 Docker
#   MODE=cli bash scripts/init-db.sh          # 用本机 mysql 客户端(非Docker)
# ============================================================
set -e
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SQL="$ROOT/db/init-all.sql"
CONTAINER="${1:-mysql}"
PASSWORD="${2:-root}"
MODE="${MODE:-docker}"

[ -f "$SQL" ] || { echo "❌ 找不到 $SQL"; exit 1; }

echo "▶ 导入 $SQL ..."
if [ "$MODE" = "cli" ]; then
  mysql -uroot -p"$PASSWORD" < "$SQL"
else
  docker exec -i "$CONTAINER" mysql -uroot -p"$PASSWORD" < "$SQL"
fi

echo "✅ 初始化完成。校验各库表数量："
CHECK="SELECT table_schema AS db, COUNT(*) AS tables FROM information_schema.tables WHERE table_schema IN ('nepu_environment','nepu','nep') GROUP BY table_schema;"
if [ "$MODE" = "cli" ]; then
  mysql -uroot -p"$PASSWORD" -e "$CHECK"
else
  docker exec -i "$CONTAINER" mysql -uroot -p"$PASSWORD" -e "$CHECK"
fi
