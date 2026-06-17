# WhatTeam 自动化一键运行手册

本项目由多个微服务（后端 Spring Boot）和多个前端应用（Vue/Vite）组合而成。为了简化繁琐的配置和启动流程，我们在 `scripts/` 目录下为您准备了全套的自动化运行脚本。

**支持平台**：Windows (PowerShell) / Linux & macOS (Bash)

---

## 1. 环境准备 (前提条件)
请确保您的电脑已正确安装以下软件并加入系统环境变量：
- **Java**: JDK 21
- **Node.js**: v18+ (并安装好 `npm`，前端会自动安装依赖)
- **Maven**: 3.8+ (`mvn` 命令可用)
- **MySQL**: 8.0+（**特别注意：请确保 MySQL 系统服务正在运行中**）

---

## 2. 第一步：初始化数据库 (仅首次需要)
系统包含四个核心业务及环境数据库。在第一次运行项目前，您需要使用脚本一键导入所有的表结构和基础测试数据。

**在项目根目录打开终端 (Terminal)**，根据您的系统选择执行：

- **Windows**:
  ```powershell
  powershell -ExecutionPolicy Bypass -File scripts\init-db.ps1 -User root -Password 你的MySQL密码
  ```
- **Linux/macOS**:
  ```bash
  bash scripts/init-db.sh -u root -p 你的MySQL密码
  ```
> **提示**：如果您的本地 MySQL root 账号没有设置密码，可以省略密码参数。脚本会自动创建并导入 `nepu`、`nep`、`aqstest`、`nepu_environment` 数据库。

---

## 3. 第二步：一键启动全套系统
您无需手动一个个修改代码配置和繁琐的终端命令！启动脚本已配置好了自动避开冲突的端口分配、统一本地数据库密码、以及前端自动依赖拉取 (`npm install`)。

**在项目根目录执行：**

- **Windows**:
  ```powershell
  powershell -ExecutionPolicy Bypass -File scripts\start-all.ps1
  ```
- **Linux/macOS**:
  ```bash
  bash scripts/start-all.sh
  ```

**启动过程说明：**
- 脚本首先会在后台启动 3 个 Spring Boot 后端项目。首次启动时 Maven 会下载大量依赖，请耐心等待直到出现 `[OK]`。
- 后端就绪后，脚本会在后台并发启动 4 个前端 Vite 项目。
- **如果遇到卡住或失败？** 如果某一项长时间后提示 `[超时]`，请检查根目录下 `.run/logs/` 文件夹中对应的错误日志！(例如，最常见的情况是由于电脑重启导致您的 MySQL 未启动，从而引发后端抛出 Connection Refused 崩溃)

---

## 4. 第三步：访问与测试
全部 `[OK]` 启动完成后，您可以使用浏览器访问以下地址：

1. **环境监控大屏 (Dashboard)** 
   👉 `http://localhost:5174`
   - *（纯数据大屏展示，无需登录）*

2. **管理端 (Admin)** 
   👉 `http://localhost:5173`
   - *测试账号*：`AD001`
   - *密码*：`123456`

3. **网格员端 (Networker)** 
   👉 `http://localhost:8083`
   - *测试账号*：`G001` 或 手机号 `13512345678`
   - *密码*：`123456`

4. **监督员端 (Supervisor)** 
   👉 `http://localhost:8084`
   - *测试账号*：手机号 `13800000001`
   - *密码*：`123456`

---

## 5. 第四步：一键停止与清理
由于项目的后端进程与前端节点进程都在**后台模式**隐藏运行，当您开发完毕想要关闭系统时，**直接关闭控制台（Cmd/PowerShell）窗口是无效的**，这会导致幽灵进程残留在后台持续占用端口并消耗内存。

请务必执行一键停止脚本来安全结束所有进程：

- **Windows**:
  ```powershell
  powershell -ExecutionPolicy Bypass -File scripts\stop-all.ps1
  ```
- **Linux/macOS**:
  ```bash
  bash scripts/stop-all.sh
  ```
> **提示**：该脚本会读取 `.run/` 目录下临时记录的进程文件，精准地关闭所有对应的前后端后台服务。

---

## 附录：自动化工具脚本清单
```text
scripts/
 ├── init-db.ps1 / .sh    # 数据库初始化与种子数据一键导入
 ├── start-all.ps1 / .sh  # 并发自动启动所有微服务前后端
 ├── stop-all.ps1 / .sh   # 根据 PID 安全终止所有本项目的服务
 └── test-api.ps1 / .sh   # 后端接口连通性快速测试工具
```
