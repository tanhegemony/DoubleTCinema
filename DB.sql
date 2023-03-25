-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: double_t_cinema
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accountbanking`
--

DROP TABLE IF EXISTS `accountbanking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accountbanking` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `balance` double NOT NULL,
  `card_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_vi_0900_ai_ci DEFAULT NULL,
  `card_number` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_vi_0900_ai_ci DEFAULT NULL,
  `cvv_code` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_vi_0900_ai_ci DEFAULT NULL,
  `email_banking` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_vi_0900_ai_ci DEFAULT NULL,
  `month_expiry_date` int DEFAULT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_vi_0900_ai_ci DEFAULT NULL,
  `year_expiry_date` int DEFAULT NULL,
  `customerId` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_ndit38ps6obtsd0y8i2nu1knx` (`email_banking`),
  KEY `FKc4qkuff3w1wd6a5omvt4eukwo` (`customerId`),
  CONSTRAINT `FKc4qkuff3w1wd6a5omvt4eukwo` FOREIGN KEY (`customerId`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vi_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accountbanking`
--

LOCK TABLES `accountbanking` WRITE;
/*!40000 ALTER TABLE `accountbanking` DISABLE KEYS */;
INSERT INTO `accountbanking` VALUES (4,102400000,'Hồ Ngọc Tấn','150706102002','157','ngoctan10a2@gmail.com',10,'ACTIVE',25,2);
/*!40000 ALTER TABLE `accountbanking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_date` datetime DEFAULT NULL,
  `image_account` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_vi_0900_ai_ci DEFAULT NULL,
  `is_lock` bit(1) DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_vi_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vi_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (3,'2022-12-21 21:36:53','042622_Elipse_Knight_Sejuani_Splash.jpg',_binary '\0','$2a$10$sC3MCAFTpY52uv79vZFII.EfK.DlpbJntSNivtMyGVa5n0h2Cc/6K'),(4,'2022-12-24 15:20:25','042622_Eclipse_Knight_Sivir_Splash.jpg',_binary '\0','$2a$10$VR6pDGeE7f76KRyWlJoqZurSPXfyaa0lai3dBa.sT9QCj5VfcRgvG');
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `booking_date` datetime DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `discount` double NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `subtotal` double NOT NULL,
  `customerId` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKatd41pjbssun9nweynw14f7u2` (`customerId`),
  CONSTRAINT `FKatd41pjbssun9nweynw14f7u2` FOREIGN KEY (`customerId`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES (1,'2023-03-11 18:10:50','TANSTRAWBERRY',25000,'hay đấy','Completed',310000,2),(2,'2023-03-10 20:15:24',NULL,0,'','Completed',185000,2),(3,'2023-03-11 09:12:47',NULL,0,'','Completed',120000,2),(4,'2023-03-11 18:19:01',NULL,0,'','Completed',140000,2);
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_detail`
--

DROP TABLE IF EXISTS `booking_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity_ticket` int DEFAULT NULL,
  `show_date` date DEFAULT NULL,
  `show_time` time DEFAULT NULL,
  `totalPriceFood` double NOT NULL,
  `totalPriceTicket` double NOT NULL,
  `bookingId` bigint DEFAULT NULL,
  `cinemaId` bigint DEFAULT NULL,
  `cinemaRoomId` bigint DEFAULT NULL,
  `movieId` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK4chb9kla2dlpdtrt296h2sbb1` (`bookingId`),
  KEY `FKgw1pcbjgqp5wltho9fducshtx` (`cinemaId`),
  KEY `FKrgjwmayomceenigk245nuvlqu` (`cinemaRoomId`),
  KEY `FKoeq3eycxx3gkg1apmdrfht7j4` (`movieId`),
  CONSTRAINT `FK4chb9kla2dlpdtrt296h2sbb1` FOREIGN KEY (`bookingId`) REFERENCES `booking` (`id`),
  CONSTRAINT `FKgw1pcbjgqp5wltho9fducshtx` FOREIGN KEY (`cinemaId`) REFERENCES `cinema` (`id`),
  CONSTRAINT `FKoeq3eycxx3gkg1apmdrfht7j4` FOREIGN KEY (`movieId`) REFERENCES `movies` (`id`),
  CONSTRAINT `FKrgjwmayomceenigk245nuvlqu` FOREIGN KEY (`cinemaRoomId`) REFERENCES `cinema_room` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_detail`
--

LOCK TABLES `booking_detail` WRITE;
/*!40000 ALTER TABLE `booking_detail` DISABLE KEYS */;
INSERT INTO `booking_detail` VALUES (1,2,'2023-03-10','21:30:00',215000,120000,1,2,2,1),(2,2,'2023-03-11','22:18:00',65000,120000,2,1,1,8),(3,2,'2023-03-11','15:00:00',0,120000,3,1,1,1),(4,2,'2023-03-11','21:15:00',20000,120000,4,3,3,3);
/*!40000 ALTER TABLE `booking_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_food`
--

DROP TABLE IF EXISTS `booking_food`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_food` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity_food` int DEFAULT NULL,
  `bookingId` bigint DEFAULT NULL,
  `foodId` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK6h1960g3m7kfrkvp5pxys5uju` (`bookingId`),
  KEY `FKte7sagugpyo2fpw5kwetx57n3` (`foodId`),
  CONSTRAINT `FK6h1960g3m7kfrkvp5pxys5uju` FOREIGN KEY (`bookingId`) REFERENCES `booking` (`id`),
  CONSTRAINT `FKte7sagugpyo2fpw5kwetx57n3` FOREIGN KEY (`foodId`) REFERENCES `food` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_food`
--

LOCK TABLES `booking_food` WRITE;
/*!40000 ALTER TABLE `booking_food` DISABLE KEYS */;
INSERT INTO `booking_food` VALUES (1,1,1,1),(2,1,1,2),(3,1,2,1),(4,2,1,2),(5,1,4,3);
/*!40000 ALTER TABLE `booking_food` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_seat`
--

DROP TABLE IF EXISTS `booking_seat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_seat` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `seat_number` varchar(50) DEFAULT NULL,
  `bookingId` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKag05rrxgmkhj3jilx3q3ck52j` (`bookingId`),
  CONSTRAINT `FKag05rrxgmkhj3jilx3q3ck52j` FOREIGN KEY (`bookingId`) REFERENCES `booking` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_seat`
--

LOCK TABLES `booking_seat` WRITE;
/*!40000 ALTER TABLE `booking_seat` DISABLE KEYS */;
INSERT INTO `booking_seat` VALUES (1,'A1',1),(2,'A2',1),(3,'A1',2),(4,'A2',2),(5,'A3',3),(6,'A4',3),(7,'A1',4),(8,'A2',4);
/*!40000 ALTER TABLE `booking_seat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_ticket`
--

DROP TABLE IF EXISTS `booking_ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_ticket` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity_ticket` int DEFAULT NULL,
  `bookingId` bigint DEFAULT NULL,
  `ticketId` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK4us08j01b27s2930imih1j6lw` (`bookingId`),
  KEY `FK4555a3edt3m8s2hbml78a8at5` (`ticketId`),
  CONSTRAINT `FK4555a3edt3m8s2hbml78a8at5` FOREIGN KEY (`ticketId`) REFERENCES `tickets` (`id`),
  CONSTRAINT `FK4us08j01b27s2930imih1j6lw` FOREIGN KEY (`bookingId`) REFERENCES `booking` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_ticket`
--

LOCK TABLES `booking_ticket` WRITE;
/*!40000 ALTER TABLE `booking_ticket` DISABLE KEYS */;
INSERT INTO `booking_ticket` VALUES (1,1,1,1),(2,1,1,2),(3,1,2,1),(4,1,2,2),(5,1,3,1),(6,1,3,2),(7,1,4,3);
/*!40000 ALTER TABLE `booking_ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_lroeo5fvfdeg4hpicn4lw7x9b` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Cao bồi'),(2,'Chiến tranh'),(3,'Gia đình'),(4,'Giả tưởng'),(5,'Hài'),(6,'Hành động'),(7,'Hình sự'),(8,'Hoạt hình'),(9,'Kinh dị '),(10,'Lãng mạn'),(11,'Lịch sử'),(12,'Ly kì'),(13,'Nhạc kịch'),(14,'Phiêu lưu'),(15,'Tài liệu'),(16,'Tâm lý'),(17,'Thần thoại'),(18,'Thể thao'),(19,'Tiểu sử'),(20,'Tình cảm'),(21,'Tội phạm');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cinema`
--

DROP TABLE IF EXISTS `cinema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cinema` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name_cinema` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `cinema_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `google_map` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_ddu6sv17c7x5qgr9xkhg68ps4` (`name_cinema`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cinema`
--

LOCK TABLES `cinema` WRITE;
/*!40000 ALTER TABLE `cinema` DISABLE KEYS */;
INSERT INTO `cinema` VALUES (1,'DoubleT Huế','Tô Hiệu, Hương Văn Hương Trà, Thừa Thiên Huế','https://goo.gl/maps/P5peajLsNPAbaxSw8'),(2,'DoubleT Quảng Nam','An Mỹ, Tam Kì, Quảng Nam','https://goo.gl/maps/QyCwhYw4yvbnjhf99'),(3,'DoubleT Đà Nẵng','92 Quang Trung, Thạch Thang, Hải Châu, Đà Nẵng','https://goo.gl/maps/R4Qg624ewGjsCJRS9'),(10,'DoubleT Hà Nội','Thủ đô Hà Nội','https://goo.gl/maps/1234565AS');
/*!40000 ALTER TABLE `cinema` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cinema_movie`
--

DROP TABLE IF EXISTS `cinema_movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cinema_movie` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `show_date` date DEFAULT NULL,
  `show_time` time DEFAULT NULL,
  `cinemaId` bigint DEFAULT NULL,
  `movieId` bigint DEFAULT NULL,
  `cinemaRoomId` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKiu9nppsip23dqv8i1apmbrsot` (`cinemaId`),
  KEY `FKaugsxxus9m3mud63ce2wxv58h` (`movieId`),
  KEY `FK32b9ixj0re1mj42hx3w4jngj7` (`cinemaRoomId`),
  CONSTRAINT `FK32b9ixj0re1mj42hx3w4jngj7` FOREIGN KEY (`cinemaRoomId`) REFERENCES `cinema_room` (`id`),
  CONSTRAINT `FKaugsxxus9m3mud63ce2wxv58h` FOREIGN KEY (`movieId`) REFERENCES `movies` (`id`),
  CONSTRAINT `FKiu9nppsip23dqv8i1apmbrsot` FOREIGN KEY (`cinemaId`) REFERENCES `cinema` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cinema_movie`
--

LOCK TABLES `cinema_movie` WRITE;
/*!40000 ALTER TABLE `cinema_movie` DISABLE KEYS */;
INSERT INTO `cinema_movie` VALUES (1,'2023-03-11','15:00:00',1,1,1),(2,'2023-03-11','18:30:00',1,1,2),(3,'2023-03-11','19:00:00',1,1,3),(4,'2023-03-11','21:30:00',1,1,4),(5,'2023-03-10','18:30:00',2,1,1),(6,'2023-03-10','21:30:00',2,1,2),(7,'2023-03-10','19:00:00',3,1,3),(8,'2023-03-11','21:30:00',1,1,4),(9,'2023-03-11','18:30:00',2,1,1),(10,'2023-03-11','19:00:00',3,1,2),(11,'2023-03-10','10:00:00',1,2,3),(12,'2023-03-10','22:45:00',1,2,4),(13,'2023-03-10','10:00:00',2,2,1),(14,'2023-03-10','22:45:00',3,2,2),(15,'2023-03-10','19:30:00',1,2,3),(16,'2023-03-11','19:45:00',2,2,4),(17,'2023-03-11','20:15:00',3,2,1),(18,'2023-03-10','21:00:00',1,3,2),(19,'2023-03-10','16:00:00',2,3,3),(20,'2023-03-10','17:45:00',3,3,4),(21,'2023-03-11','17:15:00',1,3,1),(22,'2023-03-11','16:00:00',2,3,2),(23,'2023-03-11','21:15:00',3,3,3),(31,'2023-03-10','20:45:00',3,1,2),(32,'2023-03-10','22:30:00',2,2,2),(34,'2023-03-10','18:08:27',1,8,1),(37,'2023-03-10','22:21:50',1,8,1),(39,'2023-03-10','22:48:00',1,8,1),(43,'2023-03-10','23:30:00',1,5,1),(44,'2023-03-11','22:20:00',1,8,1),(46,'2023-03-11','05:36:00',2,7,3),(47,'2023-03-11','22:51:00',2,2,3),(51,'2023-03-11','20:56:00',2,8,24),(52,'2023-03-17','23:59:00',1,1,1),(55,'2023-03-16','19:42:00',1,11,1),(56,'2023-03-16','19:43:00',1,9,2);
/*!40000 ALTER TABLE `cinema_movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cinema_room`
--

DROP TABLE IF EXISTS `cinema_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cinema_room` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cinema_room_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `column_cinema_room` int DEFAULT NULL,
  `row_cinema_room` int DEFAULT NULL,
  `cinemaId` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKk8t2pw38t5jm0fxcgy0a1u67a` (`cinemaId`),
  CONSTRAINT `FKk8t2pw38t5jm0fxcgy0a1u67a` FOREIGN KEY (`cinemaId`) REFERENCES `cinema` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cinema_room`
--

LOCK TABLES `cinema_room` WRITE;
/*!40000 ALTER TABLE `cinema_room` DISABLE KEYS */;
INSERT INTO `cinema_room` VALUES (1,'RAP1',5,3,1),(2,'RAP2',4,3,1),(3,'RAP3',4,2,2),(4,'RAP4',5,4,1),(24,'RAP5',2,2,2),(25,'RAP6',10,10,3),(26,'RAP7',10,10,3),(27,'RAP8',1,1,2),(90,'RAP10',2,2,1),(93,'RAP1',1,1,10);
/*!40000 ALTER TABLE `cinema_room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `birth_date` date NOT NULL,
  `customer_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_vi_0900_ai_ci DEFAULT NULL,
  `customer_email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_vi_0900_ai_ci NOT NULL,
  `customer_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_vi_0900_ai_ci NOT NULL,
  `customer_phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_vi_0900_ai_ci NOT NULL,
  `gender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_vi_0900_ai_ci DEFAULT NULL,
  `accountId` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_qy5hqprdvx8o3dcidcfmf17x4` (`customer_email`),
  UNIQUE KEY `UK_bra9q3obra9jr8f2msuedomen` (`customer_phone`),
  KEY `FKg2u2dub1cak6b020214886w4n` (`accountId`),
  CONSTRAINT `FKg2u2dub1cak6b020214886w4n` FOREIGN KEY (`accountId`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vi_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (2,'2002-10-06','Huế','ngoctan10a2@gmail.com','Hồ Ngọc Tấn','0376160960','MALE',3),(3,'2022-12-23',NULL,'tanhegemony02@gmail.com','Huỳnh Thị Ngọc Huệ','0276160960','MALE',4);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food`
--

DROP TABLE IF EXISTS `food`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `food` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name_food` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `price_food` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_4pxhcmm2n3ttnfpg1ghmd2eik` (`name_food`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food`
--

LOCK TABLES `food` WRITE;
/*!40000 ALTER TABLE `food` DISABLE KEYS */;
INSERT INTO `food` VALUES (1,'Combo nước + bắp',65000),(2,'Bắp',50000),(3,'Nước',20000);
/*!40000 ALTER TABLE `food` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoices` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `accountBankingEmail` varchar(255) DEFAULT NULL,
  `accountBankingName` varchar(255) DEFAULT NULL,
  `amount` double NOT NULL,
  `invoice_date` datetime DEFAULT NULL,
  `payment_type` varchar(255) DEFAULT NULL,
  `staff_name` varchar(255) DEFAULT NULL,
  `staff_phone` varchar(255) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `bookingId` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKg2c0ligjoja7o777dywctnocn` (`bookingId`),
  CONSTRAINT `FKg2c0ligjoja7o777dywctnocn` FOREIGN KEY (`bookingId`) REFERENCES `booking` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices`
--

LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
INSERT INTO `invoices` VALUES (1,'ngoctan10a2@gmail.com','Hồ Ngọc Tấn',310000,'2023-03-11 18:10:50','DIRECT','Hồ Ngọc Tấn','0376160960','PAYMENT_DONE',1),(2,'ngoctan10a2@gmail.com','Hồ Ngọc Tấn',185000,'2023-03-10 20:15:24','DIRECT','Hồ Ngọc Tấn','0376160960','VIEWED',2),(3,'ngoctan10a2@gmail.com','Hồ Ngọc Tấn',120000,'2023-03-11 09:12:47','DIRECT','Hồ Ngọc Tấn','0376160960','VIEWED',3),(4,'ngoctan10a2@gmail.com','Hồ Ngọc Tấn',140000,'2023-02-11 18:19:01','DIRECT','Hồ Ngọc Tấn','0376160960','PAYMENT_DONE',4);
/*!40000 ALTER TABLE `invoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `like_review_movie`
--

DROP TABLE IF EXISTS `like_review_movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `like_review_movie` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `like_date` date DEFAULT NULL,
  `accountId` bigint DEFAULT NULL,
  `reviewId` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK30k4g9572rtjrwfxppm9uqg6u` (`accountId`),
  KEY `FK1n3a8g43cx0hts3dl817quvqs` (`reviewId`),
  CONSTRAINT `FK1n3a8g43cx0hts3dl817quvqs` FOREIGN KEY (`reviewId`) REFERENCES `review` (`id`),
  CONSTRAINT `FK30k4g9572rtjrwfxppm9uqg6u` FOREIGN KEY (`accountId`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vi_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `like_review_movie`
--

LOCK TABLES `like_review_movie` WRITE;
/*!40000 ALTER TABLE `like_review_movie` DISABLE KEYS */;
INSERT INTO `like_review_movie` VALUES (1,'2023-02-01',3,1),(2,'2023-02-03',3,4);
/*!40000 ALTER TABLE `like_review_movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie_category`
--

DROP TABLE IF EXISTS `movie_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `categoryId` bigint DEFAULT NULL,
  `movieId` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKny5ckxw6rc8gxjk4cgs3cww9x` (`categoryId`),
  KEY `FK2ypub9fip1he459dbrjpir6go` (`movieId`),
  CONSTRAINT `FK2ypub9fip1he459dbrjpir6go` FOREIGN KEY (`movieId`) REFERENCES `movies` (`id`),
  CONSTRAINT `FKny5ckxw6rc8gxjk4cgs3cww9x` FOREIGN KEY (`categoryId`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie_category`
--

LOCK TABLES `movie_category` WRITE;
/*!40000 ALTER TABLE `movie_category` DISABLE KEYS */;
INSERT INTO `movie_category` VALUES (1,6,1),(2,8,2),(3,8,3),(4,5,4),(5,20,4),(6,20,5),(7,10,5),(8,20,6),(9,8,7),(10,5,8),(11,16,8),(12,16,9),(13,6,10),(14,4,10),(15,6,11),(16,4,11),(17,14,11),(18,5,12),(19,8,12),(20,14,12),(37,1,38),(38,12,38),(39,13,38),(40,14,38),(41,5,39),(42,6,40),(43,4,41),(44,8,41),(45,14,41),(46,6,42);
/*!40000 ALTER TABLE `movie_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movies`
--

DROP TABLE IF EXISTS `movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movies` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cast` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `description` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `director` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `duration` int DEFAULT NULL,
  `film_item` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `image_movie` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `name_by_english` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `name_by_vietnam` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `nation` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `premiere` date DEFAULT NULL,
  `producer` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `trailer` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `viewedNumber` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_n2qjyekegs1hsyoq0aawp554m` (`name_by_english`),
  UNIQUE KEY `UK_4vrdaujyvmytderk6bi7phtge` (`name_by_vietnam`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movies`
--

LOCK TABLES `movies` WRITE;
/*!40000 ALTER TABLE `movies` DISABLE KEYS */;
INSERT INTO `movies` VALUES (1,'Chris Hemsworth, Natalie Portman, Tessa Thompson, Chris Pratt, Dave Bautista, Karen Gillan, Russell Crowe, Christian Bale','Sau khi kết thúc Avengers: Endgame, chàng Thần Sấm tạm biệt bạn bè và vùng New Asgard để theo chân đội Vệ binh dải Ngân Hà phiêu lưu khắp vũ trụ.   Bộ đôi siêu anh hùng nổi bật nhất vũ trụ điện ảnh Marvel là Captain America và Iron Man chỉ có 3 phần phim riêng, chàng Thor béo ú lại được ưu ái cho ra mắt đến tận phần 4. Tuy nhiên, nguồn tin “hành lang” cho biết, đối tượng “chiếm sóng” trong phần 4 là cô người yêu cũ Janes Foster chứ chẳng phải Thần Sấm. Marvel tiếp tục giao cho Taika Waititi ngồi tiếp ghế đạo diễn. Phim vẫn có sự góp mặt của các diễn viên quen thuộc Chris Hemsworth, Natalie Portman, Tessa Thompson. “Tắc kè hoa” Christian Bale sẽ góp mặt ở vai trò phản diện. Ngoài ra, dù rằng Loki có vẻ như đã chết ở Avengers: Endgame, khán giả vẫn mong Tom Hiddleston có thể quay lại để thần Lừa một lần nữa sát cánh cùng anh trai.   Dù là kẻ đến sau, đạo diễn kiêm biên kịch Taika Waititi đã nhét đầy nét đặc trưng của mình vào franchise Thần Sấm. Tương tự những gì James Gunn làm được ở Guardians Of The Galaxy. Không Taika, không có Thor như cách vắng James Gun chẳng có Vệ Binh Dải Ngân Hà. Với tất cả thành quả ấy, dĩ nhiên, Marvel tiếp tục giao cho Taika Waititi trọng trách thực hiện Thor: Love And Thunder. Thành công mời Natalie Portman quay trở lại, Taika lôi kéo luôn Christian Bale vốn nổi tiếng chọn phim khó tính. Vốn từ chối quay trở lại dòng phim siêu anh hùng, Bale đổi ý sau khi đọc kịch bản phim mới Tình Yêu Và Sấm Sét.','Taika Waititi',118,'PHIM_DANG_CHIEU','Thor-Love-And_Thunder.jpg','Thor: Love And Thunder','Thor: Tình yêu và Sấm sét','Mỹ','2022-07-01','Marvel Studios','https://www.youtube.com/embed/PEo2LzBi4_o',15),(2,'Steve Carell, Julie Andrews','Rất lâu trước khi trở thành một phản diện chuyên nghiệp, Gru chỉ là một cậu bé 12 tuổi sống ở vùng ngoại ô vào những năm 1970, với ước mơ một ngày sẽ làm “bá chủ” thế giới. Và 3 “quả chuối” vàng biết đi từ trên trời rơi xuống đã là những đồng đội đầu tiên của Gru, bên cạnh ủng hộ cậu bé, cùng nhau thiết kế những vũ khí đầu tiên, thực hiện những phi vụ đầu tiên.','Kyle Balda, Brad Ableson, Jonathan del Val',88,'PHIM_DANG_CHIEU','Minions-The-Rise-Of-Gru.jpg','Minions: The Rise Of Gru','Minions: Sự trỗi dậy của Gru','Mỹ','2022-06-27','Illumination Entertainment','https://www.youtube.com/embed/X3ybO0kXjHE',7),(3,'Takayama Minami, Yamazaki Wakana, Hayashibara Megumi','Tại Shibuya náo nhiệt mùa Halloween, Thiếu úy Sato Miwako khoác lên mình chiếc váy cưới tinh khôi trong tiệc cưới như cổ tích, và người đàn ông bên cạnh cô không ai khác ngoài Trung sĩ Takagi Wataru. Trong giây phút trọng đại, một nhóm người xấu ập vào tấn công, Trung sĩ Takagi liều mình bảo vệ Sato. Anh tai qua nạn khỏi, nhưng Sato chết lặng khi nhìn thấy bóng ma Thần Chết trong giây phút sinh tử của Takagi. Điều này khiến cô nhớ lại cái chết của đồng nghiệp, cũng là người cô từng yêu trước đây, Thanh tra Matsuda Jinpei. Cùng lúc này, hung thủ của vụ đánh bom liên tiếp mà Matsuda điều tra năm xưa đã vượt ngục thành công. Khi Conan tìm đến Furuya Rei (hay Amuro Toru), người bạn cùng khóa với Matsuda, cậu được nghe câu chuyện liên quan đến vụ đánh bom với kẻ thủ ác mang bí danh \"Plamya\". Hôn lễ nguy hiểm nhất thế giới, buổi dạ hành đẫm máu tại Shibuya vào đêm Halloween sắp sửa bắt đầu.','Mitsunaka Susumu',111,'PHIM_DANG_CHIEU','Conan-Movie-25-Nang-dau-Halloween.jpg','Detective Conan movie 25: The bride of Halloween','Detective Conan movie 25: Nàng dâu Halloween','Nhật Bản','2022-07-21','Toho Company, Ltd.','https://www.youtube.com/embed/V6qby0eZzlA',5),(4,'Ngọc Lan Vy, August Vachiravit, Push Puttichai','Là Mây Trên Bầu Trời Của Ai Đó kể về Mây (Ngọc Lan Vy). Nhằm đánh dấu bước ngoặt lớn cho ngày sinh nhật của mình, Mây quyết định lên đường sang tận Thái Lan để gặp được thần tượng của mình - anh Park (Push Puttichai). Tuy nhiên, chuyến theo chân thần tượng của Mây lại bất ngờ rơi vào cảnh dở khóc dở cười vì đụng nhầm chàng Boy (August Vachiravit) khiến hành trình trắc trở hơn bao giờ hết.','Thanadet Pradit',89,'PHIM_DANG_CHIEU','La-may-tren-bau-troi-cua-ai-do.jpg','La may tren bau troi cua ai do','Là mây trên bầu trời của ai đó','Việt Nam','2022-07-22','Double T Studio','https://www.youtube.com/embed/yZhxNybeqCg',4),(5,'Avin Lu, Lan Thy, Hoàng Hà, Trần Lực, Bùi Lan Hương, Phạm Quỳnh Anh','Cuộc gặp gỡ định mệnh giữa Trịnh Công Sơn và nữ sinh viên Nhật Bản Michiko tại Paris năm 1990 đã mở ra một mối duyên kỳ ngộ. Từ đây bắt đầu hành trình ngược dòng thời gian, khám phá tuổi thanh xuân và tình yêu của người nhạc sĩ tài hoa với các nàng thơ Thanh Thuý, Bích Diễm, Dao Ánh, Khánh Ly, và những tình khúc mà họ lưu lại trong trái tim ông. Bộ phim lãng mạn, mở ra thế giới nhạc Trịnh quyến rũ với những mảnh ghép tình yêu đa sắc, lung linh tuyệt đẹp.','Phan Gia Nhật Linh',136,'PHIM_DANG_CHIEU','Em-Va-Trinh.jpg','Em va Trinh','Em và Trịnh','Việt Nam','2022-06-05','Double T Play','https://www.youtube.com/embed/zzik4JB9D1Q',2),(6,'Eiji Akaso, Keita Machida , Kodai Asaka, Yutaro, Takuya Kusakawa (Super Tokkyu), Rei Sato, Suzunosuke','Bản phim điện ảnh lãng mạn, ấm áp của hiện tượng gây sốt châu Á “CHERRY MAGIC: 30 TUỔI VẪN CÒN “ZIN” SẼ BIẾN THÀNH PHÙ THỦY”. Adachi là một nhân viên văn phòng, bước sang tuổi 30 và vẫn còn \"zin\". Vào sinh nhật thứ 30 của mình, anh chàng được ban tặng phép thuật kỳ lạ. Adachi có thể đọc được suy nghĩ của những người anh ta chạm vào. Kurosawa là người yêu của Adachi tại nơi làm việc, nổi tiếng và thành đạt. Họ yêu nhau bí mật tại chốn công sở. Một ngày nọ, Adachi nhận được một cơ hội việc làm mới. Adachi sẽ được làm việc mình thích nhưng địa điểm mới lại ở Nagasaki, cách Kurosawa tận 1.200 km. Trải qua những khó khăn và thử thách khi yêu xa khiến họ phải suy nghĩ lại về mối quan hệ và tương lai của mình. Mối quan hệ của họ sẽ ra sao?','Hiroki Kazama',104,'PHIM_DANG_CHIEU','Cherry-magic-30-tuoi-van-con-“ZIN”-se-bien-thanh-phu-thuy.jpg','Cherry magic!30 tuoi con zin se bien thanh phu thuy','Cherry magic!30 tuổi còn zin sẽ biến thành phù thuỷ','Nhật Bản','2022-07-15','Double T Studio','https://www.youtube.com/embed/obTrN5__BAM',1),(7,'Dwayne Johnson, Kevin Hart,  Keanu Reeves, Ben Schwartz, John Krasinski, Kate McKinnon','Sẽ ra sao khi các siêu anh hùng đình đám như Batman (Người Dơi), Superman (Siêu Nhân) hay Wonder Woman (Nữ Thần Chiến Binh) nhận nuôi thú cưng, mà đám thú cưng này lại có những siêu năng lực không tưởng? Câu trả lời sẽ có trong bộ phim hoạt hình Liên Minh Siêu Thú DC. Một ngày nọ, Superman bất ngờ bị một con chuột lang tên Lulu tấn công và khống chế bằng mảnh đá Kryptonite - điểm yếu chí mạng đối với siêu anh hùng này. Đồng thời, không rõ vì lý do gì, một mảnh đá Kryptonite màu cam rơi xuống trạm cứu hộ động vật, đem đến siêu năng lực không tưởng cho các “thành viên” nơi đây. Và khi tất cả các siêu anh hùng xuất chúng của Liên Minh Công Lý như Superman, Batman, Wonder Woman hay Flash bị bắt đi và lâm vào tình thế ngàn cân treo sợi tóc, chú cún Krypto buộc phải nhờ cậy những người bạn siêu thú mới quen cùng nhau thực hiện nhiệm vụ giải cứu lịch sử. Phim đặc biệt có sự góp giọng lồng tiếng của dàn sao đình đám như Dwayne Johnson (The Rock) - lồng tiếng cho chú chó Krypto, cây hài Kevin Hart - lồng tiếng cho chó Ace, John Krasinski - lồng tiếng cho Superman, và “John Wick” Keanu Reeves - lồng tiếng cho Batman.','Jared Stern, Sam Levine',106,'PHIM_DANG_CHIEU','DC-League-of-super-pets.jpg','DC League Of Super Pets','Liên minh siêu thú','Mỹ','2022-07-28','Warner Animation Group','https://www.youtube.com/embed/Mgxs-9WH7r0',0),(8,'Tiến Luật, Bảo Thi, Huỳnh Phương, Vân Trang','Quân là một tay chơi sát gái thượng hạng. Tuy nhiên anh phải \"giải nghệ\" đột xuất khi gánh thêm đứa con bất đắc dĩ từ người yêu cũ.','Huỳnh Đông',88,'PHIM_DANG_CHIEU','Dan-choi-khong-so-con-roi.jpg','Dan choi khong so con roi','Dân chơi không sợ con rơi','Việt Nam','2022-07-29','Lotte Entertainment','https://www.youtube.com/embed/2BOCZ5ax5qk',0),(9,'Jeon So Min, Kim Ji Young, Hong Je Yi','Ở tuổi 19, thay vì đến trường như bao bạn bè đồng trang lứa, Yoon Yeong cật lực làm thêm kiếm tiền. Khao khát một cuộc sống tốt đẹp hơn cho mình và người mẹ khiếm thính, cô đặt mục tiêu thi đỗ kỳ thi công chức lên trên hết. Trớ trêu thay, một sự cố khủng khiếp xảy ra, Yoon Yeong từ nạn nhân đáng thương trở thành kẻ giết người. Trong thời điểm tuyệt vọng và bất lực nhất, Yoon Yeong đã gặp những người chị em trong phòng giam số 12. Đằng sau mỗi người là một câu chuyện khác nhau nhưng họ đã trao nhau tình yêu thương và niềm hy vọng để cùng hướng về một tương lai tươi sáng ngoài song sắt nhà tù.','Mo Hong Jin',111,'PHIM_DANG_CHIEU','Dieu-uoc-cuoi-cung-cua-tu-nhan-2037.jpg','Dieu uoc cuoi cung cua tu nhan 2037','Điều ước cuối cùng của tù nhân 2037','Hàn Quốc','2022-07-29','CJ Entertainment','https://www.youtube.com/embed/B9wYFIlMuBk',0),(10,'Kim Woo Bin, Kim Tae Ri, So Ji Sub, Kim Eui Sung','Lấy bối cảnh thời hiện đại - năm 2022, phim kể về cuộc truy đuổi của người ngoài hành tinh Guard (Kim Woo-bin) với những tù nhân bị giam giữ trong cơ thể con người. Song song đó, vào thời Goryeo hơn 630 năm trước diễn ra cuộc tranh giành Gươm thần giữa pháp sư Muruk (Ryu Jun-yeol) và “cô gái bắn sấm sét” Ean (Kim Tae-ri) cùng hàng loạt nhân vật bí ẩn khác. Một cánh cổng thời gian mở ra kết nối hai thời đại, tạo ra một tình huống hỗn loạn chưa từng có.','Choi Dong Hoon',143,'PHIM_DANG_CHIEU','ALIENOID-Cuoc-chien-xuyen-khong.jpg','ALIENOID: Cuoc chien xuyen khong','ALIENOID: Cuộc chiến xuyên không','Hàn Quốc','2022-08-05','CJ Entertainment','https://www.youtube.com/embed/NP0aWoi8kmA',0),(11,'Sam Worthington, Zoe Saldana, Kate Winslet, Dương Tử Quỳnh','Những trích đoạn đầu tiên hé lộ diễn biến cuộc chiến tiếp theo giữa loài người và bộ tộc người Na’vi của hành tinh Pandora, vốn bắt đầu từ phần một. Hành tinh Pandora rực rỡ ở ngay phân cảnh đầu tiên. Tiếp đến, công chúa Neytiri (Zoe Saldana thủ vai) xuất hiện với đôi mắt tràn đầy cảm xúc dưới ánh nắng trong veo. Người xem được đi sâu vào khám phá hành tinh Pandora với nhiều cảnh quan đáng kinh ngạc, trong đó có dưới lòng đại dương sâu thẳm với những loài sinh vật kỳ bí, đúng như tên gọi của phần hai – The Way Of Water. ','James Cameron',0,'PHIM_DANG_CHIEU','AVATAR-Dong-chay-cua-nuoc.jpg','AVATAR: Dong chay cua nuoc','AVATAR: Dòng chảy của nước','Mỹ','2022-12-16','20th Century Studios, TSG Entertainment','https://www.youtube.com/embed/eSwZHbLB0qs',0),(12,'Antonio Banderas, Salma Hayek, Florence Pugh, Olivia Colman','Chú mèo Puss giờ đây đã không thể ngạo nghễ chu du mà chẳng màng nguy hiểm như trước nữa, bởi cậu đã mất 8 trong 9 cuộc đời mà mình có. Và với tình hình này, việc đi tìm lại “điều ước cuối cùng” nhằm khôi phục lại các mạng sống trở nên khó khăn hơn bao giờ hết. Thật may cho cậu khi vẫn còn người bạn “lợi hại” sẵn sàng đồng hành – cô mèo Kitty, và một thành viên mới gia nhập, vô cùng “nhắng nhít” và nhiệt tình. Sau khi mất đi mạng sống thứ 8, Puss được bác sĩ thú y khuyên nhủ tới nhà Mama Luna – một bà lão “nghiện” mèo chính hiệu và luôn mở cửa chào đón những chú mèo cưng mới. Dù tâm hồn cự tuyệt nhưng với tình thế gian nan hiện tại, Puss vẫn quyết định tới đó. Tại đây, anh đã gặp Perro – một chú chó trị liệu nhưng “đội lốt” mèo. Tưởng chừng mọi chuyện sẽ êm thấm, nhưng kẻ mà Puss đã từng gây thù chuốc oán vẫn tìm đến tận nơi – cô bé tóc vàng cùng gia đình gấu. Cũng từ lúc này, Perro đã biết được chú mèo nhỏ nhắn chính là Mèo Đi Hia đầy lợi hại vô cùng đáng ngưỡng mộ. Dù tẩu thoát thành công khỏi nhà Mama Luna và tránh được hội “đầu gấu” một phen, Puss đã bị truy nã treo thưởng và bị kẻ săn tiền thưởng hiểm ác Sói Xám truy đuổi. Lúc này đây là một màn “mỹ nhân cứu anh hùng” tới từ cô nàng Kitty Scott Paws. Cùng với sự hỗ trợ của Perro, chuyến phiêu lưu của bộ ba liệu có thể toàn mạng hoàn thành ?','Joel Crawford',0,'PHIM_DANG_CHIEU','Meo-di-hia-2.png','Puss in boots: The Last Wish','Mèo Đi Hia 2: Cuộc chiến cuối cùng','Mỹ','2022-12-30','DreamWorks Animation','https://www.youtube.com/embed/fovTZDDPgAQ',0),(38,'adadada','sdasdad','adadada',100,'PHIM_DANG_CHIEU','042622_Eclipse_Knight_Sivir_Splash.jpg','hahahahha','fafafafaf','adadad','2023-03-11','adadad','adadada',0),(39,'Mạc Văn Khoa, Anh Tú','Thuộc phong cách hành động – hài hước với các “cú lừa” thông minh và lầy lội đến từ bộ đôi Tú (Anh Tú) và Khoa (Mạc Văn Khoa), Siêu Lừa Gặp Siêu Lầy của đạo diễn Võ Thanh Hòa theo chân của Khoa – tên lừa đảo tầm cỡ “quốc nội” đến đảo ngọc Phú Quốc với mong muốn đổi đời. Tại đây, Khoa gặp Tú – tay lừa đảo “hàng real” và cùng Tú thực hiện các phi vụ từ nhỏ đến lớn. Cứ ngỡ sự ranh mãnh của Tú và sự may mắn trời cho của Khoa sẽ giúp họ trở thành bộ đôi bất khả chiến bại, nào ngờ lại đối mặt với nhiều tình huống dở khóc – dở cười. Nhất là khi băng nhóm của bộ đôi nhanh chóng mở rộng vì sự góp mặt của ông Năm (Nhất Trung) và bé Mã Lai (Ngọc Phước).','Võ Thanh Hòa',112,'PHIM_SAP_CHIEU','300x450_1677813440300.jpg','Sieu lua gap sieu lay','Siêu lừa gặp siêu lầy','Viet Nam','2023-03-26','89s Group','https://www.youtube.com/embed/NIVa1CCdFv4',5),(40,'Zachary Levi, Helen Mirren, Rachel Zegler, Lucy Liu','Trong lần trở lại này, cậu chàng Shazam vẫn trăn trở cho rằng mình “không xứng đáng với năng lực này”. Thế giới có The Flash nhanh như chớp với bộ suit đỏ đặc trưng, Aquaman to cao lực lưỡng và cả Batman siêu ngầu. Trong khi đó, Shazam vẫn chỉ là Shazam chẳng có năng lực gì khác biệt… hoặc là Billy Batson, một cậu nhóc trung học trong thân hình một siêu anh hùng cao to già đời, không thể kiểm soát sức mạnh của mình. Nếu như các siêu anh hùng khác khiến khán giả không khỏi trầm trồ vì những năng lực siêu phàm có thể cứu thế giới thì “cậu nhóc” Shazam, mỗi khi dùng siêu năng lực vẫn hậu đậu như một “chú hề” lừng danh khiến người xem phải bật cười.','David F. Sandberg ',130,'PHIM_DANG_CHIEU','shazam-3_1675998610941.jpg','Shazam! Fury of the GODS','Shazam! Cơn thịnh nộ của các vị thần','Mỹ','2023-03-16','Warner Bros','https://www.youtube.com/embed/KyRCmJE65ms',0),(41,'----','Sau trận chiến khốc liệt với anh em quỷ Thượng Huyền Lục Gyuutarou và Daki tại Phố Đèn Đỏ, Tanjiro cùng các kiếm sĩ diệt quỷ đều bị thương nặng và được đưa trở về trụ sở của Đội Diệt Quỷ để dưỡng thương và phục hồi. Sau trận chiến, thanh gươm của Tanjiro cũng bị hư hỏng nặng và lúc này, cậu cần một thanh gươm mới để tiếp tục lên đường làm nhiệm vụ. Cậu được đưa đến Làng Rèn Gươm, nơi phụ trách rèn vũ khí cho các kiếm sĩ của Đội Diệt Quỷ và chuẩn bị cho trận chiến mới với các thành viên mạnh nhất trong hàng Thượng Huyền của Thập Nhị Quỷ Nguyệt.','Haruo Sotozaki',110,'PHIM_SAP_CHIEU','demon-slayer-3_1678344772752.jpg','Demon Slayer: To the SWORDSMITH village','Thanh gươm diệt quỷ: Đường Đến Làng Rèn Gươm','Nhật Bản','2024-03-11','Ufotable','https://www.youtube.com/embed/yvUoQ4wE1mg',1),(42,'Paul Rudd, Michelle Pfeiffer, Evangeline Lilly, Kathryn Newton, Bill Murray, Michael Douglas','Sau thành công của Ant-Man (2015) và Ant-Man and the Wasp (2018), Marvel tiếp tục tung ra phần thứ 3 Ant-Man and the Wasp: Quantumania trong bối cảnh thế giới lượng tử. Tại đây, Scott Lang (Paul Rudd) cùng Hope van Dyne (Evangeline Lilly) sẽ phải đối đầu với tên phản diện khét tiếng Kang the Conqueror (Jonathan Majors), phản diện lớn nhất The Multiverse Saga của Vũ trụ Marvel. Bộ phim được cầm trịch bởi đạo diễn Peyton Reed, đánh dấu sự quay trở lại của nhóm anh hùng tí hon. Phim hay hứa hẹn sẽ mang đến những trận chiến vượt ngoài trí tưởng tượng và phá vỡ các định luật vật lý. Đồng thời, tác phẩm cũng sẽ đặt nền móng cho trận chiến hoành tráng tiếp theo của nhóm Avengers trong thời đại mới.','Peyton Reed',124,'PHIM_SAP_CHIEU','antman-3-2_1676601186349.jpg','Ant-Man and The Wasp : Quantumania','Người Kiến và Chiến Binh Ong : Thế giới lượng tử','Mỹ','2024-06-13','Marvel Studios','https://www.youtube.com/embed/y-xnXBXtanU',0);
/*!40000 ALTER TABLE `movies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotion`
--

DROP TABLE IF EXISTS `promotion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promotion` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_vi_0900_ai_ci DEFAULT NULL,
  `effective_date` date DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `value_promotion` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_lomfalb6gsh66ox4gy0t2g7qw` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vi_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotion`
--

LOCK TABLES `promotion` WRITE;
/*!40000 ALTER TABLE `promotion` DISABLE KEYS */;
INSERT INTO `promotion` VALUES (1,'TANHEGEMONY','2023-02-16','2023-02-19',50000),(2,'TUCHICKEN','2023-02-20','2023-03-30',25000),(3,'TUGA','2023-02-10','2023-02-17',50000),(4,'TANSTRAWBERRY','2023-02-26','2023-03-20',25000),(5,'DOUBLET','2023-03-20','2023-03-25',100000);
/*!40000 ALTER TABLE `promotion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content_review` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `like_number` int DEFAULT NULL,
  `name_review` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `view_number` int DEFAULT NULL,
  `vote` int DEFAULT NULL,
  `movieId` bigint DEFAULT NULL,
  `reviewer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_iklen0a4njn0udopxm7nwueji` (`name_review`),
  KEY `FKij17x402d214tuda7299pl8uj` (`movieId`),
  CONSTRAINT `FKij17x402d214tuda7299pl8uj` FOREIGN KEY (`movieId`) REFERENCES `movies` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,'Năm 2009, siêu phẩm Avatar của đạo diễn James Cameron ra mắt tại các rạp chiếu phim và thành công rực rỡ. Tác phẩm đưa tất cả có dịp trải nghiệm không gian điện ảnh vô cùng mới lạ. Mọi cảnh quay đều đẹp hoàn hảo và thậm chí có phần gây phấn khích quá đà với một số người, bởi thế giới trong Avatar nên thơ như cõi vĩnh hằng và đầy mê hoặc, đủ để bất cứ ai cũng mong muốn được một lần sống ở đấy. Tại tương lai xa vào năm 2154, trong hằng hà sa số những quả cầu ngoài dải ngân hà, tồn tại một hành tinh có tên gọi Pandora. Người Trái Đất đã đến đây khai thác thứ khoáng sản unobtanium. Việc làm này ảnh hưởng trực tiếp đến tộc người bản địa Na’vi đang sinh sống. Để tương tác và thuận tiện cho công việc, các nhà khoa học đã tạo nên bản thể “Avatar” có khả năng hoạt động thông qua liên kết thần kinh, “Avatar” còn được hiểu là sản phẩm lai tạo giữa người Địa Cầu và người Na’vi.James Cameron đã trao đổi với những nhà ngôn ngữ học, đồng thời sáng tạo ra ngôn ngữ Na’vi độc lập. Bên cạnh đó, ông cũng cho ra đời thế hệ máy quay chuyên dụng đặc biệt, chủ yếu dùng để ghi lại toàn bộ biểu cảm của diễn viên. Từ đây mở đường cho công nghệ motion-capture phát triển mạnh mẽ về sau. Avatar được ví như một bom tấn mang tính chất vĩ đại. Là sự đột phá của kỹ thuật làm phim, thiết lập kỷ lục phòng vé đáng ngưỡng mộ. Sau tất cả những vinh quang mà Avatar đạt được, James Cameron lên kế hoạch sản xuất bốn phim hậu truyện. ',5,'Avatar 2: Bom Tấn Thế Kỷ Tái Xuất Cùng Vin Diesel',16,4,11,'Hồ Ngọc Tấn'),(2,'Trong vũ trụ điện ảnh Marvel, chẳng nhân vật nào trải qua nhiều bi kịch như Thor Odinson. Anh mất cha, mất mẹ, bạn thân nhất bị sát hại, tự mình giết chị gái, cả đồng đội ở Asgard lẫn nhóm Avengers cũng lần lượt hi sinh. Chưa kể, hết lần này tới lần khác, Thor khóc thương cho cậu em trai Loki, chết giả lẫn chết thật. Quê nhà Asgard thân yêu tan tành, lúc tưởng đã đào thoát được thì một nửa dân số tử nạn vì Thanos. Giờ đây, những người Asgard còn sót lại lưu vong tạm bợ nơi mảnh đất nhỏ xíu trên Trái Đất. Từ bỏ lối thể hiện bi kịch siêu anh hùng có phần sến súa và nào phải điểm mạnh của nam chính Chris Hemsworth như Thor hay Thor: The Dark World, đạo diễn kiêm biên kịch Thor: Ragnarok lẫn Thor: Love And Thunder – Taika Waititi đã chọn cách kể chuyện trào phúng. Love And Thunder mở đầu khá lộn xộn khi liên tục giới thiệu ba nhân vật chính: Thor, Jane Foster và Gorr. Khán giả chứng kiến bi kịch của Gorr, biết lí do tại sao hắn trở thành Kẻ Sát Thần. Họ thương cảm cô nàng tiến sĩ tài giỏi Jane kiên trì chống chọi căn bệnh ung thư thời kì cuối. Họ gặp Thor đang cố bình ổn cõi lòng tan nát sau bao nhiêu biên cố.Cốt truyện Tình Yêu Và Sấm Sét rất đơn giản. Tuy nhiên, Taika Waititi xử lí hài hước như cách James Gunn “xử trảm” phản diện Ronan bằng điệu nhảy của nhóm Vệ Binh Dải Ngân Hà khiến Thor: Love And Thunder trở nên khó thể dự liêu. ',1,'Thor Love And Thunder: Nâng Tầm Natalie Portman Và Tiếp Tục Để Chris Hemsworth Tấu Hài?',6,3,1,'Hồ Ngọc Tấn'),(3,'Đại đa số ước mơ của con người là gì nhỉ? Dễ gặp nhất là nhiều tiền, nhiều tài, ngoại hình đỉnh cao…, cùng vô vàn thứ khác. Cụ thể hơn thì có thể là mong muốn trở thành bác sĩ, kỹ sư, phi hành gia, giáo sư…, nhìn chung thì miễn sao có một kiếp người thật có ích và không phải hối tiếc điêu chi. Tuy nhiên, chính vì “mơ” không bị đánh thuế, nên chẳng dại gì mà không mơ cho ra trò. An nhàn, an toàn quá thì lại nhàm chán, để thêm phần hấp dẫn thì có thể chọn trở thành một vĩ nhân chẳng hạn. Đấy chính là trường hợp của cậu nhóc Gru trong Minions: The Rise Of Gru. Cần nói rõ hơn thì Gru không phải muốn làm một con người lưu danh sử sách theo cách thông thường, cậu khao khát mình sẽ là ác nhân có “số má” nhất hành tinh. Tất nhiên là chẳng khi không mà một chú nhóc lại mang trong mình hoài bão như thế. Đấy là vào thập niên 70, lúc này có một băng tội phạm nổi tiếng có tên Vicious 6. Cả 6 thành viên trong Vicious 6 đều có biệt tài riêng biệt, thủ lĩnh của chúng là Wild Knuckles. Trong lần thực hiện phi vụ mới, một cuộc đảo chính xảy ra, Wild bị đồng đội phản bội nhưng may mắn thoát chết. Vicious 6 lúc này bắt đầu tuyển thành viên mới. Gru từ lâu đã hâm mộ nhóm phản diện kia, thế nên cậu lập tức đăng ký với hy vọng sẽ được chọn. Tất nhiên không phải lúc nào đời cũng trọn vẹn, Gru bị từ chối và thậm chí là chế giễu thậm tệ. Để chứng minh rằng mình có tiềm năng làm kẻ ác, cậu lập tức thể hiện bằng việc ăn cắp Đá Con Giáp – chiến lợi phẩm mới nhất mà Vicious có được từ việc lật đổ Wild. Mọi thứ trở nên nghiêm trọng từ đây. ',1,'Minions 2: Cười Thỏa Mãn Với Binh Đoàn Siêu Quậy Vàng Khè',3,0,2,'Hồ Ngọc Tấn'),(4,'Nếu có bằng khen vinh danh người hồi sinh loạt phim đang hấp hối, Taika Waititi sẽ nhận cả chục cái nhờ công đem franchise Thần Sấm ốm đau dặt dẹo bị chê bai đủ đường trở nên hấp dẫn và đầy sức sống. Chris Hemsworth làm nên sức hút bề ngoài cho Thor Odinson. Chế độ ăn khắt khe và cường độ huấn luyện điên cuồng tạo ra cơ bắp mạnh mẽ từng được “Scarlet Witch” Elizabeth Olsen tấm tắc ngợi khen. Thế nhưng, trình diễn xuất còn phải dùi mài nhiều đó chưa đủ để Thần Sấm đứng ngang hàng Iron Man kiêu ngạo – nhân vật cứu rỗi cả hãng phim Marvel và Captain America khắc kỉ - sở hữu Captain America: Winter Soldier quá thành công. Trước Thor: Ragnarok, Thor và cả franchise của anh ta chỉ thực sự hút khán giả nhờ gã ác nhân kiêm vai thứ chính Loki. Cả Kenneth Branagh – đạo diễn Thor (2011) lẫn Alan Taylor – đạo diễn Thor: The Dark World (2013) đều dày dạn kinh nghiệm. Đội ngũ biên kịch hai phim đâu phải dạng mới tập tành vào nghề. Ấy vậy mà, Thor và Thor: The Dark World có như không, vô hình với rất nhiều fan trung thành Vũ trụ điện ảnh Marvel. Việc phim MCU dìm hàng các ngôi sao thuộc hàng tầm cỡ Hollywood nào phải hiếm hoi. Marvel cho họ những nhân vật nghe hoành tráng nhưng rỗng tuếch, xuất hiện một phần rồi vứt xó. Tuy nhiên, ít ai bất mãn công khai cỡ Natalie Portman. Dễ hiểu thôi! Dù xuất hiện nhiều, tình tiết Thế Giới Bóng Tối khiến Jane Foster mất sạch sức hút. Minh tinh Black Swan từ mặt luôn Marvel. Cả Chris Hemsworth cũng công khai thừa nhận không thích The Dark World.',1,'Thor Love And Thunder: Lời Chia Tay Của Chris Hemsworth?',2,5,1,'Hồ Ngọc Tấn');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_image`
--

DROP TABLE IF EXISTS `review_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review_image` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `image_review` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `reviewId` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK3s6647uay1vi94bivx2ys214q` (`reviewId`),
  CONSTRAINT `FK3s6647uay1vi94bivx2ys214q` FOREIGN KEY (`reviewId`) REFERENCES `review` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_image`
--

LOCK TABLES `review_image` WRITE;
/*!40000 ALTER TABLE `review_image` DISABLE KEYS */;
INSERT INTO `review_image` VALUES (1,'idmovie11-1.jpg',1),(2,'idmovie11-2.jpg',1),(3,'idmovie11-3.jpg',1),(4,'idmovie11-4.jpg',1),(5,'idmovie1-1-1.jpg',2),(6,'idmovie1-1-2.jpg',2),(7,'idmovie1-1-3.jpg',2),(8,'idmovie1-1-4.jpg',2),(9,'idmovie2-1.jpg',3),(10,'idmovie2-2.jpg',3),(11,'idmovie2-3.jpg',3),(12,'idmovie2-4.jpg',3),(13,'idmovie1-2-1.jpg',4),(14,'idmovie1-2-2.jpg',4),(15,'idmovie1-2-3.jpg',4),(16,'idmovie1-2-3.jpg',4);
/*!40000 ALTER TABLE `review_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_account`
--

DROP TABLE IF EXISTS `role_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_account` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `accountId` bigint DEFAULT NULL,
  `roleId` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKfcoqd48rq5elwjtmqhdg3utlw` (`accountId`),
  KEY `FKoybc6nwjpurvyva7g66rgugxl` (`roleId`),
  CONSTRAINT `FKfcoqd48rq5elwjtmqhdg3utlw` FOREIGN KEY (`accountId`) REFERENCES `accounts` (`id`),
  CONSTRAINT `FKoybc6nwjpurvyva7g66rgugxl` FOREIGN KEY (`roleId`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vi_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_account`
--

LOCK TABLES `role_account` WRITE;
/*!40000 ALTER TABLE `role_account` DISABLE KEYS */;
INSERT INTO `role_account` VALUES (15,4,1),(16,4,2),(17,4,3),(118,3,1),(121,3,4),(126,3,2),(127,3,3);
/*!40000 ALTER TABLE `role_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `role_account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'ROLE_USER'),(2,'ROLE_MANAGER'),(3,'ROLE_RECEPTIONIST'),(4,'ROLE_ADMIN');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seat`
--

DROP TABLE IF EXISTS `seat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seat` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `seat_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seat`
--

LOCK TABLES `seat` WRITE;
/*!40000 ALTER TABLE `seat` DISABLE KEYS */;
INSERT INTO `seat` VALUES (1,'A1'),(2,'A2'),(3,'A3'),(4,'A4'),(5,'A5'),(6,'A6'),(7,'A7'),(8,'A8'),(9,'A9'),(10,'A10'),(11,'B1'),(12,'B2'),(13,'B3'),(14,'B4'),(15,'B5'),(16,'B6'),(17,'B7'),(18,'B8'),(19,'B9'),(20,'B10'),(21,'C1'),(22,'C2'),(23,'C3'),(24,'C4'),(25,'C5'),(26,'C6'),(27,'C7'),(28,'C8'),(29,'C9'),(30,'C10'),(31,'D1'),(34,'G1'),(35,'J1'),(37,'D2'),(38,'D3'),(39,'D4'),(40,'D5'),(41,'D6'),(42,'D7'),(43,'D8'),(44,'D9'),(45,'D10'),(46,'E1'),(47,'E2'),(48,'E3'),(49,'E4'),(50,'E5'),(51,'E6'),(52,'E7'),(53,'E8'),(54,'E9'),(55,'E10'),(56,'F1'),(57,'F2'),(58,'F3'),(59,'F4'),(60,'F5'),(61,'F6'),(62,'F7'),(63,'F8'),(64,'F9'),(65,'F10'),(67,'G2'),(68,'G3'),(69,'G4'),(70,'G5'),(71,'G6'),(72,'G7'),(73,'G8'),(74,'G9'),(75,'G10'),(76,'H1'),(77,'H2'),(78,'H3'),(79,'H4'),(80,'H5'),(81,'H6'),(82,'H7'),(83,'H8'),(84,'H9'),(85,'H10'),(86,'I1'),(87,'I2'),(88,'I3'),(89,'I4'),(90,'I5'),(91,'I6'),(92,'I7'),(93,'I8'),(94,'I9'),(95,'I10'),(97,'J2'),(98,'J3'),(99,'J4'),(100,'J5'),(101,'J6'),(102,'J7'),(103,'J8'),(104,'J9'),(105,'J10'),(106,'K1'),(107,'K2'),(108,'K3'),(109,'K4'),(110,'K5'),(111,'K6'),(112,'K7'),(113,'K8'),(114,'K9'),(115,'K10');
/*!40000 ALTER TABLE `seat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seat_cinema_room`
--

DROP TABLE IF EXISTS `seat_cinema_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seat_cinema_room` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cinemaRoomId` bigint DEFAULT NULL,
  `seatId` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKdwhvbpvf0ljwvvbf5bf1j3m2d` (`cinemaRoomId`),
  KEY `FKrbbv7q8r9ju0c33v3pymohnn6` (`seatId`),
  CONSTRAINT `FKdwhvbpvf0ljwvvbf5bf1j3m2d` FOREIGN KEY (`cinemaRoomId`) REFERENCES `cinema_room` (`id`),
  CONSTRAINT `FKrbbv7q8r9ju0c33v3pymohnn6` FOREIGN KEY (`seatId`) REFERENCES `seat` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=387 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seat_cinema_room`
--

LOCK TABLES `seat_cinema_room` WRITE;
/*!40000 ALTER TABLE `seat_cinema_room` DISABLE KEYS */;
INSERT INTO `seat_cinema_room` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,11),(7,1,12),(8,1,13),(9,1,14),(10,1,15),(11,1,21),(12,1,22),(13,1,23),(14,1,24),(15,1,25),(16,2,1),(17,2,2),(18,2,3),(19,2,4),(20,2,11),(21,2,12),(22,2,13),(23,2,14),(25,2,22),(26,2,23),(27,2,24),(28,3,1),(29,3,2),(30,3,3),(31,3,4),(32,3,11),(33,3,12),(34,3,13),(35,3,14),(36,4,1),(37,4,2),(38,4,3),(39,4,4),(40,4,5),(41,4,11),(42,4,12),(43,4,13),(44,4,14),(45,4,15),(46,4,21),(47,4,22),(48,4,23),(49,4,24),(50,4,25),(51,4,31),(52,4,37),(53,4,38),(54,4,39),(55,4,40),(69,24,1),(70,24,2),(71,24,11),(72,24,12),(73,25,1),(74,25,2),(75,25,3),(76,25,4),(77,25,5),(78,25,6),(79,25,7),(80,25,8),(81,25,9),(82,25,10),(83,25,11),(84,25,12),(85,25,13),(86,25,14),(87,25,15),(88,25,16),(89,25,17),(90,25,18),(91,25,19),(92,25,20),(93,25,21),(94,25,22),(95,25,23),(96,25,24),(97,25,25),(98,25,26),(99,25,27),(100,25,28),(101,25,29),(102,25,30),(103,25,31),(104,25,37),(105,25,38),(106,25,39),(107,25,40),(108,25,41),(109,25,42),(110,25,43),(111,25,44),(112,25,45),(113,25,46),(114,25,47),(115,25,48),(116,25,49),(117,25,50),(118,25,51),(119,25,52),(120,25,53),(121,25,54),(122,25,55),(123,25,56),(124,25,57),(125,25,58),(126,25,59),(127,25,60),(128,25,61),(129,25,62),(130,25,63),(131,25,64),(132,25,65),(133,25,34),(134,25,67),(135,25,68),(136,25,69),(137,25,70),(138,25,71),(139,25,72),(140,25,73),(141,25,74),(142,25,75),(143,25,76),(145,25,77),(146,25,78),(147,25,79),(149,25,80),(150,25,81),(151,25,82),(152,25,83),(153,25,84),(154,25,85),(155,25,86),(156,25,87),(157,25,88),(158,25,89),(159,25,90),(160,25,91),(161,25,92),(162,25,93),(163,25,94),(164,25,95),(165,25,35),(166,25,97),(167,25,98),(168,25,99),(169,25,100),(170,25,101),(171,25,102),(172,25,103),(173,25,104),(174,25,105),(175,26,1),(176,26,2),(177,26,3),(178,26,4),(179,26,5),(180,26,6),(181,26,7),(182,26,8),(183,26,9),(184,26,10),(185,26,11),(186,26,12),(187,26,13),(188,26,14),(189,26,15),(190,26,16),(191,26,17),(192,26,18),(193,26,19),(194,26,20),(195,26,21),(196,26,22),(197,26,23),(198,26,24),(199,26,25),(200,26,26),(201,26,27),(202,26,28),(203,26,29),(204,26,30),(205,26,31),(206,26,37),(207,26,38),(208,26,39),(209,26,40),(210,26,41),(211,26,42),(212,26,43),(213,26,44),(214,26,45),(215,26,46),(216,26,47),(217,26,48),(218,26,49),(219,26,50),(220,26,51),(221,26,52),(222,26,53),(223,26,54),(224,26,55),(225,26,56),(226,26,57),(227,26,58),(228,26,59),(229,26,60),(230,26,61),(231,26,62),(232,26,63),(233,26,64),(234,26,65),(235,26,34),(236,26,67),(237,26,68),(238,26,69),(239,26,70),(240,26,71),(241,26,72),(242,26,73),(243,26,74),(244,26,75),(245,26,76),(246,26,77),(247,26,78),(248,26,79),(249,26,80),(250,26,81),(251,26,82),(252,26,83),(253,26,84),(254,26,85),(255,26,86),(256,26,87),(257,26,88),(258,26,89),(259,26,90),(260,26,91),(261,26,92),(262,26,93),(263,26,94),(264,26,95),(265,26,35),(266,26,97),(267,26,98),(268,26,99),(269,26,100),(270,26,101),(271,26,102),(272,26,103),(273,26,104),(274,26,105),(275,27,1),(304,90,1),(305,90,2),(306,90,11),(307,90,12);
/*!40000 ALTER TABLE `seat_cinema_room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `ticket_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `ticket_price` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_dxhefscmw25f7po4lt721wjpc` (`ticket_name`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
INSERT INTO `tickets` VALUES (1,'Vé người lớn',75000),(2,'Vé trẻ em (dưới 5 tuổi)',45000),(3,'Vé cặp đôi(2 vé)',120000);
/*!40000 ALTER TABLE `tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_cinema`
--

DROP TABLE IF EXISTS `transaction_cinema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_cinema` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `deposit_balance` double DEFAULT NULL,
  `staff_name` varchar(255) DEFAULT NULL,
  `transaction_date` datetime DEFAULT NULL,
  `transaction_type` varchar(255) DEFAULT NULL,
  `accountId` bigint DEFAULT NULL,
  `cinemaId` bigint DEFAULT NULL,
  `customerId` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK6xyxgfudx2de6m7ctpotsds7m` (`accountId`),
  KEY `FKsf8nnuv92uadsrqc0wevfy5s7` (`cinemaId`),
  KEY `FK86tnn0mxnjonndxy3r5r78d70` (`customerId`),
  CONSTRAINT `FK6xyxgfudx2de6m7ctpotsds7m` FOREIGN KEY (`accountId`) REFERENCES `accounts` (`id`),
  CONSTRAINT `FK86tnn0mxnjonndxy3r5r78d70` FOREIGN KEY (`customerId`) REFERENCES `customer` (`id`),
  CONSTRAINT `FKsf8nnuv92uadsrqc0wevfy5s7` FOREIGN KEY (`cinemaId`) REFERENCES `cinema` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_cinema`
--

LOCK TABLES `transaction_cinema` WRITE;
/*!40000 ALTER TABLE `transaction_cinema` DISABLE KEYS */;
INSERT INTO `transaction_cinema` VALUES (1,100000,'Hồ Ngọc Tấn','2023-03-11 18:10:50','BUY_FOODS_AT_CINEMA',3,2,2),(7,1000,'Hồ Ngọc Tấn','2023-03-16 19:27:28','DEPOSIT',3,NULL,2),(8,1000,'Hồ Ngọc Tấn','2023-03-16 19:29:14','DEPOSIT',3,NULL,2),(9,10000,'Hồ Ngọc Tấn','2023-03-16 19:30:19','DEPOSIT',3,NULL,2),(10,10000,'Hồ Ngọc Tấn','2023-03-16 19:31:40','DEPOSIT',3,NULL,2),(11,100000,'Hồ Ngọc Tấn','2023-03-16 20:06:02','DEPOSIT',3,NULL,2),(12,100000000000,'Hồ Ngọc Tấn','2023-03-16 20:06:25','DEPOSIT',3,NULL,2),(13,50000,'Hồ Ngọc Tấn','2023-03-16 20:07:02','DEPOSIT',3,NULL,2),(14,50000,'Hồ Ngọc Tấn','2023-03-16 20:07:24','DEPOSIT',3,NULL,2),(15,1,'Hồ Ngọc Tấn','2023-03-16 20:09:02','DEPOSIT',3,NULL,2),(16,54000,'Hồ Ngọc Tấn','2023-03-17 18:47:26','DEPOSIT',3,NULL,2);
/*!40000 ALTER TABLE `transaction_cinema` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `viewed_movie`
--

DROP TABLE IF EXISTS `viewed_movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `viewed_movie` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `JSession` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_vi_0900_ai_ci DEFAULT NULL,
  `accountId` bigint DEFAULT NULL,
  `movieId` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKl7offi8ucs1g999revbtll0go` (`accountId`),
  KEY `FKpn97k04wdek7j3b9tsps2pg29` (`movieId`),
  CONSTRAINT `FKl7offi8ucs1g999revbtll0go` FOREIGN KEY (`accountId`) REFERENCES `accounts` (`id`),
  CONSTRAINT `FKpn97k04wdek7j3b9tsps2pg29` FOREIGN KEY (`movieId`) REFERENCES `movies` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vi_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `viewed_movie`
--

LOCK TABLES `viewed_movie` WRITE;
/*!40000 ALTER TABLE `viewed_movie` DISABLE KEYS */;
INSERT INTO `viewed_movie` VALUES (1,'DA4255D6A1DCB9969DFBA028C38B5A6F',NULL,1),(2,'DA4255D6A1DCB9969DFBA028C38B5A6F',NULL,2),(3,'BC85A5AB86F961501B11C7E9F2FA01F3',3,1),(4,'BC85A5AB86F961501B11C7E9F2FA01F3',3,2),(5,'BC85A5AB86F961501B11C7E9F2FA01F3',3,4),(6,'56D3CE07933B81B90A86676B73DC204C',4,1),(7,'AEEEAC37A2C7F562CB2B7D90F12E3EE8',NULL,1),(8,'02038C897AFC0A8CDCBDBA73767F4F05',3,1),(9,'53B4EC5749E7F4BC7E83994F17B5699E',NULL,2),(10,'1EE909287F2B49D0FD4C053A7D9256F7',3,3),(11,'50FEC0B559841196B2F3A643983FD300',3,2),(12,'15BC40D0B8F541DE7A67A2F35782614B',NULL,1),(13,'FEC641CF5EFDB0A68C7C4DD0D1B1619D',3,3),(14,'FF4D1A684BAF33458FBCB700F5A62A01',NULL,2),(16,'5CADD6BDD8375263D526B3F5CFAD8D4E',4,4),(17,'5CADD6BDD8375263D526B3F5CFAD8D4E',4,2),(18,'0D53A3B5A164D28196AB9637B168898C',NULL,1),(19,'633F18CB32FE8EB73FA0DBF7C0859389',NULL,1),(20,'CF4A864869837B5118466F39227523B4',3,2),(21,'258922302414EC1054F2545C054CEC39',3,3),(22,'A6AD605FA96561FABAF78AFFFDFA6CA2',3,4),(24,'A6AD605FA96561FABAF78AFFFDFA6CA2',3,1),(26,'C586AF30D8602F06E62D040E6BA4B78E',3,3),(27,'1CAFD5F4907E29A3CD1296DAE8305A83',3,1),(28,'C00731FC217410B154307A8B4762F362',3,1),(29,'91487CBC5CEA4E3797A62F3579EC8CC4',3,1),(30,'20690C7AD3DD44D0524AE1517ABCBC3B',3,1),(31,'5EB88541F249FD6D1CA885FA2A489FE0',3,1),(32,'5EB88541F249FD6D1CA885FA2A489FE0',3,3),(33,'2C361BB8F4D6818CAC3BBDE3AC52334D',NULL,39),(34,'328FA4F682E85B5755E7233F5B408A26',3,1),(35,'302CE4A1238074987B08DAE20BE52D82',NULL,39),(36,'A8F9268829CDC640C9D6F705CF165207',NULL,39),(37,'A8F9268829CDC640C9D6F705CF165207',NULL,4),(38,'742FA0780FC33B594253DD285AA81FA7',NULL,39),(39,'83FFBEDC42F6CDFA28A7E376F632647B',NULL,39),(40,'83FFBEDC42F6CDFA28A7E376F632647B',NULL,41);
/*!40000 ALTER TABLE `viewed_movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `viewed_review_movie`
--

DROP TABLE IF EXISTS `viewed_review_movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `viewed_review_movie` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `j_session_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_vi_0900_ai_ci DEFAULT NULL,
  `view_date` date DEFAULT NULL,
  `accountId` bigint DEFAULT NULL,
  `reviewId` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKl88ga9qvpjeyowx5i2q0lx0u2` (`accountId`),
  KEY `FKf3p5mof5jj6b7bx8o8fau53vs` (`reviewId`),
  CONSTRAINT `FKf3p5mof5jj6b7bx8o8fau53vs` FOREIGN KEY (`reviewId`) REFERENCES `review` (`id`),
  CONSTRAINT `FKl88ga9qvpjeyowx5i2q0lx0u2` FOREIGN KEY (`accountId`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vi_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `viewed_review_movie`
--

LOCK TABLES `viewed_review_movie` WRITE;
/*!40000 ALTER TABLE `viewed_review_movie` DISABLE KEYS */;
INSERT INTO `viewed_review_movie` VALUES (1,NULL,'2023-01-07',4,1),(2,NULL,'2023-01-10',4,1),(3,NULL,'2023-01-30',4,1),(4,'1BF0F1A5660A82E63736A64769A8CA80','2023-01-31',NULL,1),(5,NULL,'2023-02-01',3,1),(6,NULL,'2023-02-01',3,4),(7,NULL,'2023-02-03',3,1),(8,NULL,'2023-02-03',3,4),(10,NULL,'2023-03-10',3,1),(12,NULL,'2023-03-10',3,3),(13,NULL,'2023-03-10',3,2);
/*!40000 ALTER TABLE `viewed_review_movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vote_movie`
--

DROP TABLE IF EXISTS `vote_movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vote_movie` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `comment` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_vi_0900_ai_ci DEFAULT NULL,
  `star_number` int DEFAULT NULL,
  `vote_date` datetime DEFAULT NULL,
  `accountId` bigint DEFAULT NULL,
  `movieId` bigint DEFAULT NULL,
  `display` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKh2asng2jnrpxi939udqmntyru` (`accountId`),
  KEY `FK7hieydp5ujfr5kvyr6c29hv9h` (`movieId`),
  CONSTRAINT `FK7hieydp5ujfr5kvyr6c29hv9h` FOREIGN KEY (`movieId`) REFERENCES `movies` (`id`),
  CONSTRAINT `FKh2asng2jnrpxi939udqmntyru` FOREIGN KEY (`accountId`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vi_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vote_movie`
--

LOCK TABLES `vote_movie` WRITE;
/*!40000 ALTER TABLE `vote_movie` DISABLE KEYS */;
INSERT INTO `vote_movie` VALUES (1,'Hay đấy',5,'2023-01-10 07:58:33',4,1,_binary ''),(2,'10 điểm',5,'2023-01-10 07:58:52',4,4,_binary ''),(3,'Dở quá',1,'2023-01-10 07:59:07',4,6,_binary '\0'),(4,'Xuất sắc',5,'2023-01-10 08:23:14',4,3,_binary ''),(5,'Tạm ổn',3,'2023-01-10 09:06:30',4,5,_binary ''),(6,'Hay',5,'2023-01-22 09:37:10',4,3,_binary ''),(7,'haha',3,'2023-02-01 20:41:36',3,1,_binary ''),(8,'hahaaaaa',5,'2023-02-03 23:16:04',3,1,_binary ''),(9,'test',5,'2023-03-10 20:43:01',3,1,_binary '');
/*!40000 ALTER TABLE `vote_movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vote_review_movie`
--

DROP TABLE IF EXISTS `vote_review_movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vote_review_movie` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `comment` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_vi_0900_ai_ci DEFAULT NULL,
  `star_number` int DEFAULT NULL,
  `vote_date` datetime DEFAULT NULL,
  `accountId` bigint DEFAULT NULL,
  `reviewId` bigint DEFAULT NULL,
  `display` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKqsy7nojxfmrisk81o07jfv9sb` (`accountId`),
  KEY `FK79v3i3mf7mbheis3umpw5kf3l` (`reviewId`),
  CONSTRAINT `FK79v3i3mf7mbheis3umpw5kf3l` FOREIGN KEY (`reviewId`) REFERENCES `review` (`id`),
  CONSTRAINT `FKqsy7nojxfmrisk81o07jfv9sb` FOREIGN KEY (`accountId`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vi_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vote_review_movie`
--

LOCK TABLES `vote_review_movie` WRITE;
/*!40000 ALTER TABLE `vote_review_movie` DISABLE KEYS */;
INSERT INTO `vote_review_movie` VALUES (1,'hay',5,'2023-01-30 23:34:16',4,1,_binary ''),(2,'haha',2,'2023-02-01 20:42:00',3,1,_binary '\0'),(3,'hahhaa',5,'2023-02-03 23:17:41',3,4,_binary ''),(5,'test',5,'2023-03-10 20:17:38',3,1,_binary '');
/*!40000 ALTER TABLE `vote_review_movie` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-03-25 10:47:10
