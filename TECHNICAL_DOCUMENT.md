
# NEPG 网格员系统技术文档

## 1. 项目概述

NEPG 网格员系统是一个专注于空气质量监测与公众监督的网格化管理系统。系统采用前后端分离架构，实现了用户登录、任务分配、数据采集与统计分析等核心功能，为环保网格员提供便捷的移动工作平台。

## 2. 核心技术选型

### 2.1 前端技术栈

| 分类 | 技术 | 版本 | 说明 |
|------|------|------|------|
| 核心框架 | Vue.js | 3.4.21 | 渐进式JavaScript框架，采用Composition API |
| 构建工具 | Vite | 5.1.6 | 下一代前端构建工具，提供极速热更新 |
| 路由管理 | Vue Router | 4.3.0 | 官方路由管理器 |
| UI组件库 | Vant | 3.6.16 | 轻量可靠的移动端Vue组件库 |
| 网络请求 | Axios | 1.6.7 | Promise-based HTTP客户端 |
| 图标库 | Font Awesome | 4.7.0 | 矢量图标字体库 |

### 2.2 后端技术栈

| 分类 | 技术 | 版本 | 说明 |
|------|------|------|------|
| 核心框架 | Spring Boot | 3.1.5 | Java企业级应用框架 |
| ORM框架 | MyBatis-Plus | 3.5.4 | MyBatis增强工具，简化CRUD |
| 数据库 | MySQL | 8.0+ | 关系型数据库 |
| 代码简化 | Lombok | 1.18.30 | 自动生成getter/setter等 |
| Java版本 | JDK | 17 | LTS版本 |

### 2.3 开发工具

| 分类 | 工具 | 说明 |
|------|------|------|
| 前端 | VS Code / WebStorm | 代码编辑器 |
| 后端 | IntelliJ IDEA / Eclipse | Java IDE |
| 数据库 | Navicat / DataGrip | 数据库管理工具 |
| 构建工具 | Maven | Java项目构建 |
| 包管理 | npm | Node.js包管理 |

## 3. 项目目录结构

### 3.1 前端项目结构 (`networker/`)

```
networker/                              # 前端根目录
├── public/                             # 静态资源
│   └── favicon.ico                    # 网站图标
├── src/                               # 源代码
│   ├── api/                           # API接口定义
│   │   └── index.js                   # 接口配置与封装
│   ├── views/                         # 页面组件
│   │   ├── Login.vue                  # 登录页面
│   │   ├── FeedbackList.vue           # 反馈任务列表
│   │   └── FeedbackInfo.vue           # 反馈详情与数据提交
│   ├── router/                        # 路由配置
│   │   └── index.js                   # 路由定义
│   ├── App.vue                        # 根组件
│   └── main.js                        # 应用入口
├── index.html                         # HTML模板
├── package.json                       # 依赖配置
├── vite.config.js                     # Vite配置
└── README.md                          # 项目说明
```

### 3.2 后端项目结构 (`networker-backend/`)

```
networker-backend/                     # 后端根目录
├── src/main/java/com/networker/       # Java源代码
│   ├── NetworkerApplication.java      # Spring Boot启动类
│   ├── controller/                    # 控制层（REST API）
│   │   ├── GridMemberController.java  # 用户登录接口
│   │   ├── FeedbackController.java    # 反馈任务接口
│   │   └── StatisticsController.java  # 统计数据接口
│   ├── service/                       # 服务层（业务逻辑）
│   │   ├── GridMemberService.java     # 用户服务
│   │   ├── AqiFeedbackService.java    # 反馈服务
│   │   └── StatisticsService.java     # 统计服务
│   ├── mapper/                        # 数据访问层
│   │   ├── GridMemberMapper.java      # 用户Mapper
│   │   ├── AqiFeedbackMapper.java     # 反馈Mapper
│   │   └── StatisticsMapper.java      # 统计Mapper
│   └── entity/                        # 实体类（数据库映射）
│       ├── GridMember.java            # 用户实体
│       ├── AqiFeedback.java           # 反馈实体
│       ├── Statistics.java            # 统计实体
│       ├── GridProvince.java          # 省份实体
│       └── GridCity.java              # 城市实体
├── src/main/resources/                # 资源文件
│   ├── application.yml                # 应用配置
│   └── logback-spring.xml             # 日志配置
├── nepu.sql                           # 数据库初始化脚本
├── pom.xml                            # Maven配置
└── README.md                          # 项目说明
```

