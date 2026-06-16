# NEPV 大屏前端核心技术文档 (nepv-dashboard)

## 1. 项目概述
NEPV 环境监测大屏系统（nepv-dashboard）是一个专注于空气质量监控、污染数据展示与公众监督的实时大屏可视化系统。
系统采用深色科技风格设计，实现了全国各省份 AQI 超标统计、核心污染物（PM2.5、SO₂、CO）超标排行、实时监测数据跳动等交互展示功能。

## 2. 核心技术选型
本项目前端建立在现代化、高性能的技术栈之上：
- **核心框架**: `Vue 3` (采用 Composition API 语法糖 `<script setup>`)
- **工程化构建**: `Vite` (提供极速模块热更新 HMR)
- **可视化引擎**: `Apache ECharts 5`
- **大屏装饰器**: `@kjgl77/datav-vue3` (提供科技风边框与装饰动画)
- **网络通信**: `Axios`

## 3. 项目目录结构
```text
nepv-dashboard/
├── public/                 # 静态资源
├── src/
│   ├── api/
│   │   └── statistics.js   # 统一后端接口请求封装
│   ├── assets/             # 全局样式、图片等静态文件
│   ├── components/         # 独立化、可复用的 ECharts 图表组件库
│   ├── views/
│   │   └── Dashboard.vue   # 大屏主页面，负责组件编排与数据分发
│   ├── App.vue             # 根组件
│   └── main.js             # Vue 实例挂载与插件注册
├── vite.config.js          # Vite 与接口代理配置
└── package.json            # 依赖管理
```

## 4. 关键组件设计

为了保证大屏代码的整洁与高复用性，所有的 ECharts 图表均被抽离为独立的 Vue 组件：

### 4.1 Dashboard.vue (核心控制器)
- **职责**: 作为整个大屏的布局容器。采用 `Flex` 弹性盒子进行三列式布局。
- **数据调度**: 在 `onMounted` 生命周期内，通过 `setInterval` 设置 **5秒一轮的实时接口轮询** (`fetchDashboardData`)。
- **组件通信**: 获取到聚合数据后，通过 Vue 的响应式 `ref`，以 `props` 形式下发给所有子图表组件。

### 4.2 VerticalBarChart.vue (通用柱状图)
- **职责**: 渲染 PM2.5、SO₂、CO 的各省超标排行。
- **复用设计**: 
  - 接收 `data`（省份名与数值数组）和 `color`（柱体颜色）参数。
  - 通过动态传参，一份代码同时渲染了三大污染物的独立柱状图。
- **高级特性**: 内部集成了隐藏式的 `dataZoom` 滚动条组件，支持图表的拖动和滚轮缩放；且在数据刷新时具有**状态记忆功能**，防止用户的滚动视角被重置。

### 4.3 ChinaMap.vue (中央地图)
- **职责**: 视觉焦点，直观展示全国地理分布。
- **技术点**: 引入中国地图 GeoJSON 数据，利用 ECharts 的 `visualMap`（视觉映射组件）实现根据超标数值大小自动进行颜色深度渐变渲染。

### 4.4 其他辅助图表
- **CoverageChart.vue (仪表盘)**: 采用 ECharts `gauge` 图表，隐藏杂乱刻度，展示全国网格覆盖率。
- **AqiDistributeChart.vue (分布饼图)**: 采用 `pie` 饼图，渲染污染级别的占比情况，配置了特定调色盘。
- **TrendChart.vue (趋势折线图)**: 展示近 12 个月的超标变化，采用平滑曲线（`smooth: true`）与区域颜色渐变。

## 5. 数据流与接口规范

### 5.1 统一请求接口 (`api/statistics.js`)
为遵循后端统一聚合原则，废弃了零散请求，封装了单一获取函数：
```javascript
export const getDashboardData = () => {
  return axios.get('/api/statistics/dashboard');
};
```

### 5.2 Vite 代理 (Proxy)
配置 `vite.config.js` 跨越浏览器的同源策略限制，实现本地前后端无缝联调：
```javascript
server: {
  proxy: {
    '/api': {
      target: 'http://localhost:8080',
      changeOrigin: true
    }
  }
}
```

## 6. UI 交互体验设计
1. **配色方案**: 统一的 `Material Dark` 风格，背景采用 `#040b1c`，图表主色调使用深空蓝、清新绿和警示红，极具环保科技感。
2. **状态保留**: 前端在接受轮询推送数据覆盖时，巧妙保留了用户在图表上的高亮、缩放（Zoom）等交互状态，确保大屏不仅“好看”且“好用”。

## 7. 运行操作与联调指南

为保证前后端联调顺利进行，请开发人员按照以下标准步骤在本地启动大屏系统：

### 7.1 后端环境及接口启动
1. **数据库准备**: 在本地 MySQL 中新建 `nepu_environment` 数据库，并运行团队提供的 `.sql` 脚本导入基础数据。
2. **配置数据库连接**: 在后端的 `application.yml` 文件中配置本地数据库账号及密码。
3. **启动 Spring Boot**: 在 IDEA 等工具中运行后端启动类，确保控制台输出服务运行在 `8080` 端口。

### 7.2 前端大屏启动
1. **进入目录**: 在终端中切换到项目目录：
   ```bash
   cd nepv-dashboard
   ```
2. **安装依赖**: 首次拉取代码后，必须先安装第三方依赖包（项目已忽略 node_modules）：
   ```bash
   yarn install
   ```
3. **运行服务**: 依赖安装完成后，启动 Vite 开发服务器：
   ```bash
   yarn dev
   ```
4. **效果预览**: 终端提示运行成功后，通过浏览器访问 `http://localhost:5173/`。此时前端会自动通过代理获取本机的 8080 后端接口数据，并开启 5 秒/次的自动化大屏轮询。
