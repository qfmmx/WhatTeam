# supervisor-backend

AQI 公众监督员后端，技术栈为 `Spring Boot 3 + MyBatis-Plus + MySQL + Maven`。

## 已实现接口

- `GET /api/supervisor/checkPhone`
- `POST /api/supervisor/register`
- `POST /api/supervisor/login`
- `POST /api/aqiFeedback/save`
- `GET /api/aqiFeedback/listByTel`
- `GET /api/aqiFeedback/{id}`

## 新增接口

以下 2 个接口为支持省市选择新增：

- `GET /api/region/provinces`
- `GET /api/region/cities?provinceId=1`

## 启动前准备

1. 创建数据库 `nep`
2. 导入你现有的业务 SQL
3. 再导入 `sql/region_tables.sql`
4. 按实际环境修改 `src/main/resources/application.yml` 中的数据库账号密码

## 启动命令

```bash
mvn spring-boot:run
```