## 4. 核心功能模块

### 4.1 用户认证模块

**功能描述**：实现网格员登录、身份验证

**涉及文件**：
- `GridMemberController.java` - 登录接口
- `GridMemberService.java` - 登录业务逻辑
- `GridMemberMapper.java` - 用户数据访问
- `GridMember.java` - 用户实体

**登录流程**：
```
前端请求 → Controller → Service → Mapper → 数据库
    ↓                                    ↓
验证成功 → 返回用户信息              查询用户
```

### 4.2 任务管理模块

**功能描述**：展示待处理的空气质量反馈任务

**涉及文件**：
- `FeedbackController.java` - 任务接口
- `AqiFeedbackService.java` - 任务业务逻辑
- `AqiFeedbackMapper.java` - 任务数据访问
- `AqiFeedback.java` - 反馈实体

**任务状态流转**：
```
待分配(0) → 已指派(1) → 已完成(2)
     ↑                     |
     └─────────────────────┘
```

### 4.3 数据采集模块

**功能描述**：提交实测空气质量数据

**涉及文件**：
- `StatisticsController.java` - 统计接口
- `StatisticsService.java` - 统计业务逻辑
- `StatisticsMapper.java` - 统计数据访问
- `Statistics.java` - 统计实体

**数据采集流程**：
```
填写数据 → 提交请求 → 保存统计记录 → 更新反馈状态
```

### 4.4 数据统计模块

**功能描述**：统计分析空气质量数据

**涉及文件**：
- `StatisticsController.java` - 统计接口
- `StatisticsService.java` - 统计业务逻辑

## 5. API接口设计

### 5.1 接口规范

| 项目 | 规范 |
|------|------|
| 协议 | HTTP/HTTPS |
| 基础路径 | `/api` |
| 请求格式 | JSON |
| 响应格式 | JSON |
| 编码格式 | UTF-8 |

### 5.2 响应格式

```json
{
    "code": 200,
    "message": "success",
    "data": {}
}
```

| 字段 | 类型 | 说明 |
|------|------|------|
| `code` | Integer | 状态码（200成功，其他为错误码） |
| `message` | String | 响应消息 |
| `data` | Object | 响应数据 |

### 5.3 用户接口

| API路径 | HTTP方法 | 功能描述 |
|---------|----------|----------|
| `/api/gridMember/login` | POST | 用户登录 |
| `/api/gridMember/list` | GET | 获取用户列表 |
| `/api/gridMember/{id}` | GET | 获取用户详情 |
| `/api/gridMember` | POST | 创建用户 |
| `/api/gridMember/{id}` | PUT | 更新用户 |
| `/api/gridMember/{id}` | DELETE | 删除用户 |

**登录接口示例**：

请求：
```json
POST /api/gridMember/login
{
    "loginCode": "caocao",
    "password": "123"
}
```

响应：
```json
{
    "code": 200,
    "message": "success",
    "data": {
        "gmId": 1,
        "gmName": "曹操",
        "gmCode": "caocao",
        "provinceId": 1,
        "cityId": 1,
        "tel": "12687643458",
        "state": 0
    }
}
```

### 5.4 反馈任务接口

| API路径 | HTTP方法 | 功能描述 |
|---------|----------|----------|
| `/api/feedback/list` | POST | 获取任务列表（分页） |
| `/api/feedback/{id}` | GET | 获取任务详情 |
| `/api/feedback` | POST | 创建反馈 |
| `/api/feedback/{id}` | PUT | 更新反馈 |
| `/api/feedback/{id}` | DELETE | 删除反馈 |

