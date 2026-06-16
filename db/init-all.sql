-- ============================================================
-- NEPM 项目一键建库脚本（自动生成，请勿手改本文件头）
-- 一次性创建 3 个数据库并导入相同的 8 张表 + 种子数据：
--   nepu_environment  → AQI-SYS(管理端)
--   nepu             → networker-backend(网格员端)
--   nep              → supervisor-backend(监督员端)
-- 运行： bash scripts/init-db.sh   （或见文件尾说明）
-- ============================================================
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS=0;

-- ========== 数据库 nepu_environment ==========
CREATE DATABASE IF NOT EXISTS `nepu_environment` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `nepu_environment`;
-- MySQL dump 10.13  Distrib 5.7.22, for Win64 (x86_64)
--
-- Host: localhost    Database: nepu_environment
-- ------------------------------------------------------
-- Server version	5.5.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admins` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_code` varchar(20) DEFAULT NULL COMMENT '系统管理员登录编码',
  `password` varchar(20) DEFAULT NULL COMMENT '系统管理员登录密码',
  `remarks` varchar(100) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(4) DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='系统管理员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,'AD001','123456','系统超级管理员','2025-12-10 09:00:00','2026-06-04 03:17:12',0),(2,'AD002','654321','后台运维管理员','2025-12-10 09:10:00','2026-06-04 03:17:12',0);
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aqi`
--

DROP TABLE IF EXISTS `aqi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aqi` (
  `aqi_id` int(11) NOT NULL AUTO_INCREMENT,
  `chinese_explain` varchar(10) DEFAULT NULL COMMENT '空气质量指数级别汉字表述',
  `aqi_explain` varchar(20) DEFAULT NULL COMMENT '空气质量指数级别描述',
  `color` varchar(7) DEFAULT NULL COMMENT '空气质量指数级别表示颜色',
  `health_impact` varchar(500) DEFAULT NULL COMMENT '对健康影响情况',
  `take_steps` varchar(500) DEFAULT NULL COMMENT '建议采取的措施',
  `so2_min` int(11) DEFAULT NULL COMMENT '本级别二氧化硫浓度最小限值',
  `so2_max` int(11) DEFAULT NULL COMMENT '本级别二氧化硫浓度最大限值',
  `co_min` int(11) DEFAULT NULL COMMENT '本级别一氧化碳浓度最小限值',
  `co_max` int(11) DEFAULT NULL COMMENT '本级别一氧化碳浓度最大限值',
  `spm_min` int(11) DEFAULT NULL COMMENT '本级别悬浮颗粒物浓度最小限值',
  `spm_max` int(11) DEFAULT NULL COMMENT '本级别悬浮颗粒物浓度最大限值',
  `remarks` varchar(100) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(4) DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`aqi_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COMMENT='空气质量指数级别表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aqi`
--

