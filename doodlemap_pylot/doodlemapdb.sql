-- MySQL dump 10.13  Distrib 5.7.9, for osx10.9 (x86_64)
--
-- Host: 127.0.0.1    Database: doodlemap_db
-- ------------------------------------------------------
-- Server version	5.5.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `configs`
--

DROP TABLE IF EXISTS `configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `conf_key` varchar(255) DEFAULT NULL,
  `conf_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configs`
--

LOCK TABLES `configs` WRITE;
/*!40000 ALTER TABLE `configs` DISABLE KEYS */;
INSERT INTO `configs` VALUES (1,'email_regex','^[a-zA-Z0-9.+_-]+@[a-zA-Z0-9._-]+.[a-zA-Z]*$'),(2,'pwd_len','8');
/*!40000 ALTER TABLE `configs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fav_locations`
--

DROP TABLE IF EXISTS `fav_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fav_locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_fav_locations_users1_idx` (`user_id`),
  KEY `fk_fav_locations_locations1_idx` (`location_id`),
  CONSTRAINT `fk_fav_locations_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_fav_locations_locations1` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fav_locations`
--

LOCK TABLES `fav_locations` WRITE;
/*!40000 ALTER TABLE `fav_locations` DISABLE KEYS */;
/*!40000 ALTER TABLE `fav_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fav_surveys`
--

DROP TABLE IF EXISTS `fav_surveys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fav_surveys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `survey_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_fav_surveys_users1_idx` (`user_id`),
  KEY `fk_fav_surveys_surveys1_idx` (`survey_id`),
  CONSTRAINT `fk_fav_surveys_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_fav_surveys_surveys1` FOREIGN KEY (`survey_id`) REFERENCES `surveys` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fav_surveys`
--

LOCK TABLES `fav_surveys` WRITE;
/*!40000 ALTER TABLE `fav_surveys` DISABLE KEYS */;
/*!40000 ALTER TABLE `fav_surveys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `options`
--

DROP TABLE IF EXISTS `options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `survey_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_options_surveys1_idx` (`survey_id`),
  CONSTRAINT `fk_options_surveys1` FOREIGN KEY (`survey_id`) REFERENCES `surveys` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `options`
--

LOCK TABLES `options` WRITE;
/*!40000 ALTER TABLE `options` DISABLE KEYS */;
INSERT INTO `options` VALUES (4,'Yes!','2016-06-30 23:55:55','2016-06-30 23:55:55',2),(5,'NO','2016-06-30 23:55:55','2016-06-30 23:55:55',2),(6,'No, he\'s entertaining but needs to lay low fo','2016-07-01 00:14:17','2016-07-01 00:14:17',3),(7,'YES ABSOLUTELY!','2016-07-01 00:14:17','2016-07-01 00:14:17',3),(8,'Now she is chocolate woman','2016-07-01 00:22:48','2016-07-01 00:22:48',4),(9,'Now she is poop','2016-07-01 00:22:48','2016-07-01 00:22:48',4),(10,'Naw she high mindset','2016-07-01 00:22:48','2016-07-01 00:22:48',4),(11,'Audi','2016-07-01 01:08:57','2016-07-01 01:08:57',5),(12,'BMW','2016-07-01 01:08:57','2016-07-01 01:08:57',5),(13,'Indigo','2016-07-01 01:16:17','2016-07-01 01:16:17',6),(14,'Mix','2016-07-01 01:16:17','2016-07-01 01:16:17',6),(15,'Yes, absolutly','2016-07-01 01:17:48','2016-07-01 01:17:48',7),(16,'yes? because Jay made it','2016-07-01 01:17:48','2016-07-01 01:17:48',7),(17,'probably no','2016-07-01 01:17:48','2016-07-01 01:17:48',7);
/*!40000 ALTER TABLE `options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `surveys`
--

DROP TABLE IF EXISTS `surveys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `surveys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` varchar(45) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `lat` int(11) DEFAULT NULL,
  `lng` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_surveys_users_idx` (`created_by`),
  CONSTRAINT `fk_surveys_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `surveys`
--

LOCK TABLES `surveys` WRITE;
/*!40000 ALTER TABLE `surveys` DISABLE KEYS */;
INSERT INTO `surveys` VALUES (2,'Alex is a boss?','2016-06-30 23:55:55','2016-06-30 23:55:55',1,37,-121),(3,'SHould casey shut the fuck up?','2016-07-01 00:14:17','2016-07-01 00:14:17',1,37,-121),(4,'Is souyma a brown woman?','2016-07-01 00:22:48','2016-07-01 00:22:48',1,37,-122),(5,'which car brand in Germany is the best?','2016-07-01 01:08:57','2016-07-01 01:08:57',1,51,10),(6,'Hey, which club is the best?','2016-07-01 01:16:17','2016-07-01 01:16:17',2,38,127),(7,'Is Pylot good?','2016-07-01 01:17:48','2016-07-01 01:17:48',2,38,127);
/*!40000 ALTER TABLE `surveys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'doodle','caltianyu5@gmail.com','$2b$12$TUQXxm36zygOfW.Vo9OUeuIpAK1swsP4N0JAlQ9XVMFqL20kqGHWS','2016-06-30 22:25:05','2016-06-30 22:25:05'),(2,'Evelyn','evelyn@gmail.com','$2b$12$6go68A8GGQzHSWTkd.2isOiaffuRIQi58553tz4bYD6BOaaR2/8iu','2016-07-01 01:14:50','2016-07-01 01:14:50');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `votes`
--

DROP TABLE IF EXISTS `votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `votes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `voter_id` int(11) NOT NULL,
  `option_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_votes_users1_idx` (`voter_id`),
  KEY `fk_votes_options1_idx` (`option_id`),
  CONSTRAINT `fk_votes_users1` FOREIGN KEY (`voter_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_votes_options1` FOREIGN KEY (`option_id`) REFERENCES `options` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `votes`
--

LOCK TABLES `votes` WRITE;
/*!40000 ALTER TABLE `votes` DISABLE KEYS */;
INSERT INTO `votes` VALUES (1,'2016-07-01 00:46:51','2016-07-01 00:46:51',1,10),(2,'2016-07-01 00:47:12','2016-07-01 00:47:12',1,10),(3,'2016-07-01 00:47:15','2016-07-01 00:47:15',1,9),(4,'2016-07-01 00:47:19','2016-07-01 00:47:19',1,8),(5,'2016-07-01 01:09:03','2016-07-01 01:09:03',1,12),(6,'2016-07-01 01:09:07','2016-07-01 01:09:07',1,12),(7,'2016-07-01 01:16:20','2016-07-01 01:16:20',2,14),(8,'2016-07-01 01:16:23','2016-07-01 01:16:23',2,14),(9,'2016-07-01 01:17:52','2016-07-01 01:17:52',2,16),(10,'2016-07-01 01:17:54','2016-07-01 01:17:54',2,16),(11,'2016-07-01 01:17:56','2016-07-01 01:17:56',2,16),(12,'2016-07-01 01:17:59','2016-07-01 01:17:59',2,17);
/*!40000 ALTER TABLE `votes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-07-01  1:31:22
