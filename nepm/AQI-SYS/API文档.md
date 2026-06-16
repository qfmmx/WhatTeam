# NEPM Admin 前端与后端 API 接口文档

## 全局约定

所有接口均默认以 JSON 格式进行数据交互，基础响应结构如下：

```json
{
  "code": 200,      // 200表示成功，非200表示失败
  "message": "操作成功", // 提示信息
  "data": {}        // 具体的响应数据，结构见各接口定义
}
```

---

## 1. 管理员认证模块

### 1.1 管理员登录
- **请求方式**：`POST`
- **请求路径**：`/auth/admin/login` (或 `/admins/login`)
- **请求参数** (Body):
  ```json
  {
    "adminCode": "admin001",
    "password": "密码"
  }
  ```
- **响应数据** (`data` 字段):
  ```json
  {
    "id": 1,
    "adminCode": "admin001",
    "adminName": "系统管理员",
    "role": "super",
    "status": 1
  }
  ```

---

## 2. 公众监督反馈模块 (Feedback)

### 2.1 分页查询反馈列表
- **请求方式**：`GET` `/feedback` **或** `POST` `/aqiFeedback/page`
- **请求参数** (Query 或 Body):
  - `pageNum` (Number) 必填：当前页码
  - `pageSize` (Number) 必填：每页条数
  - `state` (Number) 选填：状态（0未指派，1已指派，2已完成）
  - `cityCode` (String) 选填：城市编码
  - `telId` (String) 选填：手机号
  - `startTime` (String) 选填：开始时间 (例如: "2022-08-26 10:00:00")
  - `endTime` (String) 选填：结束时间
- **响应数据** (`data` 字段):
  ```json
  {
    "total": 100,
    "pages": 10,
    "current": 1,
    "size": 10,
    "records": [
      {
        "id": 38,
        "telId": "17345988896",
        "cityCode": "210200",
        "cityName": "大连市",
        "aqiValue": 175,
        "feedbackTime": "2022-10-27 16:29:26",
        "state": 0,
        "gmId": null,
        "gmName": null,
        "assignTime": null,
        "remark": "月黑风高，空气浑浊，难道是杀人夜？"
      }
    ]
  }
  ```

### 2.2 获取反馈详情
- **请求方式**：`GET`
- **请求路径**：`/feedback/{id}` **或** `/aqiFeedback/{id}`
- **路径参数**：`id` (反馈记录的ID)
- **响应数据** (`data` 字段):
  ```json
  {
    "id": 38,
    "telId": "17345988896",
    "cityCode": "210200",
    "cityName": "大连市",
    "provinceName": "辽宁省",
    "aqiValue": 175,
    "feedbackTime": "2022-10-27 16:29:26",
    "state": 0,
    "gmId": null,
    "gmName": null,
    "assignTime": null,
    "remark": "月黑风高，空气浑浊，难道是杀人夜？"
  }
  ```

### 2.3 查询本市在岗网格员
- **请求方式**：`GET`
- **请求路径**：`/feedback/{afId}/localMembers`
- **路径参数**：`afId` (反馈记录的ID)
- **响应数据** (`data` 字段):
  ```json
  {
    "provinceId": 3,
    "provinceName": "辽宁省",
    "cityId": 7,
    "cityName": "大连市",
    "hasLocal": true,
    "members": [
      {
        "id": 1,
        "memberCode": "gm1001",
        "memberName": "徐昊",
        "phone": "12687643458",
        "provinceId": 3,
        "cityId": 7,
        "status": 1
      }
    ]
  }
  ```

### 2.4 查询跨省可调派网格员
- **请求方式**：`GET`
- **请求路径**：`/feedback/{afId}/crossMembers`
- **路径参数**：`afId` (反馈记录的ID)
- **响应数据** (`data` 字段):
  ```json
  [
    {
      "id": 6,
      "memberCode": "gm1006",
      "memberName": "夏保演",
      "phone": "13812345678",
      "provinceId": 9,
      "cityId": 25,
      "status": 1,
      "provinceName": "江苏省",
      "cityName": "南京市"
    }
  ]
  ```

### 2.5 提交指派网格员
- **请求方式**：`PUT`
- **请求路径**：`/feedback/assign` **或** `/aqiFeedback/assign`
- **请求参数** (Body):
  ```json
  {
    "afId": 38,
    "gmId": 1
  }
  ```
- **响应数据** (`data` 字段): 
  ```json
  1
  ```

### 2.6 更新反馈状态
- **请求方式**：`PUT`
- **请求路径**：`/aqiFeedback/state`
- **请求参数** (Body):
  ```json
  {
    "id": 38,
    "state": 2
  }
  ```