**获取任务列表**：

请求：
```json
POST /api/feedback/list?gmId=1
{
    "pageNum": 1,
    "pageSize": 10
}
```

响应：
```json
{
    "code": 200,
    "message": "success",
    "data": {
        "total": 13,
        "records": [...],
        "pageNum": 1,
        "pageSize": 10
    }
}
```

### 5.5 统计数据接口

| API路径 | HTTP方法 | 功能描述 |
|---------|----------|----------|
| `/api/statistics/submit` | POST | 提交实测数据 |
| `/api/statistics/list` | POST | 获取统计列表 |
| `/api/statistics/{id}` | GET | 获取统计详情 |

**提交实测数据**：

请求：
```json
POST /api/statistics/submit
{
    "gmId": 1,
    "afId": 1,
    "so2": 250,
    "co": 0.8,
    "pm25": 150
}
```

响应：
```json
{
    "code": 200,
    "message": "提交成功",
    "data": true
}
```

## 6. 数据库设计

### 6.1 数据库表清单

| 表名 | 说明 |
|------|------|
| `grid_member` | 用户表（网格员信息） |
| `aqi_feedback` | 反馈表（空气质量反馈） |
| `statistics` | 统计表（实测数据） |
| `grid_province` | 省份表 |
| `grid_city` | 城市表 |
| `aqi` | AQI等级表 |

### 6.2 用户表 (`grid_member`)

| 字段名 | 类型 | 约束 | 说明 |
|--------|------|------|------|
| `gm_id` | INT | PRIMARY KEY, AUTO_INCREMENT | 用户ID |
| `gm_name` | VARCHAR(20) | NOT NULL | 用户姓名 |
| `gm_code` | VARCHAR(20) | UNIQUE, NOT NULL | 登录账号 |
| `password` | VARCHAR(20) | NOT NULL | 登录密码 |
| `province_id` | INT | NOT NULL | 所属省份 |
| `city_id` | INT | NOT NULL | 所属城市 |
| `tel` | VARCHAR(20) | NOT NULL | 联系电话 |
| `state` | INT | DEFAULT 0 | 状态（0启用，1禁用） |
| `remarks` | VARCHAR(200) | NULL | 备注 |

### 6.3 反馈表 (`aqi_feedback`)

| 字段名 | 类型 | 约束 | 说明 |
|--------|------|------|------|
| `af_id` | INT | PRIMARY KEY, AUTO_INCREMENT | 反馈ID |
| `af_date` | VARCHAR(20) | NOT NULL | 反馈日期 |
| `af_time` | VARCHAR(20) | NOT NULL | 反馈时间 |
| `address` | VARCHAR(100) | NOT NULL | 详细地址 |
| `province_id` | INT | NOT NULL | 省份ID |
| `city_id` | INT | NOT NULL | 城市ID |
| `level` | VARCHAR(20) | NOT NULL | 预估等级 |
| `description` | VARCHAR(500) | NULL | 信息描述 |
| `gm_id` | INT | NULL | 指派网格员ID |
| `state` | INT | DEFAULT 0 | 状态（0待分配，1已指派，2已完成） |

### 6.4 统计表 (`statistics`)

| 字段名 | 类型 | 约束 | 说明 |
|--------|------|------|------|
| `id` | INT | PRIMARY KEY, AUTO_INCREMENT | 统计ID |
| `gm_id` | INT | NOT NULL | 网格员ID |
| `fd_id` | VARCHAR(50) | NOT NULL | 反馈ID（外键） |
| `so2_value` | INT | NOT NULL | SO2浓度 |
| `co_value` | INT | NOT NULL | CO浓度 |
| `spm_value` | INT | NOT NULL | PM2.5浓度 |
| `confirm_date` | VARCHAR(20) | NOT NULL | 确认日期 |
| `confirm_time` | VARCHAR(20) | NOT NULL | 确认时间 |

