-- MySQL dump 10.13  Distrib 8.0.18, for Linux (x86_64)
--
-- Host: localhost    Database: shop
-- ------------------------------------------------------
-- Server version	8.0.18

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `catalogs`
--

DROP TABLE IF EXISTS `catalogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT 'Название раздела',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `unique_name` (`name`(10))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Разделы интернет-магазина';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogs`
--

LOCK TABLES `catalogs` WRITE;
/*!40000 ALTER TABLE `catalogs` DISABLE KEYS */;
INSERT INTO `catalogs` VALUES (1,'Процессоры'),(2,'Материнские платы'),(3,'Видеокарты'),(4,'Жесткие диски'),(5,'Оперативная память');
/*!40000 ALTER TABLE `catalogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discounts`
--

DROP TABLE IF EXISTS `discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discounts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `product_id` int(10) unsigned DEFAULT NULL,
  `discount` float unsigned DEFAULT NULL COMMENT 'Величина скидки от 0.0 до 1.0',
  `started_at` datetime DEFAULT NULL,
  `finished_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_of_user_id` (`user_id`),
  KEY `index_of_product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Скидки';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discounts`
--

LOCK TABLES `discounts` WRITE;
/*!40000 ALTER TABLE `discounts` DISABLE KEYS */;
INSERT INTO `discounts` VALUES (1,4,4,0.1,'1996-12-21 14:17:34','1982-03-28 18:19:15','1994-05-16 05:47:50','1985-04-27 04:57:28'),(2,3,2,1,'2004-10-21 12:50:24','1980-09-09 10:33:05','2012-09-10 18:21:49','2002-07-31 06:30:38'),(3,5,7,0.4,'1982-03-25 06:10:19','1996-09-12 21:46:20','1975-05-24 21:48:37','1991-04-26 19:39:42'),(4,6,5,0.7,'1972-02-29 13:57:40','1977-01-13 10:49:13','1989-10-29 17:46:04','1990-06-23 02:16:24'),(5,6,4,0.2,'1970-01-02 18:22:29','1975-06-01 03:35:22','1972-01-20 10:58:31','2012-02-16 22:14:10'),(6,1,1,0.2,'1981-07-15 21:25:56','2005-11-10 07:10:20','1993-02-10 15:38:59','1991-02-06 05:44:30'),(7,6,3,0.8,'2008-10-21 03:41:46','1982-02-25 04:57:19','2007-01-11 16:22:56','1988-04-04 21:08:41'),(8,1,4,0.6,'2009-04-08 03:40:10','1993-02-15 05:43:46','1992-11-01 06:36:13','1970-06-09 15:11:14'),(9,4,7,0.8,'1991-08-13 11:47:18','2003-09-12 20:29:35','1986-12-09 09:10:35','2009-02-08 13:54:19'),(10,1,2,0.8,'1999-12-27 10:13:38','1971-02-28 16:14:25','2018-10-28 19:42:37','1985-01-04 02:52:04');
/*!40000 ALTER TABLE `discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_of_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Заказы';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,3,'1988-06-05 20:18:39','1993-11-09 15:00:52'),(2,1,'1995-03-04 06:46:27','2003-11-13 21:12:14'),(3,2,'1987-12-28 23:23:24','1988-07-20 19:04:13'),(4,4,'1982-01-05 12:04:59','1997-10-14 01:48:36'),(5,3,'1981-10-17 09:51:50','1985-01-02 11:13:08'),(6,2,'1997-08-05 01:39:10','2016-01-31 20:20:29'),(7,2,'2003-07-01 19:48:20','1995-08-23 20:17:27'),(8,1,'2018-07-08 07:07:29','2018-02-25 06:07:10'),(9,2,'2013-04-21 06:13:10','2017-08-28 02:48:23'),(10,6,'2017-11-08 13:18:32','1997-04-06 20:59:50');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_products`
--

DROP TABLE IF EXISTS `orders_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned DEFAULT NULL,
  `product_id` int(10) unsigned DEFAULT NULL,
  `total` int(10) unsigned DEFAULT '1' COMMENT 'Количество заказанных товарных позиций',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Состав заказа';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_products`
--

LOCK TABLES `orders_products` WRITE;
/*!40000 ALTER TABLE `orders_products` DISABLE KEYS */;
INSERT INTO `orders_products` VALUES (1,1,7,2,'2000-03-10 04:52:40','1988-09-17 03:00:08'),(2,2,5,4,'1976-03-04 03:19:30','2007-06-18 21:25:22'),(3,3,5,3,'2004-02-27 00:01:32','1972-11-07 02:06:28'),(4,4,6,5,'1986-08-09 00:49:26','1986-09-14 15:17:22'),(5,5,5,4,'1981-11-08 02:09:03','1971-07-08 00:09:02'),(6,6,1,3,'1987-06-19 03:28:09','1972-12-02 03:32:41'),(7,7,7,4,'2013-08-11 08:57:46','2004-03-02 02:11:39'),(8,8,6,5,'1977-03-18 07:33:45','1976-11-21 17:26:33'),(9,9,2,3,'1979-06-05 16:47:02','1992-11-27 02:35:40'),(10,10,7,2,'2010-05-17 03:42:37','2017-04-24 13:18:20');
/*!40000 ALTER TABLE `orders_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT 'Название',
  `description` text COMMENT 'Описание',
  `price` decimal(11,2) DEFAULT NULL COMMENT 'Цена',
  `catalog_id` int(10) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `index_of_catalog_id` (`catalog_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Товарные позиции';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Intel Core i3-8100','Процессор для настольных персональных компьютеров, основанных на платформе Intel.',7890.00,1,'2020-02-05 14:45:28','2020-02-05 14:45:28'),(2,'Intel Core i5-7400','Процессор для настольных персональных компьютеров, основанных на платформе Intel.',12700.00,1,'2020-02-05 14:45:28','2020-02-05 14:45:28'),(3,'AMD FX-8320E','Процессор для настольных персональных компьютеров, основанных на платформе AMD.',4780.00,1,'2020-02-05 14:45:28','2020-02-05 14:45:28'),(4,'AMD FX-8320','Процессор для настольных персональных компьютеров, основанных на платформе AMD.',7120.00,1,'2020-02-05 14:45:28','2020-02-05 14:45:28'),(5,'ASUS ROG MAXIMUS X HERO','Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX',19310.00,2,'2020-02-05 14:45:28','2020-02-05 14:45:28'),(6,'Gigabyte H310M S2H','Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX',4790.00,2,'2020-02-05 14:45:28','2020-02-05 14:45:28'),(7,'MSI B250M GAMING PRO','Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX',5060.00,2,'2020-02-05 14:45:28','2020-02-05 14:45:28');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storehouses`
--

DROP TABLE IF EXISTS `storehouses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storehouses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Название',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Склады';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storehouses`
--

LOCK TABLES `storehouses` WRITE;
/*!40000 ALTER TABLE `storehouses` DISABLE KEYS */;
INSERT INTO `storehouses` VALUES (1,'Koch Vista','1998-07-07 04:44:01','1998-12-01 12:31:32'),(2,'Howe Extensions','1972-08-18 00:37:13','2013-11-19 20:38:33'),(3,'Lind Landing','1978-12-09 18:24:14','2008-06-29 01:07:25'),(4,'Kallie Crescent','2017-07-03 16:11:59','2005-01-07 08:15:07'),(5,'Gislason Gateway','1985-05-07 06:41:57','1972-10-10 18:22:23');
/*!40000 ALTER TABLE `storehouses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storehouses_products`
--

DROP TABLE IF EXISTS `storehouses_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storehouses_products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `storehouse_id` int(10) unsigned DEFAULT NULL,
  `product_id` int(10) unsigned DEFAULT NULL,
  `value` int(10) unsigned DEFAULT NULL COMMENT 'Запас товарной позиции на складе',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Запасы на складе';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storehouses_products`
--

LOCK TABLES `storehouses_products` WRITE;
/*!40000 ALTER TABLE `storehouses_products` DISABLE KEYS */;
INSERT INTO `storehouses_products` VALUES (1,1,6,3,'2012-03-13 10:29:41','1971-02-22 16:43:56'),(2,2,5,7,'1971-07-18 01:47:05','1978-06-26 21:03:52'),(3,3,3,0,'2004-12-26 05:28:39','2001-08-06 11:57:10'),(4,4,2,9,'1982-07-16 04:03:40','2018-02-13 21:29:52'),(5,5,6,6,'2017-11-01 08:14:16','1982-07-07 07:19:36'),(6,1,5,10,'1998-07-05 05:30:16','1979-08-16 19:58:38'),(7,2,5,10,'1994-11-29 22:09:21','1998-06-15 12:04:54'),(8,3,6,2,'2010-08-17 02:04:32','1993-01-13 04:09:33'),(9,4,3,10,'1994-08-05 13:00:18','2005-03-09 19:12:56'),(10,5,3,3,'1970-07-26 18:47:48','2012-01-29 10:15:02'),(11,1,1,10,'2017-06-29 03:56:18','2010-12-04 06:26:54'),(12,2,1,1,'2011-06-23 06:04:14','1982-02-18 05:52:50'),(13,3,5,4,'1993-02-01 01:30:21','2010-05-11 02:58:52'),(14,4,6,2,'2016-06-03 19:13:30','2014-11-26 20:33:23'),(15,5,6,10,'2012-10-18 23:18:41','1985-11-28 01:28:55'),(16,1,7,0,'2010-08-24 12:04:30','2001-07-17 09:38:57'),(17,2,2,2,'1983-12-11 11:59:18','1974-07-31 08:55:16'),(18,3,4,2,'2009-11-06 06:43:08','1970-02-05 11:17:11'),(19,4,3,5,'1970-11-05 20:17:41','1973-11-12 18:54:43'),(20,5,4,3,'2000-08-09 03:53:45','1985-05-10 03:38:47');
/*!40000 ALTER TABLE `storehouses_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT 'Имя покупателя',
  `birthday_at` date DEFAULT NULL COMMENT 'Дата рождения',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Покупатели';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Геннадий','1990-10-05','2020-02-05 14:45:28','2020-02-05 14:45:28'),(2,'Наталья','1984-11-12','2020-02-05 14:45:28','2020-02-05 14:45:28'),(3,'Александр','1985-05-20','2020-02-05 14:45:28','2020-02-05 14:45:28'),(4,'Сергей','1988-02-14','2020-02-05 14:45:28','2020-02-05 14:45:28'),(5,'Иван','1998-01-12','2020-02-05 14:45:28','2020-02-05 14:45:28'),(6,'Мария','1992-08-29','2020-02-05 14:45:28','2020-02-05 14:45:28');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-02-05 15:36:31
