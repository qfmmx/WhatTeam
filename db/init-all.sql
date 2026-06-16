-- ============================================================
-- NEPM 项目一键建库脚本（自动生成）
-- 采用与后端实体匹配的 aqstest 结构（int 自增主键），并附种子数据。
-- 创建 3 个库：nepu_environment(管理端) / nepu(网格员端) / nep(监督员端)
-- 运行： bash scripts/init-db.sh   （Windows: scripts\init-db.ps1）
-- ============================================================
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS=0;

-- ========================= 数据库 nepu_environment =========================
CREATE DATABASE IF NOT EXISTS `nepu_environment` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `nepu_environment`;

-- ----------------------------
-- Table structure for admins
-- ----------------------------
DROP TABLE IF EXISTS `admins`;
CREATE TABLE `admins`  (
  `admin_id` int NOT NULL AUTO_INCREMENT COMMENT '系统管理员编号',
  `admin_code` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '系统管理员登录编码',
  `password` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '系统管理员登录密码',
  `remarks` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`admin_id`) USING BTREE,
  UNIQUE INDEX `dis_code`(`admin_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for aqi
-- ----------------------------
DROP TABLE IF EXISTS `aqi`;
CREATE TABLE `aqi`  (
  `aqi_id` int NOT NULL AUTO_INCREMENT COMMENT '空气质量指数级别(共六级)',
  `chinese_explain` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '空气质量指数级别汉字表述',
  `aqi_explain` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '空气质量指数级别描述',
  `color` varchar(7) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '空气质量指数级别表示颜色',
  `health_impact` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '对健康影响情况',
  `take_steps` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '建议采取的措施',
  `so2_min` int NOT NULL COMMENT '本级别二氧化硫浓度最小限值',
  `so2_max` int NOT NULL COMMENT '本级别二氧化硫浓度最大限值',
  `co_min` int NOT NULL COMMENT '本级别一氧化碳浓度最小限值',
  `co_max` int NOT NULL COMMENT '本级别一氧化碳浓度最大限值',
  `spm_min` int NOT NULL COMMENT '本级别悬浮颗粒物浓度最小限值',
  `spm_max` int NOT NULL COMMENT '本级别悬浮颗粒物浓度最大限值',
  `remarks` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`aqi_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for aqi_feedback
-- ----------------------------
DROP TABLE IF EXISTS `aqi_feedback`;
CREATE TABLE `aqi_feedback`  (
  `af_id` int NOT NULL AUTO_INCREMENT COMMENT '空气质量公众监督反馈信息编号',
  `tel_id` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '所属公众监督员编号（即手机号码）',
  `province_id` int NOT NULL COMMENT '反馈信息所在省区域编号',
  `city_id` int NOT NULL COMMENT '反馈信息所在市区域编号',
  `address` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '反馈信息所在区域详细地址',
  `information` varchar(400) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '反馈信息描述',
  `estimated_grade` int NOT NULL COMMENT '反馈者对空气质量指数级别的预估等级',
  `af_date` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '反馈日期',
  `af_time` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '反馈时间',
  `gm_id` int NOT NULL DEFAULT 0 COMMENT '指派网格员编号',
  `assign_date` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '指派日期',
  `assign_time` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '指派时间',
  `state` int NOT NULL COMMENT '信息状态: 0:未指派; 1:已指派; 2:已确认',
  `remarks` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`af_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for grid_city
-- ----------------------------
DROP TABLE IF EXISTS `grid_city`;
CREATE TABLE `grid_city`  (
  `city_id` int NOT NULL AUTO_INCREMENT COMMENT '系统网格覆盖市区域编号',
  `city_name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '系统网格覆盖市区域名称',
  `province_id` int NOT NULL COMMENT '所属省区域编号',
  `remarks` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`city_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for grid_member
-- ----------------------------
DROP TABLE IF EXISTS `grid_member`;
CREATE TABLE `grid_member`  (
  `gm_id` int NOT NULL AUTO_INCREMENT COMMENT '网格员编号',
  `gm_name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '网格员名称',
  `gm_code` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '网格员登录编码',
  `password` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '格网员登录密码',
  `province_id` int NOT NULL COMMENT '网格区域：省编号',
  `city_id` int NOT NULL COMMENT '网格区域：市编号',
  `tel` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '联系电话',
  `state` int NOT NULL DEFAULT 0 COMMENT '网格员状态（0:工作状态; 1:非工作状态（由考勤系统管理）; 2:其它）',
  `remarks` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`gm_id`) USING BTREE,
  UNIQUE INDEX `gm_code`(`gm_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for grid_province
-- ----------------------------
DROP TABLE IF EXISTS `grid_province`;
CREATE TABLE `grid_province`  (
  `province_id` int NOT NULL AUTO_INCREMENT COMMENT '系统网格覆盖省区域编号',
  `province_name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '系统网格覆盖省区域名称',
  `province_abbr` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '系统网格覆盖省区域简称',
  `remarks` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`province_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for statistics
-- ----------------------------
DROP TABLE IF EXISTS `statistics`;
CREATE TABLE `statistics`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '统计信息编号',
  `province_id` int NOT NULL COMMENT '所属省区域编号',
  `city_id` int NOT NULL COMMENT '所属市区域编号',
  `address` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '反馈信息所在区域详细地址',
  `so2_value` int NOT NULL COMMENT '空气二氧化硫浓度值（单位：μg/m3）',
  `so2_level` int NOT NULL COMMENT '空气二氧化硫指数级别',
  `co_value` int NOT NULL COMMENT '空气一氧化碳浓度值（单位：μg/m3）',
  `co_level` int NOT NULL COMMENT '空气一氧化碳指数级别',
  `spm_value` int NOT NULL COMMENT '空气悬浮颗粒物浓度值（单位：μg/m3）',
  `spm_level` int NOT NULL COMMENT '空气PM2.5指数级别',
  `aqi_id` int NOT NULL COMMENT '空气质量指数级别',
  `confirm_date` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '确认日期',
  `confirm_time` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '确认时间',
  `gm_id` int NOT NULL COMMENT '所属网格员编号',
  `fd_id` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '反馈者编号（公众监督员电话号码）',
  `information` varchar(400) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '反馈信息描述',
  `remarks` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for supervisor
-- ----------------------------
DROP TABLE IF EXISTS `supervisor`;
CREATE TABLE `supervisor`  (
  `tel_id` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '公众监督员编号（即手机号码）',
  `password` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '公众监督员登录密码',
  `real_name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '公众监督员真实姓名',
  `birthday` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '公众监督员出生日期',
  `sex` int NOT NULL DEFAULT 1 COMMENT '公众监督员性别（1：男；0：女）',
  `remarks` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`tel_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ---------- 种子数据（与 aqstest 结构匹配）----------
INSERT INTO `admins` (`admin_id`,`admin_code`,`password`,`remarks`) VALUES
(1,'AD001','123456','系统管理员'),
(2,'AD002','654321','管理员二');

INSERT INTO `grid_province` (`province_id`,`province_name`,`province_abbr`,`remarks`) VALUES
(1,'北京市','京',NULL),(2,'上海市','沪',NULL),(3,'辽宁省','辽',NULL),
(4,'江苏省','苏',NULL),(5,'广东省','粤',NULL);

INSERT INTO `grid_city` (`city_id`,`city_name`,`province_id`,`remarks`) VALUES
(1,'东城区',1,NULL),(2,'朝阳区',1,NULL),(3,'浦东新区',2,NULL),
(4,'大连市',3,NULL),(5,'沈阳市',3,NULL),(6,'南京市',4,NULL),(7,'广州市',5,NULL);

-- 网格员：state=0 为可工作（登录要求 state=0）
INSERT INTO `grid_member` (`gm_id`,`gm_name`,`gm_code`,`password`,`province_id`,`city_id`,`tel`,`state`,`remarks`) VALUES
(1,'张网格','GM001','grid111',1,1,'13511112222',0,NULL),
(2,'李网格','GM002','grid222',1,2,'13522223333',0,NULL),
(3,'王网格','GM003','grid333',2,3,'13533334444',0,NULL),
(4,'赵网格','GM004','grid444',3,4,'13544445555',0,NULL),
(5,'钱网格','GM005','grid555',4,6,'13555556666',0,NULL);

INSERT INTO `aqi` (`aqi_id`,`chinese_explain`,`aqi_explain`,`color`,`health_impact`,`take_steps`,`so2_min`,`so2_max`,`co_min`,`co_max`,`spm_min`,`spm_max`,`remarks`) VALUES
(1,'优','一级','绿色','空气质量令人满意，基本无空气污染','各类人群可正常活动',0,50,0,5,0,50,NULL),
(2,'良','二级','黄色','空气质量可接受','极少数异常敏感人群应减少户外活动',50,150,5,10,50,150,NULL),
(3,'轻度污染','三级','橙色','易感人群症状有轻度加剧','儿童老人及心脏病、呼吸系统疾病患者应减少长时间户外活动',150,475,10,35,150,250,NULL),
(4,'中度污染','四级','红色','进一步加剧易感人群症状','减少户外运动',475,800,35,60,250,350,NULL),
(5,'重度污染','五级','紫色','心脏病和肺病患者症状显著加剧','停止户外活动',800,1600,60,90,350,420,NULL),
(6,'严重污染','六级','褐红色','健康人群运动耐受力降低','避免户外活动',1600,2100,90,120,420,500,NULL);

-- 反馈：state 0未指派 / 1已指派 / 2已确认
INSERT INTO `aqi_feedback` (`af_id`,`tel_id`,`province_id`,`city_id`,`address`,`information`,`estimated_grade`,`af_date`,`af_time`,`gm_id`,`assign_date`,`assign_time`,`state`,`remarks`) VALUES
(1,'13800000001',1,1,'北京市东城区某街道','空气浑浊有异味',3,'2026-06-10','09:30:00',0,NULL,NULL,0,NULL),
(2,'13800000002',1,2,'北京市朝阳区某路','雾霾严重能见度低',4,'2026-06-11','10:15:00',0,NULL,NULL,0,NULL),
(3,'13800000003',2,3,'上海市浦东新区某小区','PM2.5偏高',4,'2026-06-12','08:40:00',0,NULL,NULL,0,NULL),
(4,'13800000004',3,4,'辽宁省大连市某厂区','工厂排放刺鼻',5,'2026-06-13','07:50:00',4,'2026-06-13','09:00:00',1,NULL),
(5,'13800000005',4,6,'江苏省南京市某街','焚烧秸秆烟雾大',5,'2026-06-09','16:20:00',5,'2026-06-09','17:00:00',2,NULL);

INSERT INTO `statistics` (`id`,`province_id`,`city_id`,`address`,`so2_value`,`so2_level`,`co_value`,`co_level`,`spm_value`,`spm_level`,`aqi_id`,`confirm_date`,`confirm_time`,`gm_id`,`fd_id`,`information`,`remarks`) VALUES
(1,1,1,'北京市东城区',30,1,3,1,40,1,1,'2026-06-10','12:00:00',1,'13800000001','空气优',NULL),
(2,1,2,'北京市朝阳区',120,2,8,2,100,2,2,'2026-06-11','12:30:00',2,'13800000002','空气良',NULL),
(3,2,3,'上海市浦东新区',300,3,20,3,200,3,3,'2026-06-12','11:00:00',3,'13800000003','轻度污染',NULL),
(4,3,4,'辽宁省大连市',600,4,50,4,300,4,4,'2026-06-13','10:00:00',4,'13800000004','中度污染',NULL),
(5,4,6,'江苏省南京市',1000,5,70,5,380,5,5,'2026-06-09','18:00:00',5,'13800000005','重度污染',NULL);

INSERT INTO `supervisor` (`tel_id`,`password`,`real_name`,`birthday`,`sex`,`remarks`) VALUES
('13800000001','123456','张三','1990-05-12',1,NULL),
('13800000002','123456','李四','1992-08-20',0,NULL);

-- ========================= 数据库 nepu =========================
CREATE DATABASE IF NOT EXISTS `nepu` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `nepu`;

-- ----------------------------
-- Table structure for admins
-- ----------------------------
DROP TABLE IF EXISTS `admins`;
CREATE TABLE `admins`  (
  `admin_id` int NOT NULL AUTO_INCREMENT COMMENT '系统管理员编号',
  `admin_code` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '系统管理员登录编码',
  `password` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '系统管理员登录密码',
  `remarks` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`admin_id`) USING BTREE,
  UNIQUE INDEX `dis_code`(`admin_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for aqi
-- ----------------------------
DROP TABLE IF EXISTS `aqi`;
CREATE TABLE `aqi`  (
  `aqi_id` int NOT NULL AUTO_INCREMENT COMMENT '空气质量指数级别(共六级)',
  `chinese_explain` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '空气质量指数级别汉字表述',
  `aqi_explain` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '空气质量指数级别描述',
  `color` varchar(7) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '空气质量指数级别表示颜色',
  `health_impact` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '对健康影响情况',
  `take_steps` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '建议采取的措施',
  `so2_min` int NOT NULL COMMENT '本级别二氧化硫浓度最小限值',
  `so2_max` int NOT NULL COMMENT '本级别二氧化硫浓度最大限值',
  `co_min` int NOT NULL COMMENT '本级别一氧化碳浓度最小限值',
  `co_max` int NOT NULL COMMENT '本级别一氧化碳浓度最大限值',
  `spm_min` int NOT NULL COMMENT '本级别悬浮颗粒物浓度最小限值',
  `spm_max` int NOT NULL COMMENT '本级别悬浮颗粒物浓度最大限值',
  `remarks` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`aqi_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for aqi_feedback
-- ----------------------------
DROP TABLE IF EXISTS `aqi_feedback`;
CREATE TABLE `aqi_feedback`  (
  `af_id` int NOT NULL AUTO_INCREMENT COMMENT '空气质量公众监督反馈信息编号',
  `tel_id` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '所属公众监督员编号（即手机号码）',
  `province_id` int NOT NULL COMMENT '反馈信息所在省区域编号',
  `city_id` int NOT NULL COMMENT '反馈信息所在市区域编号',
  `address` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '反馈信息所在区域详细地址',
  `information` varchar(400) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '反馈信息描述',
  `estimated_grade` int NOT NULL COMMENT '反馈者对空气质量指数级别的预估等级',
  `af_date` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '反馈日期',
  `af_time` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '反馈时间',
  `gm_id` int NOT NULL DEFAULT 0 COMMENT '指派网格员编号',
  `assign_date` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '指派日期',
  `assign_time` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '指派时间',
  `state` int NOT NULL COMMENT '信息状态: 0:未指派; 1:已指派; 2:已确认',
  `remarks` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`af_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for grid_city
-- ----------------------------
DROP TABLE IF EXISTS `grid_city`;
CREATE TABLE `grid_city`  (
  `city_id` int NOT NULL AUTO_INCREMENT COMMENT '系统网格覆盖市区域编号',
  `city_name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '系统网格覆盖市区域名称',
  `province_id` int NOT NULL COMMENT '所属省区域编号',
  `remarks` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`city_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for grid_member
-- ----------------------------
DROP TABLE IF EXISTS `grid_member`;
CREATE TABLE `grid_member`  (
  `gm_id` int NOT NULL AUTO_INCREMENT COMMENT '网格员编号',
  `gm_name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '网格员名称',
  `gm_code` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '网格员登录编码',
  `password` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '格网员登录密码',
  `province_id` int NOT NULL COMMENT '网格区域：省编号',
  `city_id` int NOT NULL COMMENT '网格区域：市编号',
  `tel` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '联系电话',
  `state` int NOT NULL DEFAULT 0 COMMENT '网格员状态（0:工作状态; 1:非工作状态（由考勤系统管理）; 2:其它）',
  `remarks` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`gm_id`) USING BTREE,
  UNIQUE INDEX `gm_code`(`gm_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for grid_province
-- ----------------------------
DROP TABLE IF EXISTS `grid_province`;
CREATE TABLE `grid_province`  (
  `province_id` int NOT NULL AUTO_INCREMENT COMMENT '系统网格覆盖省区域编号',
  `province_name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '系统网格覆盖省区域名称',
  `province_abbr` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '系统网格覆盖省区域简称',
  `remarks` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`province_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for statistics
-- ----------------------------
DROP TABLE IF EXISTS `statistics`;
CREATE TABLE `statistics`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '统计信息编号',
  `province_id` int NOT NULL COMMENT '所属省区域编号',
  `city_id` int NOT NULL COMMENT '所属市区域编号',
  `address` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '反馈信息所在区域详细地址',
  `so2_value` int NOT NULL COMMENT '空气二氧化硫浓度值（单位：μg/m3）',
  `so2_level` int NOT NULL COMMENT '空气二氧化硫指数级别',
  `co_value` int NOT NULL COMMENT '空气一氧化碳浓度值（单位：μg/m3）',
  `co_level` int NOT NULL COMMENT '空气一氧化碳指数级别',
  `spm_value` int NOT NULL COMMENT '空气悬浮颗粒物浓度值（单位：μg/m3）',
  `spm_level` int NOT NULL COMMENT '空气PM2.5指数级别',
  `aqi_id` int NOT NULL COMMENT '空气质量指数级别',
  `confirm_date` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '确认日期',
  `confirm_time` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '确认时间',
  `gm_id` int NOT NULL COMMENT '所属网格员编号',
  `fd_id` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '反馈者编号（公众监督员电话号码）',
  `information` varchar(400) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '反馈信息描述',
  `remarks` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for supervisor
-- ----------------------------
DROP TABLE IF EXISTS `supervisor`;
CREATE TABLE `supervisor`  (
  `tel_id` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '公众监督员编号（即手机号码）',
  `password` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '公众监督员登录密码',
  `real_name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '公众监督员真实姓名',
  `birthday` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '公众监督员出生日期',
  `sex` int NOT NULL DEFAULT 1 COMMENT '公众监督员性别（1：男；0：女）',
  `remarks` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`tel_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ---------- 种子数据（与 aqstest 结构匹配）----------
INSERT INTO `admins` (`admin_id`,`admin_code`,`password`,`remarks`) VALUES
(1,'AD001','123456','系统管理员'),
(2,'AD002','654321','管理员二');

INSERT INTO `grid_province` (`province_id`,`province_name`,`province_abbr`,`remarks`) VALUES
(1,'北京市','京',NULL),(2,'上海市','沪',NULL),(3,'辽宁省','辽',NULL),
(4,'江苏省','苏',NULL),(5,'广东省','粤',NULL);

INSERT INTO `grid_city` (`city_id`,`city_name`,`province_id`,`remarks`) VALUES
(1,'东城区',1,NULL),(2,'朝阳区',1,NULL),(3,'浦东新区',2,NULL),
(4,'大连市',3,NULL),(5,'沈阳市',3,NULL),(6,'南京市',4,NULL),(7,'广州市',5,NULL);

-- 网格员：state=0 为可工作（登录要求 state=0）
INSERT INTO `grid_member` (`gm_id`,`gm_name`,`gm_code`,`password`,`province_id`,`city_id`,`tel`,`state`,`remarks`) VALUES
(1,'张网格','GM001','grid111',1,1,'13511112222',0,NULL),
(2,'李网格','GM002','grid222',1,2,'13522223333',0,NULL),
(3,'王网格','GM003','grid333',2,3,'13533334444',0,NULL),
(4,'赵网格','GM004','grid444',3,4,'13544445555',0,NULL),
(5,'钱网格','GM005','grid555',4,6,'13555556666',0,NULL);

INSERT INTO `aqi` (`aqi_id`,`chinese_explain`,`aqi_explain`,`color`,`health_impact`,`take_steps`,`so2_min`,`so2_max`,`co_min`,`co_max`,`spm_min`,`spm_max`,`remarks`) VALUES
(1,'优','一级','绿色','空气质量令人满意，基本无空气污染','各类人群可正常活动',0,50,0,5,0,50,NULL),
(2,'良','二级','黄色','空气质量可接受','极少数异常敏感人群应减少户外活动',50,150,5,10,50,150,NULL),
(3,'轻度污染','三级','橙色','易感人群症状有轻度加剧','儿童老人及心脏病、呼吸系统疾病患者应减少长时间户外活动',150,475,10,35,150,250,NULL),
(4,'中度污染','四级','红色','进一步加剧易感人群症状','减少户外运动',475,800,35,60,250,350,NULL),
(5,'重度污染','五级','紫色','心脏病和肺病患者症状显著加剧','停止户外活动',800,1600,60,90,350,420,NULL),
(6,'严重污染','六级','褐红色','健康人群运动耐受力降低','避免户外活动',1600,2100,90,120,420,500,NULL);

-- 反馈：state 0未指派 / 1已指派 / 2已确认
INSERT INTO `aqi_feedback` (`af_id`,`tel_id`,`province_id`,`city_id`,`address`,`information`,`estimated_grade`,`af_date`,`af_time`,`gm_id`,`assign_date`,`assign_time`,`state`,`remarks`) VALUES
(1,'13800000001',1,1,'北京市东城区某街道','空气浑浊有异味',3,'2026-06-10','09:30:00',0,NULL,NULL,0,NULL),
(2,'13800000002',1,2,'北京市朝阳区某路','雾霾严重能见度低',4,'2026-06-11','10:15:00',0,NULL,NULL,0,NULL),
(3,'13800000003',2,3,'上海市浦东新区某小区','PM2.5偏高',4,'2026-06-12','08:40:00',0,NULL,NULL,0,NULL),
(4,'13800000004',3,4,'辽宁省大连市某厂区','工厂排放刺鼻',5,'2026-06-13','07:50:00',4,'2026-06-13','09:00:00',1,NULL),
(5,'13800000005',4,6,'江苏省南京市某街','焚烧秸秆烟雾大',5,'2026-06-09','16:20:00',5,'2026-06-09','17:00:00',2,NULL);

INSERT INTO `statistics` (`id`,`province_id`,`city_id`,`address`,`so2_value`,`so2_level`,`co_value`,`co_level`,`spm_value`,`spm_level`,`aqi_id`,`confirm_date`,`confirm_time`,`gm_id`,`fd_id`,`information`,`remarks`) VALUES
(1,1,1,'北京市东城区',30,1,3,1,40,1,1,'2026-06-10','12:00:00',1,'13800000001','空气优',NULL),
(2,1,2,'北京市朝阳区',120,2,8,2,100,2,2,'2026-06-11','12:30:00',2,'13800000002','空气良',NULL),
(3,2,3,'上海市浦东新区',300,3,20,3,200,3,3,'2026-06-12','11:00:00',3,'13800000003','轻度污染',NULL),
(4,3,4,'辽宁省大连市',600,4,50,4,300,4,4,'2026-06-13','10:00:00',4,'13800000004','中度污染',NULL),
(5,4,6,'江苏省南京市',1000,5,70,5,380,5,5,'2026-06-09','18:00:00',5,'13800000005','重度污染',NULL);

INSERT INTO `supervisor` (`tel_id`,`password`,`real_name`,`birthday`,`sex`,`remarks`) VALUES
('13800000001','123456','张三','1990-05-12',1,NULL),
('13800000002','123456','李四','1992-08-20',0,NULL);

-- ========================= 数据库 nep =========================
CREATE DATABASE IF NOT EXISTS `nep` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `nep`;

-- ----------------------------
-- Table structure for admins
-- ----------------------------
DROP TABLE IF EXISTS `admins`;
CREATE TABLE `admins`  (
  `admin_id` int NOT NULL AUTO_INCREMENT COMMENT '系统管理员编号',
  `admin_code` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '系统管理员登录编码',
  `password` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '系统管理员登录密码',
  `remarks` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`admin_id`) USING BTREE,
  UNIQUE INDEX `dis_code`(`admin_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for aqi
-- ----------------------------
DROP TABLE IF EXISTS `aqi`;
CREATE TABLE `aqi`  (
  `aqi_id` int NOT NULL AUTO_INCREMENT COMMENT '空气质量指数级别(共六级)',
  `chinese_explain` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '空气质量指数级别汉字表述',
  `aqi_explain` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '空气质量指数级别描述',
  `color` varchar(7) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '空气质量指数级别表示颜色',
  `health_impact` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '对健康影响情况',
  `take_steps` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '建议采取的措施',
  `so2_min` int NOT NULL COMMENT '本级别二氧化硫浓度最小限值',
  `so2_max` int NOT NULL COMMENT '本级别二氧化硫浓度最大限值',
  `co_min` int NOT NULL COMMENT '本级别一氧化碳浓度最小限值',
  `co_max` int NOT NULL COMMENT '本级别一氧化碳浓度最大限值',
  `spm_min` int NOT NULL COMMENT '本级别悬浮颗粒物浓度最小限值',
  `spm_max` int NOT NULL COMMENT '本级别悬浮颗粒物浓度最大限值',
  `remarks` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`aqi_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for aqi_feedback
-- ----------------------------
DROP TABLE IF EXISTS `aqi_feedback`;
CREATE TABLE `aqi_feedback`  (
  `af_id` int NOT NULL AUTO_INCREMENT COMMENT '空气质量公众监督反馈信息编号',
  `tel_id` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '所属公众监督员编号（即手机号码）',
  `province_id` int NOT NULL COMMENT '反馈信息所在省区域编号',
  `city_id` int NOT NULL COMMENT '反馈信息所在市区域编号',
  `address` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '反馈信息所在区域详细地址',
  `information` varchar(400) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '反馈信息描述',
  `estimated_grade` int NOT NULL COMMENT '反馈者对空气质量指数级别的预估等级',
  `af_date` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '反馈日期',
  `af_time` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '反馈时间',
  `gm_id` int NOT NULL DEFAULT 0 COMMENT '指派网格员编号',
  `assign_date` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '指派日期',
  `assign_time` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '指派时间',
  `state` int NOT NULL COMMENT '信息状态: 0:未指派; 1:已指派; 2:已确认',
  `remarks` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`af_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for grid_city
-- ----------------------------
DROP TABLE IF EXISTS `grid_city`;
CREATE TABLE `grid_city`  (
  `city_id` int NOT NULL AUTO_INCREMENT COMMENT '系统网格覆盖市区域编号',
  `city_name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '系统网格覆盖市区域名称',
  `province_id` int NOT NULL COMMENT '所属省区域编号',
  `remarks` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`city_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for grid_member
-- ----------------------------
DROP TABLE IF EXISTS `grid_member`;
CREATE TABLE `grid_member`  (
  `gm_id` int NOT NULL AUTO_INCREMENT COMMENT '网格员编号',
  `gm_name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '网格员名称',
  `gm_code` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '网格员登录编码',
  `password` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '格网员登录密码',
  `province_id` int NOT NULL COMMENT '网格区域：省编号',
  `city_id` int NOT NULL COMMENT '网格区域：市编号',
  `tel` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '联系电话',
  `state` int NOT NULL DEFAULT 0 COMMENT '网格员状态（0:工作状态; 1:非工作状态（由考勤系统管理）; 2:其它）',
  `remarks` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`gm_id`) USING BTREE,
  UNIQUE INDEX `gm_code`(`gm_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for grid_province
-- ----------------------------
DROP TABLE IF EXISTS `grid_province`;
CREATE TABLE `grid_province`  (
  `province_id` int NOT NULL AUTO_INCREMENT COMMENT '系统网格覆盖省区域编号',
  `province_name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '系统网格覆盖省区域名称',
  `province_abbr` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '系统网格覆盖省区域简称',
  `remarks` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`province_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for statistics
-- ----------------------------
DROP TABLE IF EXISTS `statistics`;
CREATE TABLE `statistics`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '统计信息编号',
  `province_id` int NOT NULL COMMENT '所属省区域编号',
  `city_id` int NOT NULL COMMENT '所属市区域编号',
  `address` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '反馈信息所在区域详细地址',
  `so2_value` int NOT NULL COMMENT '空气二氧化硫浓度值（单位：μg/m3）',
  `so2_level` int NOT NULL COMMENT '空气二氧化硫指数级别',
  `co_value` int NOT NULL COMMENT '空气一氧化碳浓度值（单位：μg/m3）',
  `co_level` int NOT NULL COMMENT '空气一氧化碳指数级别',
  `spm_value` int NOT NULL COMMENT '空气悬浮颗粒物浓度值（单位：μg/m3）',
  `spm_level` int NOT NULL COMMENT '空气PM2.5指数级别',
  `aqi_id` int NOT NULL COMMENT '空气质量指数级别',
  `confirm_date` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '确认日期',
  `confirm_time` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '确认时间',
  `gm_id` int NOT NULL COMMENT '所属网格员编号',
  `fd_id` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '反馈者编号（公众监督员电话号码）',
  `information` varchar(400) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '反馈信息描述',
  `remarks` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for supervisor
-- ----------------------------
DROP TABLE IF EXISTS `supervisor`;
CREATE TABLE `supervisor`  (
  `tel_id` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '公众监督员编号（即手机号码）',
  `password` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '公众监督员登录密码',
  `real_name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '公众监督员真实姓名',
  `birthday` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '公众监督员出生日期',
  `sex` int NOT NULL DEFAULT 1 COMMENT '公众监督员性别（1：男；0：女）',
  `remarks` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`tel_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ---------- 种子数据（与 aqstest 结构匹配）----------
INSERT INTO `admins` (`admin_id`,`admin_code`,`password`,`remarks`) VALUES
(1,'AD001','123456','系统管理员'),
(2,'AD002','654321','管理员二');

INSERT INTO `grid_province` (`province_id`,`province_name`,`province_abbr`,`remarks`) VALUES
(1,'北京市','京',NULL),(2,'上海市','沪',NULL),(3,'辽宁省','辽',NULL),
(4,'江苏省','苏',NULL),(5,'广东省','粤',NULL);

INSERT INTO `grid_city` (`city_id`,`city_name`,`province_id`,`remarks`) VALUES
(1,'东城区',1,NULL),(2,'朝阳区',1,NULL),(3,'浦东新区',2,NULL),
(4,'大连市',3,NULL),(5,'沈阳市',3,NULL),(6,'南京市',4,NULL),(7,'广州市',5,NULL);

-- 网格员：state=0 为可工作（登录要求 state=0）
INSERT INTO `grid_member` (`gm_id`,`gm_name`,`gm_code`,`password`,`province_id`,`city_id`,`tel`,`state`,`remarks`) VALUES
(1,'张网格','GM001','grid111',1,1,'13511112222',0,NULL),
(2,'李网格','GM002','grid222',1,2,'13522223333',0,NULL),
(3,'王网格','GM003','grid333',2,3,'13533334444',0,NULL),
(4,'赵网格','GM004','grid444',3,4,'13544445555',0,NULL),
(5,'钱网格','GM005','grid555',4,6,'13555556666',0,NULL);

INSERT INTO `aqi` (`aqi_id`,`chinese_explain`,`aqi_explain`,`color`,`health_impact`,`take_steps`,`so2_min`,`so2_max`,`co_min`,`co_max`,`spm_min`,`spm_max`,`remarks`) VALUES
(1,'优','一级','绿色','空气质量令人满意，基本无空气污染','各类人群可正常活动',0,50,0,5,0,50,NULL),
(2,'良','二级','黄色','空气质量可接受','极少数异常敏感人群应减少户外活动',50,150,5,10,50,150,NULL),
(3,'轻度污染','三级','橙色','易感人群症状有轻度加剧','儿童老人及心脏病、呼吸系统疾病患者应减少长时间户外活动',150,475,10,35,150,250,NULL),
(4,'中度污染','四级','红色','进一步加剧易感人群症状','减少户外运动',475,800,35,60,250,350,NULL),
(5,'重度污染','五级','紫色','心脏病和肺病患者症状显著加剧','停止户外活动',800,1600,60,90,350,420,NULL),
(6,'严重污染','六级','褐红色','健康人群运动耐受力降低','避免户外活动',1600,2100,90,120,420,500,NULL);

-- 反馈：state 0未指派 / 1已指派 / 2已确认
INSERT INTO `aqi_feedback` (`af_id`,`tel_id`,`province_id`,`city_id`,`address`,`information`,`estimated_grade`,`af_date`,`af_time`,`gm_id`,`assign_date`,`assign_time`,`state`,`remarks`) VALUES
(1,'13800000001',1,1,'北京市东城区某街道','空气浑浊有异味',3,'2026-06-10','09:30:00',0,NULL,NULL,0,NULL),
(2,'13800000002',1,2,'北京市朝阳区某路','雾霾严重能见度低',4,'2026-06-11','10:15:00',0,NULL,NULL,0,NULL),
(3,'13800000003',2,3,'上海市浦东新区某小区','PM2.5偏高',4,'2026-06-12','08:40:00',0,NULL,NULL,0,NULL),
(4,'13800000004',3,4,'辽宁省大连市某厂区','工厂排放刺鼻',5,'2026-06-13','07:50:00',4,'2026-06-13','09:00:00',1,NULL),
(5,'13800000005',4,6,'江苏省南京市某街','焚烧秸秆烟雾大',5,'2026-06-09','16:20:00',5,'2026-06-09','17:00:00',2,NULL);

INSERT INTO `statistics` (`id`,`province_id`,`city_id`,`address`,`so2_value`,`so2_level`,`co_value`,`co_level`,`spm_value`,`spm_level`,`aqi_id`,`confirm_date`,`confirm_time`,`gm_id`,`fd_id`,`information`,`remarks`) VALUES
(1,1,1,'北京市东城区',30,1,3,1,40,1,1,'2026-06-10','12:00:00',1,'13800000001','空气优',NULL),
(2,1,2,'北京市朝阳区',120,2,8,2,100,2,2,'2026-06-11','12:30:00',2,'13800000002','空气良',NULL),
(3,2,3,'上海市浦东新区',300,3,20,3,200,3,3,'2026-06-12','11:00:00',3,'13800000003','轻度污染',NULL),
(4,3,4,'辽宁省大连市',600,4,50,4,300,4,4,'2026-06-13','10:00:00',4,'13800000004','中度污染',NULL),
(5,4,6,'江苏省南京市',1000,5,70,5,380,5,5,'2026-06-09','18:00:00',5,'13800000005','重度污染',NULL);

INSERT INTO `supervisor` (`tel_id`,`password`,`real_name`,`birthday`,`sex`,`remarks`) VALUES
('13800000001','123456','张三','1990-05-12',1,NULL),
('13800000002','123456','李四','1992-08-20',0,NULL);

SET FOREIGN_KEY_CHECKS=1;