- **响应数据** (`data` 字段): 
  ```json
  1
  ```

---

## 3. 区域与网格员模块

### 3.1 查询所有省份
- **请求方式**：`GET`
- **请求路径**：`/gridProvince/listAll`
- **响应数据** (`data` 字段):
  ```json
  [
    {
      "id": 1,
      "provinceCode": "110000",
      "provinceName": "北京市"
    },
    {
      "id": 2,
      "provinceCode": "310000",
      "provinceName": "上海市"
    }
  ]
  ```

### 3.2 根据省份查询城市列表
- **请求方式**：`GET`
- **请求路径**：`/gridCity/listByProvince`
- **请求参数** (Query): `provinceId`
- **响应数据** (`data` 字段):
  ```json
  [
    {
      "id": 1,
      "cityCode": "110100",
      "cityName": "北京市",
      "provinceId": 1
    },
    {
      "id": 2,
      "cityCode": "110200",
      "cityName": "朝阳区",
      "provinceId": 1
    }
  ]
  ```

### 3.3 根据城市查询网格员列表
- **请求方式**：`GET`
- **请求路径**：`/gridMember/listByCity`
- **请求参数** (Query): `provinceId`, `cityId`
- **响应数据** (`data` 字段): 
  ```json
  [
    {
      "id": 1,
      "memberCode": "gm1001",
      "memberName": "徐昊",
      "phone": "12687643458",
      "provinceId": 3,
      "cityId": 7,
      "status": 1
    }
  ]
  ```

---

## 4. 统计分析模块 (Statistics)

### 4.1 分页查询统计记录
- **请求方式**：`POST`
- **请求路径**：`/statistics/page`
- **请求参数** (Body):
  - `pageNum` (Number) 必填
  - `pageSize` (Number) 必填
  - `cityName` (String) 选填
  - `isExceed` (Number) 选填：是否超标（1是，0否）
  - `startTime`, `endTime` (String) 选填
- **响应数据** (`data` 字段): 
  ```json
  {
    "total": 38,
    "pages": 4,
    "current": 1,
    "size": 10,
    "records": [
      {
        "id": 38,
        "cityCode": "210200",
        "aqiValue": 175,
        "confirmTime": "2022-10-27 17:01:52",
        "gmId": 1,
        "isExceed": 1
      }
    ]
  }
  ```

### 4.2 获取单条统计记录详情
- **请求方式**：`GET`
- **请求路径**：`/statistics/{id}`
- **响应数据** (`data` 字段):
  ```json
  {
    "id": 38,
    "cityCode": "210200",
    "aqiValue": 175,
    "confirmTime": "2022-10-27 17:01:52",
    "gmId": 1,
    "isExceed": 1
  }
  ```

### 4.3 各省超标数据统计
- **请求方式**：`GET`
- **请求路径**：`/statistics/provinceTotal`
- **响应数据** (`data` 字段):
  ```json
  [
    {
      "provinceName": "辽宁省",
      "totalCount": 5,
      "exceedCount": 4,
      "exceedRate": "80.0%"
    }
  ]
  ```

### 4.4 AQI 等级分布统计
- **请求方式**：`GET`
- **请求路径**：`/statistics/aqiDistribute`
- **响应数据** (`data` 字段):
  ```json
  [
    {
      "level": 1,
      "levelName": "优",
      "count": 4,
      "percentage": "10.5%"
    },
    {
      "level": 2,
      "levelName": "良",
      "count": 8,
      "percentage": "21.1%"
    }
  ]
  ```

### 4.5 超标趋势统计 (近12个月)
- **请求方式**：`GET`
- **请求路径**：`/statistics/trend`
- **响应数据** (`data` 字段):
  ```json
  [
    {
      "month": "2022-10",
      "exceedCount": 3
    },
    {
      "month": "2022-09",
      "exceedCount": 2
    }
  ]
  ```

### 4.6 概览数据指标 (共 4 个接口)
- **请求方式**：均为 `GET`

#### 4.6.1 累计检测总数
- **请求路径**：`/statistics/totalCount`
- **响应数据** (`data` 字段): 
  ```json
  38
  ```

#### 4.6.2 空气良好天数
- **请求路径**：`/statistics/goodCount`
- **响应数据** (`data` 字段): 
  ```json
  12
  ```

#### 4.6.3 省份覆盖率
- **请求路径**：`/statistics/provinceCoverage`
- **响应数据** (`data` 字段): 
  ```json
  "29.4%"
  ```

#### 4.6.4 城市覆盖率
- **请求路径**：`/statistics/cityCoverage`
- **响应数据** (`data` 字段): 
  ```json
  "13.2%"
  ```