LOCK TABLES `aqi` WRITE;
/*!40000 ALTER TABLE `aqi` DISABLE KEYS */;
INSERT INTO `aqi` VALUES (1,'优','一级','#00E400','空气质量令人满意，基本无空气污染','各类人群可正常活动',0,50,0,2,0,35,NULL,NULL,'0000-00-00 00:00:00',0),(2,'良','二级','#FFFF00','空气质量可接受，但某些污染物可能对极少数异常敏感人群健康有较弱影响','极少数异常敏感人群应减少户外活动',51,150,3,4,36,75,NULL,NULL,'0000-00-00 00:00:00',0),(3,'轻度污染','三级','#FF7E00','易感人群症状有轻度加剧，健康人群出现刺激症状','儿童、老年人及心脏病、呼吸系统疾病患者应减少长时间、高强度的户外锻炼',151,475,5,14,76,115,NULL,NULL,'0000-00-00 00:00:00',0),(4,'中度污染','四级','#FF0000','进一步加剧易感人群症状，可能对健康人群心脏、呼吸系统有影响','儿童、老年人及心脏病、呼吸系统疾病患者应避免长时间、高强度的户外锻炼，一般人群适量减少户外活动',476,800,15,24,116,150,NULL,NULL,'0000-00-00 00:00:00',0),(5,'重度污染','五级','#8F3F97','心脏病和肺病患者症状显著加剧，运动耐受力降低，健康人群普遍出现症状','儿童、老年人和心脏病、肺病患者应停留在室内，停止户外活动，一般人群应减少户外活动',801,1600,25,36,151,250,NULL,NULL,'0000-00-00 00:00:00',0),(6,'严重污染','六级','#7E0023','健康人群运动耐受力降低，有明显强烈症状，提前出现某些疾病','儿童、老年人和病人应当留在室内，避免体力消耗，一般人群应避免户外活动',1601,2100,37,48,251,500,NULL,NULL,'0000-00-00 00:00:00',0),(7,'优','Excellent','#00e600',NULL,NULL,0,50,0,10,0,35,NULL,NULL,'2026-06-05 02:30:57',0),(8,'良','Good','#ffff00',NULL,NULL,51,100,11,20,36,75,NULL,NULL,'2026-06-05 02:30:57',0);
/*!40000 ALTER TABLE `aqi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aqi_feedback`
--

DROP TABLE IF EXISTS `aqi_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aqi_feedback` (
  `af_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '空气质量公众监督反馈信息编号',
  `tel_id` varchar(20) DEFAULT NULL COMMENT '所属公众监督员编号（即手机号码）',
  `province_id` int(11) DEFAULT NULL COMMENT '反馈信息所在省区域编号',
  `city_id` int(11) DEFAULT NULL COMMENT '反馈信息所在市区域编号',
  `address` varchar(200) DEFAULT NULL COMMENT '反馈信息所在区域详细地址',
  `information` varchar(400) DEFAULT NULL COMMENT '反馈信息描述',
  `estimated_grade` int(11) DEFAULT NULL COMMENT '反馈者对空气质量指数级别的预估等级',
  `af_date` varchar(20) DEFAULT NULL COMMENT '反馈日期',
  `af_time` varchar(20) DEFAULT NULL COMMENT '反馈时间',
  `gm_id` int(11) DEFAULT '0' COMMENT '指派网格员编号',
  `assign_date` varchar(20) DEFAULT NULL COMMENT '指派日期',
  `assign_time` varchar(20) DEFAULT NULL COMMENT '指派时间',
  `state` int(11) DEFAULT '0' COMMENT '信息状态：0=未指派，1=已指派，2=已确认',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`af_id`),
  KEY `idx_tel_id` (`tel_id`),
  KEY `idx_province_id` (`province_id`),
  KEY `idx_city_id` (`city_id`),
  KEY `idx_gm_id` (`gm_id`),
  CONSTRAINT `aqi_feedback_ibfk_2` FOREIGN KEY (`gm_id`) REFERENCES `grid_member_old` (`gm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='空气质量公众监督反馈表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aqi_feedback`
--

LOCK TABLES `aqi_feedback` WRITE;
/*!40000 ALTER TABLE `aqi_feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `aqi_feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grid_city`
--

DROP TABLE IF EXISTS `grid_city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grid_city` (
  `city_id` int(11) NOT NULL AUTO_INCREMENT,
  `city_name` varchar(20) DEFAULT NULL COMMENT '系统网格覆盖市区域名称',
  `province_id` int(11) DEFAULT NULL COMMENT '所属省区域编号',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(4) DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`city_id`),
  KEY `province_id` (`province_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='系统网格覆盖市区域表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grid_city`
--

LOCK TABLES `grid_city` WRITE;
/*!40000 ALTER TABLE `grid_city` DISABLE KEYS */;
INSERT INTO `grid_city` VALUES (1,'北京市',1,NULL,NULL,'0000-00-00 00:00:00',0),(2,'上海市',2,NULL,NULL,'0000-00-00 00:00:00',0),(3,'重庆市',3,NULL,NULL,'0000-00-00 00:00:00',0),(4,'成都市',4,NULL,NULL,'0000-00-00 00:00:00',0),(5,'南岸区',1,NULL,'2026-06-05 10:30:57','2026-06-05 02:30:57',0),(6,'渝中区',1,NULL,'2026-06-05 10:30:57','2026-06-05 02:30:57',0);
/*!40000 ALTER TABLE `grid_city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grid_member`
--

DROP TABLE IF EXISTS `grid_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grid_member` (
  `gm_id` varchar(11) NOT NULL,
  `gm_name` varchar(20) DEFAULT NULL COMMENT '网格员名称',
  `gm_code` varchar(20) DEFAULT NULL COMMENT '网格员登录编码',
  `password` varchar(20) DEFAULT NULL COMMENT '登录密码',
  `province_id` int(11) DEFAULT NULL COMMENT '网格区域：省编号',
  `city_id` int(11) DEFAULT NULL COMMENT '网格区域：市编号',
  `tel` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `state` int(11) DEFAULT '0' COMMENT '网格员状态 0:可工作 1:临时抽调 2:休假 3:其它',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(4) DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`gm_id`),
  KEY `province_id` (`province_id`),
  KEY `city_id` (`city_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='空气质量监测网格员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grid_member`
--

LOCK TABLES `grid_member` WRITE;
/*!40000 ALTER TABLE `grid_member` DISABLE KEYS */;
INSERT INTO `grid_member` VALUES ('13511112222','王小龙','GM001','grid111',1,1,'13511112222',0,'城东网格员','2025-12-10 11:00:00','2026-06-04 03:17:29',0),('13512345678','张三','G001','123456',1,1,'13512345678',1,'南岸网格员','2026-06-05 10:30:35','2026-06-05 02:30:35',0),('13512345679','李四','G002','123456',1,2,'13512345679',1,'渝中网格员','2026-06-05 10:30:35','2026-06-05 02:30:35',0),('13522223333','刘芳芳','GM002','grid222',1,2,'13522223333',0,'城西网格员','2025-12-10 11:08:00','2026-06-04 03:17:29',0);
/*!40000 ALTER TABLE `grid_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grid_province`
--

DROP TABLE IF EXISTS `grid_province`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grid_province` (
  `province_id` int(11) NOT NULL AUTO_INCREMENT,
  `province_name` varchar(20) DEFAULT NULL COMMENT '系统网格覆盖省区域名称',
  `province_abbr` varchar(2) DEFAULT NULL COMMENT '系统网格覆盖省区域简称',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(4) DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`province_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COMMENT='系统网格覆盖省区域表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grid_province`
--

LOCK TABLES `grid_province` WRITE;
/*!40000 ALTER TABLE `grid_province` DISABLE KEYS */;
INSERT INTO `grid_province` VALUES (1,'北京市','京',NULL,NULL,'0000-00-00 00:00:00',0),(2,'上海市','沪',NULL,NULL,'0000-00-00 00:00:00',0),(3,'重庆市','渝',NULL,NULL,'0000-00-00 00:00:00',0),(4,'四川省','川',NULL,NULL,'0000-00-00 00:00:00',0),(5,'重庆市','渝',NULL,'2026-06-05 10:30:57','2026-06-05 02:30:57',0);
/*!40000 ALTER TABLE `grid_province` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statistics`
--

DROP TABLE IF EXISTS `statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statistics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gm_id` int(11) DEFAULT NULL,
  `province_id` int(11) DEFAULT NULL COMMENT '所属省编号',
  `city_id` int(11) DEFAULT NULL COMMENT '所属市编号',
  `aqi_id` int(11) DEFAULT NULL COMMENT '所属AQI级别编号',
  `so2_value` int(11) DEFAULT NULL COMMENT '实测二氧化硫浓度',
  `co_value` int(11) DEFAULT NULL COMMENT '实测一氧化碳浓度',
  `spm_value` int(11) DEFAULT NULL COMMENT '实测悬浮颗粒物浓度',
  `confirm_date` varchar(20) DEFAULT NULL,
  `confirm_time` varchar(20) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(4) DEFAULT '0' COMMENT '逻辑删除',
  `address` varchar(200) DEFAULT NULL COMMENT '反馈信息所在区域详细地址',
  `so2_level` int(11) DEFAULT NULL COMMENT '空气二氧化硫指数级别',
  `co_level` int(11) DEFAULT NULL COMMENT '空气一氧化碳指数级别',
  `spm_level` int(11) DEFAULT NULL COMMENT '空气PM2.5指数级别',
  `fd_id` varchar(20) DEFAULT NULL COMMENT '反馈者编号（公众监督员电话号码）',
  `information` varchar(400) DEFAULT NULL COMMENT '反馈信息描述',
  PRIMARY KEY (`id`),
  KEY `aqi_id` (`aqi_id`),
  KEY `gm_id` (`gm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='监测统计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statistics`
--

LOCK TABLES `statistics` WRITE;
/*!40000 ALTER TABLE `statistics` DISABLE KEYS */;
/*!40000 ALTER TABLE `statistics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supervisor`
--

DROP TABLE IF EXISTS `supervisor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supervisor` (
  `tel_id` varchar(11) NOT NULL,
  `password` varchar(20) DEFAULT NULL COMMENT '公众监督员登录密码',
  `real_name` varchar(20) DEFAULT NULL COMMENT '公众监督员真实姓名',
  `birthday` varchar(20) DEFAULT NULL COMMENT '公众监督员出生日期',
  `sex` int(11) DEFAULT '1' COMMENT '公众监督员性别(1:男;0:女)',
  `remarks` varchar(100) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(4) DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`tel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='公众监督员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supervisor`
--

LOCK TABLES `supervisor` WRITE;
/*!40000 ALTER TABLE `supervisor` DISABLE KEYS */;
INSERT INTO `supervisor` VALUES ('13800138001','sup123','张建国','1985-03-12',1,'城区督查','2025-12-10 10:00:00','2026-06-04 03:17:22',0),('13900139002','sup456','李美玲','1988-07-25',2,'郊区督查','2025-12-10 10:05:00','2026-06-04 03:17:22',0);
/*!40000 ALTER TABLE `supervisor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-05 11:26:56

-- ========== 数据库 nepu ==========
CREATE DATABASE IF NOT EXISTS `nepu` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `nepu`;
-- MySQL dump 10.13  Distrib 5.7.22, for Win64 (x86_64)
--
-- Host: localhost    Database: nepu_environment
-- ------------------------------------------------------
-- Server version	5.5.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admins` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_code` varchar(20) DEFAULT NULL COMMENT '系统管理员登录编码',
  `password` varchar(20) DEFAULT NULL COMMENT '系统管理员登录密码',
  `remarks` varchar(100) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(4) DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='系统管理员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,'AD001','123456','系统超级管理员','2025-12-10 09:00:00','2026-06-04 03:17:12',0),(2,'AD002','654321','后台运维管理员','2025-12-10 09:10:00','2026-06-04 03:17:12',0);
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aqi`
--

DROP TABLE IF EXISTS `aqi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aqi` (
  `aqi_id` int(11) NOT NULL AUTO_INCREMENT,
  `chinese_explain` varchar(10) DEFAULT NULL COMMENT '空气质量指数级别汉字表述',
  `aqi_explain` varchar(20) DEFAULT NULL COMMENT '空气质量指数级别描述',
  `color` varchar(7) DEFAULT NULL COMMENT '空气质量指数级别表示颜色',
  `health_impact` varchar(500) DEFAULT NULL COMMENT '对健康影响情况',
  `take_steps` varchar(500) DEFAULT NULL COMMENT '建议采取的措施',
  `so2_min` int(11) DEFAULT NULL COMMENT '本级别二氧化硫浓度最小限值',
  `so2_max` int(11) DEFAULT NULL COMMENT '本级别二氧化硫浓度最大限值',
  `co_min` int(11) DEFAULT NULL COMMENT '本级别一氧化碳浓度最小限值',
  `co_max` int(11) DEFAULT NULL COMMENT '本级别一氧化碳浓度最大限值',
  `spm_min` int(11) DEFAULT NULL COMMENT '本级别悬浮颗粒物浓度最小限值',
  `spm_max` int(11) DEFAULT NULL COMMENT '本级别悬浮颗粒物浓度最大限值',
  `remarks` varchar(100) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(4) DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`aqi_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COMMENT='空气质量指数级别表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aqi`
--

LOCK TABLES `aqi` WRITE;
/*!40000 ALTER TABLE `aqi` DISABLE KEYS */;
INSERT INTO `aqi` VALUES (1,'优','一级','#00E400','空气质量令人满意，基本无空气污染','各类人群可正常活动',0,50,0,2,0,35,NULL,NULL,'0000-00-00 00:00:00',0),(2,'良','二级','#FFFF00','空气质量可接受，但某些污染物可能对极少数异常敏感人群健康有较弱影响','极少数异常敏感人群应减少户外活动',51,150,3,4,36,75,NULL,NULL,'0000-00-00 00:00:00',0),(3,'轻度污染','三级','#FF7E00','易感人群症状有轻度加剧，健康人群出现刺激症状','儿童、老年人及心脏病、呼吸系统疾病患者应减少长时间、高强度的户外锻炼',151,475,5,14,76,115,NULL,NULL,'0000-00-00 00:00:00',0),(4,'中度污染','四级','#FF0000','进一步加剧易感人群症状，可能对健康人群心脏、呼吸系统有影响','儿童、老年人及心脏病、呼吸系统疾病患者应避免长时间、高强度的户外锻炼，一般人群适量减少户外活动',476,800,15,24,116,150,NULL,NULL,'0000-00-00 00:00:00',0),(5,'重度污染','五级','#8F3F97','心脏病和肺病患者症状显著加剧，运动耐受力降低，健康人群普遍出现症状','儿童、老年人和心脏病、肺病患者应停留在室内，停止户外活动，一般人群应减少户外活动',801,1600,25,36,151,250,NULL,NULL,'0000-00-00 00:00:00',0),(6,'严重污染','六级','#7E0023','健康人群运动耐受力降低，有明显强烈症状，提前出现某些疾病','儿童、老年人和病人应当留在室内，避免体力消耗，一般人群应避免户外活动',1601,2100,37,48,251,500,NULL,NULL,'0000-00-00 00:00:00',0),(7,'优','Excellent','#00e600',NULL,NULL,0,50,0,10,0,35,NULL,NULL,'2026-06-05 02:30:57',0),(8,'良','Good','#ffff00',NULL,NULL,51,100,11,20,36,75,NULL,NULL,'2026-06-05 02:30:57',0);
/*!40000 ALTER TABLE `aqi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aqi_feedback`
--

DROP TABLE IF EXISTS `aqi_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aqi_feedback` (
  `af_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '空气质量公众监督反馈信息编号',
  `tel_id` varchar(20) DEFAULT NULL COMMENT '所属公众监督员编号（即手机号码）',
  `province_id` int(11) DEFAULT NULL COMMENT '反馈信息所在省区域编号',
  `city_id` int(11) DEFAULT NULL COMMENT '反馈信息所在市区域编号',
  `address` varchar(200) DEFAULT NULL COMMENT '反馈信息所在区域详细地址',
  `information` varchar(400) DEFAULT NULL COMMENT '反馈信息描述',
  `estimated_grade` int(11) DEFAULT NULL COMMENT '反馈者对空气质量指数级别的预估等级',
  `af_date` varchar(20) DEFAULT NULL COMMENT '反馈日期',
  `af_time` varchar(20) DEFAULT NULL COMMENT '反馈时间',
  `gm_id` int(11) DEFAULT '0' COMMENT '指派网格员编号',
  `assign_date` varchar(20) DEFAULT NULL COMMENT '指派日期',
  `assign_time` varchar(20) DEFAULT NULL COMMENT '指派时间',
  `state` int(11) DEFAULT '0' COMMENT '信息状态：0=未指派，1=已指派，2=已确认',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`af_id`),
  KEY `idx_tel_id` (`tel_id`),
  KEY `idx_province_id` (`province_id`),
  KEY `idx_city_id` (`city_id`),
  KEY `idx_gm_id` (`gm_id`),
  CONSTRAINT `aqi_feedback_ibfk_2` FOREIGN KEY (`gm_id`) REFERENCES `grid_member_old` (`gm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='空气质量公众监督反馈表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aqi_feedback`
--

LOCK TABLES `aqi_feedback` WRITE;
/*!40000 ALTER TABLE `aqi_feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `aqi_feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grid_city`
--

DROP TABLE IF EXISTS `grid_city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grid_city` (
  `city_id` int(11) NOT NULL AUTO_INCREMENT,
  `city_name` varchar(20) DEFAULT NULL COMMENT '系统网格覆盖市区域名称',
  `province_id` int(11) DEFAULT NULL COMMENT '所属省区域编号',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(4) DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`city_id`),
  KEY `province_id` (`province_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='系统网格覆盖市区域表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grid_city`
--

LOCK TABLES `grid_city` WRITE;
/*!40000 ALTER TABLE `grid_city` DISABLE KEYS */;
INSERT INTO `grid_city` VALUES (1,'北京市',1,NULL,NULL,'0000-00-00 00:00:00',0),(2,'上海市',2,NULL,NULL,'0000-00-00 00:00:00',0),(3,'重庆市',3,NULL,NULL,'0000-00-00 00:00:00',0),(4,'成都市',4,NULL,NULL,'0000-00-00 00:00:00',0),(5,'南岸区',1,NULL,'2026-06-05 10:30:57','2026-06-05 02:30:57',0),(6,'渝中区',1,NULL,'2026-06-05 10:30:57','2026-06-05 02:30:57',0);
/*!40000 ALTER TABLE `grid_city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grid_member`
--

DROP TABLE IF EXISTS `grid_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grid_member` (
  `gm_id` varchar(11) NOT NULL,
  `gm_name` varchar(20) DEFAULT NULL COMMENT '网格员名称',
  `gm_code` varchar(20) DEFAULT NULL COMMENT '网格员登录编码',
  `password` varchar(20) DEFAULT NULL COMMENT '登录密码',
  `province_id` int(11) DEFAULT NULL COMMENT '网格区域：省编号',
  `city_id` int(11) DEFAULT NULL COMMENT '网格区域：市编号',
  `tel` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `state` int(11) DEFAULT '0' COMMENT '网格员状态 0:可工作 1:临时抽调 2:休假 3:其它',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(4) DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`gm_id`),
  KEY `province_id` (`province_id`),
  KEY `city_id` (`city_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='空气质量监测网格员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grid_member`
--

LOCK TABLES `grid_member` WRITE;
/*!40000 ALTER TABLE `grid_member` DISABLE KEYS */;
INSERT INTO `grid_member` VALUES ('13511112222','王小龙','GM001','grid111',1,1,'13511112222',0,'城东网格员','2025-12-10 11:00:00','2026-06-04 03:17:29',0),('13512345678','张三','G001','123456',1,1,'13512345678',1,'南岸网格员','2026-06-05 10:30:35','2026-06-05 02:30:35',0),('13512345679','李四','G002','123456',1,2,'13512345679',1,'渝中网格员','2026-06-05 10:30:35','2026-06-05 02:30:35',0),('13522223333','刘芳芳','GM002','grid222',1,2,'13522223333',0,'城西网格员','2025-12-10 11:08:00','2026-06-04 03:17:29',0);
/*!40000 ALTER TABLE `grid_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grid_province`
--

DROP TABLE IF EXISTS `grid_province`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grid_province` (
  `province_id` int(11) NOT NULL AUTO_INCREMENT,
  `province_name` varchar(20) DEFAULT NULL COMMENT '系统网格覆盖省区域名称',
  `province_abbr` varchar(2) DEFAULT NULL COMMENT '系统网格覆盖省区域简称',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(4) DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`province_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COMMENT='系统网格覆盖省区域表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grid_province`
--

LOCK TABLES `grid_province` WRITE;
/*!40000 ALTER TABLE `grid_province` DISABLE KEYS */;
INSERT INTO `grid_province` VALUES (1,'北京市','京',NULL,NULL,'0000-00-00 00:00:00',0),(2,'上海市','沪',NULL,NULL,'0000-00-00 00:00:00',0),(3,'重庆市','渝',NULL,NULL,'0000-00-00 00:00:00',0),(4,'四川省','川',NULL,NULL,'0000-00-00 00:00:00',0),(5,'重庆市','渝',NULL,'2026-06-05 10:30:57','2026-06-05 02:30:57',0);
/*!40000 ALTER TABLE `grid_province` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statistics`
--

DROP TABLE IF EXISTS `statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statistics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gm_id` int(11) DEFAULT NULL,
  `province_id` int(11) DEFAULT NULL COMMENT '所属省编号',
  `city_id` int(11) DEFAULT NULL COMMENT '所属市编号',
  `aqi_id` int(11) DEFAULT NULL COMMENT '所属AQI级别编号',
  `so2_value` int(11) DEFAULT NULL COMMENT '实测二氧化硫浓度',
  `co_value` int(11) DEFAULT NULL COMMENT '实测一氧化碳浓度',
  `spm_value` int(11) DEFAULT NULL COMMENT '实测悬浮颗粒物浓度',
  `confirm_date` varchar(20) DEFAULT NULL,
  `confirm_time` varchar(20) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(4) DEFAULT '0' COMMENT '逻辑删除',
  `address` varchar(200) DEFAULT NULL COMMENT '反馈信息所在区域详细地址',
  `so2_level` int(11) DEFAULT NULL COMMENT '空气二氧化硫指数级别',
  `co_level` int(11) DEFAULT NULL COMMENT '空气一氧化碳指数级别',
  `spm_level` int(11) DEFAULT NULL COMMENT '空气PM2.5指数级别',
  `fd_id` varchar(20) DEFAULT NULL COMMENT '反馈者编号（公众监督员电话号码）',
  `information` varchar(400) DEFAULT NULL COMMENT '反馈信息描述',
  PRIMARY KEY (`id`),
  KEY `aqi_id` (`aqi_id`),
  KEY `gm_id` (`gm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='监测统计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statistics`
--

LOCK TABLES `statistics` WRITE;
/*!40000 ALTER TABLE `statistics` DISABLE KEYS */;
/*!40000 ALTER TABLE `statistics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supervisor`
--

DROP TABLE IF EXISTS `supervisor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supervisor` (
  `tel_id` varchar(11) NOT NULL,
  `password` varchar(20) DEFAULT NULL COMMENT '公众监督员登录密码',
  `real_name` varchar(20) DEFAULT NULL COMMENT '公众监督员真实姓名',
  `birthday` varchar(20) DEFAULT NULL COMMENT '公众监督员出生日期',
  `sex` int(11) DEFAULT '1' COMMENT '公众监督员性别(1:男;0:女)',
  `remarks` varchar(100) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(4) DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`tel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='公众监督员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supervisor`
--

LOCK TABLES `supervisor` WRITE;
/*!40000 ALTER TABLE `supervisor` DISABLE KEYS */;
INSERT INTO `supervisor` VALUES ('13800138001','sup123','张建国','1985-03-12',1,'城区督查','2025-12-10 10:00:00','2026-06-04 03:17:22',0),('13900139002','sup456','李美玲','1988-07-25',2,'郊区督查','2025-12-10 10:05:00','2026-06-04 03:17:22',0);
/*!40000 ALTER TABLE `supervisor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-05 11:26:56

-- ========== 数据库 nep ==========
CREATE DATABASE IF NOT EXISTS `nep` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `nep`;
-- MySQL dump 10.13  Distrib 5.7.22, for Win64 (x86_64)
--
-- Host: localhost    Database: nepu_environment
-- ------------------------------------------------------
-- Server version	5.5.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admins` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_code` varchar(20) DEFAULT NULL COMMENT '系统管理员登录编码',
  `password` varchar(20) DEFAULT NULL COMMENT '系统管理员登录密码',
  `remarks` varchar(100) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(4) DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='系统管理员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,'AD001','123456','系统超级管理员','2025-12-10 09:00:00','2026-06-04 03:17:12',0),(2,'AD002','654321','后台运维管理员','2025-12-10 09:10:00','2026-06-04 03:17:12',0);
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aqi`
--

DROP TABLE IF EXISTS `aqi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aqi` (
  `aqi_id` int(11) NOT NULL AUTO_INCREMENT,
  `chinese_explain` varchar(10) DEFAULT NULL COMMENT '空气质量指数级别汉字表述',
  `aqi_explain` varchar(20) DEFAULT NULL COMMENT '空气质量指数级别描述',
  `color` varchar(7) DEFAULT NULL COMMENT '空气质量指数级别表示颜色',
  `health_impact` varchar(500) DEFAULT NULL COMMENT '对健康影响情况',
  `take_steps` varchar(500) DEFAULT NULL COMMENT '建议采取的措施',
  `so2_min` int(11) DEFAULT NULL COMMENT '本级别二氧化硫浓度最小限值',
  `so2_max` int(11) DEFAULT NULL COMMENT '本级别二氧化硫浓度最大限值',
  `co_min` int(11) DEFAULT NULL COMMENT '本级别一氧化碳浓度最小限值',
  `co_max` int(11) DEFAULT NULL COMMENT '本级别一氧化碳浓度最大限值',
  `spm_min` int(11) DEFAULT NULL COMMENT '本级别悬浮颗粒物浓度最小限值',
  `spm_max` int(11) DEFAULT NULL COMMENT '本级别悬浮颗粒物浓度最大限值',
  `remarks` varchar(100) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(4) DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`aqi_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COMMENT='空气质量指数级别表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aqi`
--

LOCK TABLES `aqi` WRITE;
/*!40000 ALTER TABLE `aqi` DISABLE KEYS */;
INSERT INTO `aqi` VALUES (1,'优','一级','#00E400','空气质量令人满意，基本无空气污染','各类人群可正常活动',0,50,0,2,0,35,NULL,NULL,'0000-00-00 00:00:00',0),(2,'良','二级','#FFFF00','空气质量可接受，但某些污染物可能对极少数异常敏感人群健康有较弱影响','极少数异常敏感人群应减少户外活动',51,150,3,4,36,75,NULL,NULL,'0000-00-00 00:00:00',0),(3,'轻度污染','三级','#FF7E00','易感人群症状有轻度加剧，健康人群出现刺激症状','儿童、老年人及心脏病、呼吸系统疾病患者应减少长时间、高强度的户外锻炼',151,475,5,14,76,115,NULL,NULL,'0000-00-00 00:00:00',0),(4,'中度污染','四级','#FF0000','进一步加剧易感人群症状，可能对健康人群心脏、呼吸系统有影响','儿童、老年人及心脏病、呼吸系统疾病患者应避免长时间、高强度的户外锻炼，一般人群适量减少户外活动',476,800,15,24,116,150,NULL,NULL,'0000-00-00 00:00:00',0),(5,'重度污染','五级','#8F3F97','心脏病和肺病患者症状显著加剧，运动耐受力降低，健康人群普遍出现症状','儿童、老年人和心脏病、肺病患者应停留在室内，停止户外活动，一般人群应减少户外活动',801,1600,25,36,151,250,NULL,NULL,'0000-00-00 00:00:00',0),(6,'严重污染','六级','#7E0023','健康人群运动耐受力降低，有明显强烈症状，提前出现某些疾病','儿童、老年人和病人应当留在室内，避免体力消耗，一般人群应避免户外活动',1601,2100,37,48,251,500,NULL,NULL,'0000-00-00 00:00:00',0),(7,'优','Excellent','#00e600',NULL,NULL,0,50,0,10,0,35,NULL,NULL,'2026-06-05 02:30:57',0),(8,'良','Good','#ffff00',NULL,NULL,51,100,11,20,36,75,NULL,NULL,'2026-06-05 02:30:57',0);
/*!40000 ALTER TABLE `aqi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aqi_feedback`
--

DROP TABLE IF EXISTS `aqi_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aqi_feedback` (
  `af_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '空气质量公众监督反馈信息编号',
  `tel_id` varchar(20) DEFAULT NULL COMMENT '所属公众监督员编号（即手机号码）',
  `province_id` int(11) DEFAULT NULL COMMENT '反馈信息所在省区域编号',
  `city_id` int(11) DEFAULT NULL COMMENT '反馈信息所在市区域编号',
  `address` varchar(200) DEFAULT NULL COMMENT '反馈信息所在区域详细地址',
  `information` varchar(400) DEFAULT NULL COMMENT '反馈信息描述',
  `estimated_grade` int(11) DEFAULT NULL COMMENT '反馈者对空气质量指数级别的预估等级',
  `af_date` varchar(20) DEFAULT NULL COMMENT '反馈日期',
  `af_time` varchar(20) DEFAULT NULL COMMENT '反馈时间',
  `gm_id` int(11) DEFAULT '0' COMMENT '指派网格员编号',
  `assign_date` varchar(20) DEFAULT NULL COMMENT '指派日期',
  `assign_time` varchar(20) DEFAULT NULL COMMENT '指派时间',
  `state` int(11) DEFAULT '0' COMMENT '信息状态：0=未指派，1=已指派，2=已确认',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`af_id`),
  KEY `idx_tel_id` (`tel_id`),
  KEY `idx_province_id` (`province_id`),
  KEY `idx_city_id` (`city_id`),
  KEY `idx_gm_id` (`gm_id`),
  CONSTRAINT `aqi_feedback_ibfk_2` FOREIGN KEY (`gm_id`) REFERENCES `grid_member_old` (`gm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='空气质量公众监督反馈表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aqi_feedback`
--

LOCK TABLES `aqi_feedback` WRITE;
/*!40000 ALTER TABLE `aqi_feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `aqi_feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grid_city`
--

DROP TABLE IF EXISTS `grid_city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grid_city` (
  `city_id` int(11) NOT NULL AUTO_INCREMENT,
  `city_name` varchar(20) DEFAULT NULL COMMENT '系统网格覆盖市区域名称',
  `province_id` int(11) DEFAULT NULL COMMENT '所属省区域编号',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(4) DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`city_id`),
  KEY `province_id` (`province_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='系统网格覆盖市区域表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grid_city`
--

LOCK TABLES `grid_city` WRITE;
/*!40000 ALTER TABLE `grid_city` DISABLE KEYS */;
INSERT INTO `grid_city` VALUES (1,'北京市',1,NULL,NULL,'0000-00-00 00:00:00',0),(2,'上海市',2,NULL,NULL,'0000-00-00 00:00:00',0),(3,'重庆市',3,NULL,NULL,'0000-00-00 00:00:00',0),(4,'成都市',4,NULL,NULL,'0000-00-00 00:00:00',0),(5,'南岸区',1,NULL,'2026-06-05 10:30:57','2026-06-05 02:30:57',0),(6,'渝中区',1,NULL,'2026-06-05 10:30:57','2026-06-05 02:30:57',0);
/*!40000 ALTER TABLE `grid_city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grid_member`
--

DROP TABLE IF EXISTS `grid_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grid_member` (
  `gm_id` varchar(11) NOT NULL,
  `gm_name` varchar(20) DEFAULT NULL COMMENT '网格员名称',
  `gm_code` varchar(20) DEFAULT NULL COMMENT '网格员登录编码',
  `password` varchar(20) DEFAULT NULL COMMENT '登录密码',
  `province_id` int(11) DEFAULT NULL COMMENT '网格区域：省编号',
  `city_id` int(11) DEFAULT NULL COMMENT '网格区域：市编号',
  `tel` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `state` int(11) DEFAULT '0' COMMENT '网格员状态 0:可工作 1:临时抽调 2:休假 3:其它',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(4) DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`gm_id`),
  KEY `province_id` (`province_id`),
  KEY `city_id` (`city_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='空气质量监测网格员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grid_member`
--

LOCK TABLES `grid_member` WRITE;
/*!40000 ALTER TABLE `grid_member` DISABLE KEYS */;
INSERT INTO `grid_member` VALUES ('13511112222','王小龙','GM001','grid111',1,1,'13511112222',0,'城东网格员','2025-12-10 11:00:00','2026-06-04 03:17:29',0),('13512345678','张三','G001','123456',1,1,'13512345678',1,'南岸网格员','2026-06-05 10:30:35','2026-06-05 02:30:35',0),('13512345679','李四','G002','123456',1,2,'13512345679',1,'渝中网格员','2026-06-05 10:30:35','2026-06-05 02:30:35',0),('13522223333','刘芳芳','GM002','grid222',1,2,'13522223333',0,'城西网格员','2025-12-10 11:08:00','2026-06-04 03:17:29',0);
/*!40000 ALTER TABLE `grid_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grid_province`
--

DROP TABLE IF EXISTS `grid_province`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grid_province` (
  `province_id` int(11) NOT NULL AUTO_INCREMENT,
  `province_name` varchar(20) DEFAULT NULL COMMENT '系统网格覆盖省区域名称',
  `province_abbr` varchar(2) DEFAULT NULL COMMENT '系统网格覆盖省区域简称',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(4) DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`province_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COMMENT='系统网格覆盖省区域表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grid_province`
--

LOCK TABLES `grid_province` WRITE;
/*!40000 ALTER TABLE `grid_province` DISABLE KEYS */;
INSERT INTO `grid_province` VALUES (1,'北京市','京',NULL,NULL,'0000-00-00 00:00:00',0),(2,'上海市','沪',NULL,NULL,'0000-00-00 00:00:00',0),(3,'重庆市','渝',NULL,NULL,'0000-00-00 00:00:00',0),(4,'四川省','川',NULL,NULL,'0000-00-00 00:00:00',0),(5,'重庆市','渝',NULL,'2026-06-05 10:30:57','2026-06-05 02:30:57',0);
/*!40000 ALTER TABLE `grid_province` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statistics`
--

DROP TABLE IF EXISTS `statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statistics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gm_id` int(11) DEFAULT NULL,
  `province_id` int(11) DEFAULT NULL COMMENT '所属省编号',
  `city_id` int(11) DEFAULT NULL COMMENT '所属市编号',
  `aqi_id` int(11) DEFAULT NULL COMMENT '所属AQI级别编号',
  `so2_value` int(11) DEFAULT NULL COMMENT '实测二氧化硫浓度',
  `co_value` int(11) DEFAULT NULL COMMENT '实测一氧化碳浓度',
  `spm_value` int(11) DEFAULT NULL COMMENT '实测悬浮颗粒物浓度',
  `confirm_date` varchar(20) DEFAULT NULL,
  `confirm_time` varchar(20) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(4) DEFAULT '0' COMMENT '逻辑删除',
  `address` varchar(200) DEFAULT NULL COMMENT '反馈信息所在区域详细地址',
  `so2_level` int(11) DEFAULT NULL COMMENT '空气二氧化硫指数级别',
  `co_level` int(11) DEFAULT NULL COMMENT '空气一氧化碳指数级别',
  `spm_level` int(11) DEFAULT NULL COMMENT '空气PM2.5指数级别',
  `fd_id` varchar(20) DEFAULT NULL COMMENT '反馈者编号（公众监督员电话号码）',
  `information` varchar(400) DEFAULT NULL COMMENT '反馈信息描述',
  PRIMARY KEY (`id`),
  KEY `aqi_id` (`aqi_id`),
  KEY `gm_id` (`gm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='监测统计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statistics`
--

LOCK TABLES `statistics` WRITE;
/*!40000 ALTER TABLE `statistics` DISABLE KEYS */;
/*!40000 ALTER TABLE `statistics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supervisor`
--

DROP TABLE IF EXISTS `supervisor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supervisor` (
  `tel_id` varchar(11) NOT NULL,
  `password` varchar(20) DEFAULT NULL COMMENT '公众监督员登录密码',
  `real_name` varchar(20) DEFAULT NULL COMMENT '公众监督员真实姓名',
  `birthday` varchar(20) DEFAULT NULL COMMENT '公众监督员出生日期',
  `sex` int(11) DEFAULT '1' COMMENT '公众监督员性别(1:男;0:女)',
  `remarks` varchar(100) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(4) DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`tel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='公众监督员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supervisor`
--

LOCK TABLES `supervisor` WRITE;
/*!40000 ALTER TABLE `supervisor` DISABLE KEYS */;
INSERT INTO `supervisor` VALUES ('13800138001','sup123','张建国','1985-03-12',1,'城区督查','2025-12-10 10:00:00','2026-06-04 03:17:22',0),('13900139002','sup456','李美玲','1988-07-25',2,'郊区督查','2025-12-10 10:05:00','2026-06-04 03:17:22',0);
/*!40000 ALTER TABLE `supervisor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-05 11:26:56

SET FOREIGN_KEY_CHECKS=1;
-- 运行方式：
--   Docker:  docker exec -i mysql mysql -uroot -proot < db/init-all.sql
--   本地CLI: mysql -uroot -p < db/init-all.sql
