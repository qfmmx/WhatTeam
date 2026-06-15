# 污染物超标统计与聚合 SQL 方案

## 1. 假设的数据表结构
在此场景下，假设底层关联了两张主要的数据表：
1. `province_info` (省份信息表)
   - `id`: 省份唯一标识 ID
   - `name`: 省份全称（如：河北省）
   - `abbr`: 省份简称（如：冀）
2. `aqi_record` (空气质量检测记录表)
   - `id`: 检测记录唯一标识
   - `province_id`: 关联的省份 ID
   - `pm25`: PM2.5 浓度数值 (μg/m³)
   - `so2`: SO2 浓度数值 (μg/m³)
   - `co`: CO 浓度数值 (mg/m³)
   - `detect_time`: 检测时间

**超标标准参考：**
- PM2.5 > 75 (μg/m³) 为超标
- SO₂ > 150 (μg/m³) 为超标
- CO > 4 (mg/m³) 为超标

---

## 2. SQL 查询语句

### 2.1 统计各省份 PM2.5 超标累计次数
```sql
SELECT 
    p.abbr AS province_short_name,
    COUNT(a.id) AS exceed_count
FROM 
    province_info p
LEFT JOIN 
    aqi_record a ON p.id = a.province_id AND a.pm25 > 75
GROUP BY 
    p.id, p.abbr
ORDER BY 
    exceed_count DESC;
```

### 2.2 统计各省份 SO₂ 超标累计次数
```sql
SELECT 
    p.abbr AS province_short_name,
    COUNT(a.id) AS exceed_count
FROM 
    province_info p
LEFT JOIN 
    aqi_record a ON p.id = a.province_id AND a.so2 > 150
GROUP BY 
    p.id, p.abbr
ORDER BY 
    exceed_count DESC;
```

### 2.3 统计各省份 CO 超标累计次数
```sql
SELECT 
    p.abbr AS province_short_name,
    COUNT(a.id) AS exceed_count
FROM 
    province_info p
LEFT JOIN 
    aqi_record a ON p.id = a.province_id AND a.co > 4
GROUP BY 
    p.id, p.abbr
ORDER BY 
    exceed_count DESC;
```

