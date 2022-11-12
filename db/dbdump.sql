DROP DATABASE IF EXISTS stm;
CREATE DATABASE IF NOT EXISTS stm;
USE stm;


-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: stm
-- ------------------------------------------------------
-- Server version	8.0.27

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
-- Table structure for table `area`
--

DROP TABLE IF EXISTS `area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `area` (
  `id` char(10) NOT NULL,
  `name` varchar(30) NOT NULL,
  `traffic_metric` enum('VERY_LOW','LOW','MEDIUM','HIGH','VERY_HIGH') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `area`
--

LOCK TABLES `area` WRITE;
/*!40000 ALTER TABLE `area` DISABLE KEYS */;
INSERT INTO `area` VALUES ('THFA021224','Faliro','MEDIUM'),('THKE835612','Center','VERY_HIGH'),('THPA237310','Panorama','LOW'),('THPO651209','Polichni','VERY_LOW'),('THTO920993','Toumpa','HIGH');
/*!40000 ALTER TABLE `area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `driver`
--

DROP TABLE IF EXISTS `driver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `driver` (
  `id` char(10) NOT NULL,
  `name` varchar(30) NOT NULL,
  `age` int NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `mobile_number` char(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mobile_number` (`mobile_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `driver`
--

LOCK TABLES `driver` WRITE;
/*!40000 ALTER TABLE `driver` DISABLE KEYS */;
INSERT INTO `driver` VALUES ('AI05069901','Jim Brooks',32,'MALE','6972461286'),('BN08028872','John Davis',52,'MALE','6915623763'),('IK13114254','Steve Smith',26,'MALE','6921673161'),('KE01019933','Chloe Brown',36,'FEMALE','6981620227'),('OM27126296','Marie Miller',21,'FEMALE','6993357512');
/*!40000 ALTER TABLE `driver` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `driver_BEFORE_INSERT` BEFORE INSERT ON `driver` FOR EACH ROW BEGIN
	IF NEW.age < 18 OR NEW.age > 100 THEN
		SIGNAL SQLSTATE '10000' SET MESSAGE_TEXT = 'Invalid driver age';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `driver_BEFORE_UPDATE` BEFORE UPDATE ON `driver` FOR EACH ROW BEGIN
	IF NEW.age < 18 OR NEW.age > 100 THEN
		SIGNAL SQLSTATE '15000' SET MESSAGE_TEXT = 'Invalid driver age';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `empty parking slots`
--

DROP TABLE IF EXISTS `empty parking slots`;
/*!50001 DROP VIEW IF EXISTS `empty parking slots`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `empty parking slots` AS SELECT 
 1 AS `area name`,
 1 AS `area id`,
 1 AS `parking location`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `neighboring_areas`
--

DROP TABLE IF EXISTS `neighboring_areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `neighboring_areas` (
  `area1_id` char(10) NOT NULL,
  `area2_id` char(10) NOT NULL,
  PRIMARY KEY (`area1_id`,`area2_id`),
  KEY `area2_id` (`area2_id`),
  CONSTRAINT `neighboring_areas_ibfk_1` FOREIGN KEY (`area1_id`) REFERENCES `area` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `neighboring_areas_ibfk_2` FOREIGN KEY (`area2_id`) REFERENCES `area` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `neighboring_areas`
--

LOCK TABLES `neighboring_areas` WRITE;
/*!40000 ALTER TABLE `neighboring_areas` DISABLE KEYS */;
INSERT INTO `neighboring_areas` VALUES ('THPO651209','THFA021224'),('THTO920993','THFA021224'),('THPO651209','THPA237310'),('THKE835612','THPO651209'),('THFA021224','THTO920993'),('THKE835612','THTO920993'),('THPA237310','THTO920993');
/*!40000 ALTER TABLE `neighboring_areas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `neighboring_areas_BEFORE_INSERT` BEFORE INSERT ON `neighboring_areas` FOR EACH ROW BEGIN
	IF NEW.area1_id = NEW.area2_id THEN
		SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = 'Invalid neighboring areas';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `neighboring_areas_BEFORE_UPDATE` BEFORE UPDATE ON `neighboring_areas` FOR EACH ROW BEGIN
	IF NEW.area1_id = NEW.area2_id THEN
		SIGNAL SQLSTATE '55000' SET MESSAGE_TEXT = 'Invalid neighboring areas';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `parking_slot`
--

DROP TABLE IF EXISTS `parking_slot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parking_slot` (
  `id` char(10) NOT NULL,
  `status` enum('EMPTY','NOT_EMPTY') DEFAULT NULL,
  `location` char(24) NOT NULL,
  `area_id` char(10) NOT NULL,
  PRIMARY KEY (`id`,`area_id`),
  UNIQUE KEY `id` (`id`),
  KEY `area_id` (`area_id`),
  CONSTRAINT `parking_slot_ibfk_1` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parking_slot`
--

LOCK TABLES `parking_slot` WRITE;
/*!40000 ALTER TABLE `parking_slot` DISABLE KEYS */;
INSERT INTO `parking_slot` VALUES ('THFA402225','EMPTY','40.623412,22.955825','THFA021224'),('THKE412320','EMPTY','41.427462,23.652820','THPA237310'),('THPA292425','NOT_EMPTY','39.523312,24.535225','THPA237310'),('THPO282225','NOT_EMPTY','38.628712,22.005225','THTO920993'),('THTO421920','NOT_EMPTY','42.327402,19.865920','THTO920993');
/*!40000 ALTER TABLE `parking_slot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `route`
--

DROP TABLE IF EXISTS `route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `route` (
  `id` char(10) NOT NULL,
  `duration_in_min` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `route`
--

LOCK TABLES `route` WRITE;
/*!40000 ALTER TABLE `route` DISABLE KEYS */;
INSERT INTO `route` VALUES ('THKEPO9884',15),('THKETO3441',15),('THPAFA3163',20),('THPOPA0121',30),('THPOTO0912',25);
/*!40000 ALTER TABLE `route` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `route_BEFORE_INSERT` BEFORE INSERT ON `route` FOR EACH ROW BEGIN
	IF NEW.duration_in_min < 0 THEN
		SIGNAL SQLSTATE '30000' SET MESSAGE_TEXT = 'Invalid route duration';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `route_BEFORE_UPDATE` BEFORE UPDATE ON `route` FOR EACH ROW BEGIN
	IF NEW.duration_in_min < 0 THEN
		SIGNAL SQLSTATE '35000' SET MESSAGE_TEXT = 'Invalid route duration';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `route_area`
--

DROP TABLE IF EXISTS `route_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `route_area` (
  `route_id` char(10) NOT NULL,
  `area_id` char(10) NOT NULL,
  PRIMARY KEY (`route_id`,`area_id`),
  KEY `area_id` (`area_id`),
  CONSTRAINT `route_area_ibfk_1` FOREIGN KEY (`route_id`) REFERENCES `route` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `route_area_ibfk_2` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `route_area`
--

LOCK TABLES `route_area` WRITE;
/*!40000 ALTER TABLE `route_area` DISABLE KEYS */;
INSERT INTO `route_area` VALUES ('THPAFA3163','THFA021224'),('THPOTO0912','THFA021224'),('THKEPO9884','THKE835612'),('THKETO3441','THKE835612'),('THPAFA3163','THPA237310'),('THPOPA0121','THPA237310'),('THKEPO9884','THPO651209'),('THPOPA0121','THPO651209'),('THPOTO0912','THPO651209'),('THKETO3441','THTO920993'),('THPAFA3163','THTO920993'),('THPOTO0912','THTO920993');
/*!40000 ALTER TABLE `route_area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tolls`
--

DROP TABLE IF EXISTS `tolls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tolls` (
  `id` char(10) NOT NULL,
  `toll_in_euros` float DEFAULT NULL,
  `location` char(24) NOT NULL,
  `area_id` char(10) NOT NULL,
  PRIMARY KEY (`id`,`area_id`),
  UNIQUE KEY `id` (`id`),
  KEY `area_id` (`area_id`),
  CONSTRAINT `tolls_ibfk_1` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tolls`
--

LOCK TABLES `tolls` WRITE;
/*!40000 ALTER TABLE `tolls` DISABLE KEYS */;
INSERT INTO `tolls` VALUES ('THFAT09051',1.1,'42.429962,24.611880','THFA021224'),('THKET95127',1.2,'41.488462,21.659920','THKE835612'),('THPAT09978',0.7,'40.517462,21.882820','THPA237310'),('THPOT65481',0.9,'41.473062,23.699920','THPO651209'),('THTOT12842',1,'39.462662,22.677820','THTO920993');
/*!40000 ALTER TABLE `tolls` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tolls_BEFORE_INSERT` BEFORE INSERT ON `tolls` FOR EACH ROW BEGIN
	IF NEW.toll_in_euros < 0 THEN
		SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Invalid toll';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tolls_BEFORE_UPDATE` BEFORE UPDATE ON `tolls` FOR EACH ROW BEGIN
	IF NEW.toll_in_euros < 0 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid toll';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `traffic_light`
--

DROP TABLE IF EXISTS `traffic_light`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `traffic_light` (
  `id` char(10) NOT NULL,
  `status` enum('GREEN','RED') DEFAULT NULL,
  `duration_in_sec` int DEFAULT NULL,
  `location` char(24) NOT NULL,
  `area_id` char(10) NOT NULL,
  PRIMARY KEY (`id`,`area_id`),
  KEY `area_id` (`area_id`),
  CONSTRAINT `traffic_light_ibfk_1` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `traffic_light`
--

LOCK TABLES `traffic_light` WRITE;
/*!40000 ALTER TABLE `traffic_light` DISABLE KEYS */;
INSERT INTO `traffic_light` VALUES ('THFATL0212','RED',5,'42.427462,24.652880','THFA021224'),('THKETL3267','GREEN',35,'40.424462,22.654820','THKE835612'),('THPATL2572','RED',25,'40.887462,21.692820','THPA237310'),('THPOTL9032','GREEN',30,'40.400062,23.699920','THPO651209'),('THTOTL1903','RED',20,'39.426662,22.677820','THTO920993');
/*!40000 ALTER TABLE `traffic_light` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicle` (
  `licence_plate` char(10) NOT NULL,
  `type` enum('CAR','MOTORCYCLE','TRUCK') NOT NULL,
  `driver_id` char(10) NOT NULL,
  `route_id` char(10) DEFAULT NULL,
  `current_area_id` char(10) DEFAULT NULL,
  `starting_area_id` char(10) DEFAULT NULL,
  `destination_area_id` char(10) DEFAULT NULL,
  PRIMARY KEY (`licence_plate`,`driver_id`),
  KEY `driver_id` (`driver_id`),
  KEY `route_id` (`route_id`),
  KEY `current_area_id` (`current_area_id`),
  KEY `starting_area_id` (`starting_area_id`),
  KEY `destination_area_id` (`destination_area_id`),
  CONSTRAINT `vehicle_ibfk_1` FOREIGN KEY (`driver_id`) REFERENCES `driver` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `vehicle_ibfk_2` FOREIGN KEY (`route_id`) REFERENCES `route` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vehicle_ibfk_3` FOREIGN KEY (`current_area_id`) REFERENCES `area` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vehicle_ibfk_4` FOREIGN KEY (`starting_area_id`) REFERENCES `area` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vehicle_ibfk_5` FOREIGN KEY (`destination_area_id`) REFERENCES `area` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle`
--

LOCK TABLES `vehicle` WRITE;
/*!40000 ALTER TABLE `vehicle` DISABLE KEYS */;
INSERT INTO `vehicle` VALUES ('GRTH098331','MOTORCYCLE','KE01019933','THKETO3441','THKE835612','THKE835612','THTO920993'),('GRTH639633','CAR','AI05069901','THPAFA3163','THTO920993','THPA237310','THFA021224'),('GRTH699821','CAR','IK13114254','THPOTO0912','THFA021224','THPO651209','THTO920993'),('GRTH707342','TRUCK','BN08028872','THPOPA0121','THPO651209','THPO651209','THPA237310'),('GRTH788242','CAR','OM27126296','THKEPO9884','THKE835612','THKE835612','THPO651209');
/*!40000 ALTER TABLE `vehicle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vehicle types per area`
--

DROP TABLE IF EXISTS `vehicle types per area`;
/*!50001 DROP VIEW IF EXISTS `vehicle types per area`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vehicle types per area` AS SELECT 
 1 AS `area id`,
 1 AS `area name`,
 1 AS `vehicle type`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `violation`
--

DROP TABLE IF EXISTS `violation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `violation` (
  `id` char(10) NOT NULL,
  `type` enum('TRAFFIC_LIGHT','SPEED_LIMIT','TRAFFIC_SIGN') DEFAULT NULL,
  `fee_in_euros` float DEFAULT NULL,
  `driver_id` char(10) NOT NULL,
  PRIMARY KEY (`id`,`driver_id`),
  KEY `driver_id` (`driver_id`),
  CONSTRAINT `violation_ibfk_1` FOREIGN KEY (`driver_id`) REFERENCES `driver` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `violation`
--

LOCK TABLES `violation` WRITE;
/*!40000 ALTER TABLE `violation` DISABLE KEYS */;
INSERT INTO `violation` VALUES ('EZ5205OM96','TRAFFIC_SIGN',40,'OM27126296'),('KF9571KE33','SPEED_LIMIT',90,'KE01019933'),('PP3781AI01','TRAFFIC_SIGN',20,'KE01019933'),('SA9312IK54','TRAFFIC_LIGHT',300,'IK13114254'),('YT1267BN72','SPEED_LIMIT',60,'OM27126296');
/*!40000 ALTER TABLE `violation` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `violation_BEFORE_INSERT` BEFORE INSERT ON `violation` FOR EACH ROW BEGIN
	IF NEW.fee_in_euros < 0 THEN
		SIGNAL SQLSTATE '20000' SET MESSAGE_TEXT = 'Invalid violation fee';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `violation_BEFORE_UPDATE` BEFORE UPDATE ON `violation` FOR EACH ROW BEGIN
	IF NEW.fee_in_euros < 0 THEN
		SIGNAL SQLSTATE '25000' SET MESSAGE_TEXT = 'Invalid violation fee';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `violators`
--

DROP TABLE IF EXISTS `violators`;
/*!50001 DROP VIEW IF EXISTS `violators`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `violators` AS SELECT 
 1 AS `driver id`,
 1 AS `name`,
 1 AS `age`,
 1 AS `gender`,
 1 AS `mobile number`,
 1 AS `violation type`,
 1 AS `fee`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `empty parking slots`
--

/*!50001 DROP VIEW IF EXISTS `empty parking slots`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `empty parking slots` AS select `_area`.`name` AS `area name`,`_parking_slot`.`area_id` AS `area id`,`_parking_slot`.`location` AS `parking location` from ((select `area`.`name` AS `name`,`area`.`id` AS `id` from `area`) `_area` join (select `parking_slot`.`area_id` AS `area_id`,`parking_slot`.`location` AS `location` from `parking_slot` where (`parking_slot`.`status` = 'EMPTY')) `_parking_slot` on((`_area`.`id` = `_parking_slot`.`area_id`))) order by `_area`.`name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vehicle types per area`
--

/*!50001 DROP VIEW IF EXISTS `vehicle types per area`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vehicle types per area` AS select `area`.`id` AS `area id`,`area`.`name` AS `area name`,`vehicle`.`type` AS `vehicle type` from (`area` join `vehicle` on((`area`.`id` = `vehicle`.`current_area_id`))) order by `area`.`name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `violators`
--

/*!50001 DROP VIEW IF EXISTS `violators`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `violators` AS select `driver`.`id` AS `driver id`,`driver`.`name` AS `name`,`driver`.`age` AS `age`,`driver`.`gender` AS `gender`,`driver`.`mobile_number` AS `mobile number`,`violation`.`type` AS `violation type`,`violation`.`fee_in_euros` AS `fee` from (`driver` join `violation` on((`driver`.`id` = `violation`.`driver_id`))) order by `driver`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-12-16  1:25:43