### 6.5 省份表 (`grid_province`)

| 字段名 | 类型 | 约束 | 说明 |
|--------|------|------|------|
| `province_id` | INT | PRIMARY KEY | 省份ID |
| `province_name` | VARCHAR(50) | NOT NULL | 省份名称 |

### 6.6 城市表 (`grid_city`)

| 字段名 | 类型 | 约束 | 说明 |
|--------|------|------|------|
| `city_id` | INT | PRIMARY KEY | 城市ID |
| `city_name` | VARCHAR(50) | NOT NULL | 城市名称 |
| `province_id` | INT | NOT NULL | 所属省份ID |

## 7. 部署与运行

### 7.1 环境要求

| 环境 | 版本要求 |
|------|---------|
| JDK | 17+ |
| Node.js | 18+ |
| MySQL | 8.0+ |
| Maven | 3.8+ |

### 7.2 数据库配置

```sql
-- 创建数据库
CREATE DATABASE nepu CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 导入数据
USE nepu;
SOURCE /path/to/nepu.sql;
```

### 7.3 后端启动

```bash
# 进入后端目录
cd networker-backend

# 开发模式启动
mvn spring-boot:run

# 生产模式运行
mvn clean package -DskipTests
java -jar target/networker-backend-1.0.0.jar
```

**配置文件** (`application.yml`)：

```yaml
server:
  port: 8080

spring:
  datasource:
    url: jdbc:mysql://localhost:3306/nepu?useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai
    username: root
    password: 123456
    driver-class-name: com.mysql.cj.jdbc.Driver

mybatis-plus:
  configuration:
    map-underscore-to-camel-case: true
```

### 7.4 前端启动

```bash
# 进入前端目录
cd networker

# 安装依赖
npm install

# 开发模式启动
npm run dev

# 生产构建
npm run build
```

**配置文件** (`vite.config.js`)：

```javascript
export default defineConfig({
  server: {
    host: '0.0.0.0',
    port: 8083,
    proxy: {
      '/api': {
        target: 'http://localhost:8080',
        changeOrigin: true
      }
    }
  }
})
```

### 7.5 服务访问

| 服务 | 地址 |
|------|------|
| 前端页面 | http://localhost:8083/ |
| 后端API | http://localhost:8080/api |

## 8. 测试账号

| 账号 | 密码 | 角色 |
|------|------|------|
| `caocao` | `123` | 网格员 |
| `liubei` | `123` | 网格员 |
| `sunquan` | `123` | 网格员 |
| `guanyu` | `123` | 网格员 |
| `zhangfei` | `123` | 网格员 |
| `admin` | `123` | 管理员 |

## 9. 安全注意事项

### 9.1 数据安全

- 密码应使用加密存储（当前为明文，生产环境建议使用BCrypt加密）
- API接口应增加认证机制（如JWT Token）
- 敏感数据传输应使用HTTPS协议

### 9.2 接口安全

- 增加请求频率限制
- 实现参数校验
- 添加日志审计

### 9.3 部署安全

- 生产环境应关闭DEBUG模式
- 配置适当的防火墙规则
- 定期备份数据库

## 10. 附录

### 10.1 状态码说明

| 状态码 | 说明 |
|--------|------|
| 200 | 请求成功 |
| 400 | 请求参数错误 |
| 401 | 未认证（未登录） |
| 403 | 无权限 |
| 404 | 资源不存在 |
| 500 | 服务器内部错误 |

### 10.2 AQI等级说明

| 等级 | 范围 | 描述 |
|------|------|------|
| 一级 | 0-50 | 优 |
| 二级 | 51-100 | 良 |
| 三级 | 101-150 | 轻度污染 |
| 四级 | 151-200 | 中度污染 |
| 五级 | 201-300 | 重度污染 |
| 六级 | >300 | 严重污染 |
