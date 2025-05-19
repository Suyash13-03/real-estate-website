-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: real_estate
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'admin','admin13');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `property_id` int NOT NULL,
  `name` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `appointment_date` varchar(200) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `property_id` (`property_id`),
  CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `property` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment`
--

LOCK TABLES `appointment` WRITE;
/*!40000 ALTER TABLE `appointment` DISABLE KEYS */;
INSERT INTO `appointment` VALUES (1,9,'Suyash Valvaikar','suyashvalvaikar13@gmail.com','8600800475','2025-02-22','2025-02-19 17:15:39'),(2,1,'shubham','shubham107pawar@gmail.com','8010311625','2025-04-25','2025-04-08 02:46:37'),(3,1,'Shubham','shubham107pawar@gmail.com','8010311625','2025-04-24','2025-04-08 02:51:21'),(4,7,'Akash','akashanandpawar324@gmail.com','1234765755','2025-04-18','2025-04-08 02:59:03'),(5,1,'Sanjeev','suyashvalvaikar@gmail.com','8600800475','2025-04-18','2025-04-08 06:25:00');
/*!40000 ALTER TABLE `appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `property`
--

DROP TABLE IF EXISTS `property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `property` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL DEFAULT 'Property',
  `location` varchar(200) NOT NULL,
  `price` varchar(200) NOT NULL,
  `description` varchar(200) NOT NULL,
  `status` varchar(200) NOT NULL DEFAULT 'Available',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `amenities` varchar(200) NOT NULL,
  `type` enum('buy','rent') NOT NULL DEFAULT 'buy',
  `deposit` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property`
--

LOCK TABLES `property` WRITE;
/*!40000 ALTER TABLE `property` DISABLE KEYS */;
INSERT INTO `property` VALUES (1,'1 BHK Flat','Malad West,Mumbai','Rs 60 Lac','Ready to move 1 BHK apartment with 330 sqft area.','Available','2025-02-07 16:31:13','parking,gym,security,lift','buy',NULL),(2,'1 BHK Flat','Dadar East,Mumbai','Rs 85 Lac','Spacious 1 BHK flat with 550 sqft area, ready to move.','Available','2025-02-07 16:31:13','gym,parking,security,park,lift','buy',NULL),(3,'2 BHK Flat','Vile Parle West,Mumbai','Rs 2 Cr','Modern 2 BHK apartment with 1000 sqft area.','Available','2025-02-07 16:31:13','swimming pool,gym,park,lift,parking,security','buy',NULL),(4,'3 BHK Flat','Virar West,Mumbai','Rs 2.5 Cr','Luxurious 3 BHK apartment with 1500 sqft area.','Available','2025-02-07 16:31:13','park,clubhouse,swimming pool,lift,parking,security','buy',NULL),(5,'1 BHK FLat','Andheri West,Mumbai','Rs 75 Lac','Spacious 1BHK Flat with Modern Amenities and 550 sqft area','Available','2025-02-10 16:08:51','parking,gym,security,lift','buy',NULL),(6,'1 BHK Flat','Wadala East,Mumbai','Rs 50,000/mo','Modern 1 BHK apartment with 330 sqft area.','Available','2025-02-19 05:40:50','gym,parking,security,lift','rent','Rs 4 Lac'),(7,'2 BHK Flat','Virar East,Mumbai','Rs 20,000/mo','Spacious 2 BHK flat with 550 sqft area.','Available','2025-02-19 05:40:50','parking,security,gym,park,lift','rent','Rs 2 Lac'),(8,'1 BHK Flat','Andheri West,Mumbai','Rs 25,000/mo','Modern 1 BHK apartment with 500 sqft area.','Available','2025-02-19 05:40:50','lift,security,parking,gym','rent','Rs 3 Lac'),(9,'3 BHK Flat','Vasai West,Mumbai','Rs 28,000/mo','Luxurious 3 BHK apartment with 1500 sqft area.','Available','2025-02-19 05:40:50','gym,parking,security,lift','rent','Rs 2.5 Lac'),(10,'1 BHK Flat','Goregaon East,Mumbai','Rs 22,000/mo','Modern 1 BHK apartment with 350 sqft area.','Available','2025-02-19 17:34:12','gym,parking,security,lift','rent','Rs 3.5 Lac'),(11,'2 bhk flat','Vile Parle,West','Rs 85 Lac','Ready to move 2bhk flat.','Available','2025-04-08 06:26:58','parking,lift,security,gym.','buy','');
/*!40000 ALTER TABLE `property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `property_image`
--

DROP TABLE IF EXISTS `property_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `property_image` (
  `id` int NOT NULL AUTO_INCREMENT,
  `property_id` int NOT NULL,
  `image` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `property_id` (`property_id`),
  CONSTRAINT `property_image_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `property` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property_image`
--

LOCK TABLES `property_image` WRITE;
/*!40000 ALTER TABLE `property_image` DISABLE KEYS */;
INSERT INTO `property_image` VALUES (1,1,'/PropertyImages/Property1/liv.jpg'),(2,1,'/PropertyImages/Property1/bed.jpg'),(3,1,'/PropertyImages/Property1/kit.jpg'),(4,1,'/PropertyImages/Property1/bath.jpg'),(5,2,'/PropertyImages/Property2/liv.jpg'),(6,2,'/PropertyImages/Property2/bed.jpg'),(7,2,'/PropertyImages/Property2/kit.jpg'),(8,2,'/PropertyImages/Property2/bath.jpg'),(9,3,'/PropertyImages/Property3/liv.jpg'),(10,3,'/PropertyImages/Property3/bed1.jpg'),(11,3,'/PropertyImages/Property3/bed2.jpg'),(12,3,'/PropertyImages/Property3/kit.jpg'),(13,3,'/PropertyImages/Property3/bath.jpg'),(14,4,'/PropertyImages/Property4/liv.jpg'),(15,4,'/PropertyImages/Property4/bed1.jpg'),(16,4,'/PropertyImages/Property4/bed2.jpg'),(17,4,'/PropertyImages/Property4/bed3.jpg'),(18,4,'/PropertyImages/Property4/kit.jpg'),(19,4,'/PropertyImages/Property4/bath.jpg'),(20,5,'/PropertyImages/Property5/liv.jpg'),(21,5,'/PropertyImages/Property5/bed.jpg'),(22,5,'/PropertyImages/Property5/kit.jpg'),(23,5,'/PropertyImages/Property5/bath.jpg'),(24,6,'/PropertyImages/Property6/liv.jpg'),(25,6,'/PropertyImages/Property6/bed.jpg'),(26,6,'/PropertyImages/Property6/kit.jpg'),(27,6,'/PropertyImages/Property6/bath.jpg'),(28,7,'/PropertyImages/Property7/liv.jpg'),(29,7,'/PropertyImages/Property7/bed1.jpg'),(30,7,'/PropertyImages/Property7/bed2.jpg'),(31,7,'/PropertyImages/Property7/kit.jpg'),(32,7,'/PropertyImages/Property7/bath.jpg'),(33,8,'/PropertyImages/Property8/liv.jpg'),(34,8,'/PropertyImages/Property8/bed.jpg'),(35,8,'/PropertyImages/Property8/kit.jpg'),(36,8,'/PropertyImages/Property8/bath.jpg'),(37,9,'/PropertyImages/Property9/liv.jpg'),(38,9,'/PropertyImages/Property9/bed1.jpg'),(39,9,'/PropertyImages/Property9/bed2.jpg'),(40,9,'/PropertyImages/Property9/bed3.jpg'),(41,9,'/PropertyImages/Property9/kit.jpg'),(42,9,'/PropertyImages/Property9/bath.jpg'),(43,10,'/PropertyImages/Property10/liv.jpg'),(44,10,'/PropertyImages/Property10/bed.jpg'),(45,10,'/PropertyImages/Property10/kit.jpg'),(46,10,'/PropertyImages/Property10/bath.jpg'),(52,11,'/PropertyImages/Property11/liv.jpg'),(53,11,'/PropertyImages/Property11/bed1.jpg'),(54,11,'/PropertyImages/Property11/kit.jpg'),(55,11,'/PropertyImages/Property11/bath.jpg');
/*!40000 ALTER TABLE `property_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Suyash Valvaikar','suyashvalvaikar13@gmail.com','1234','8600800475'),(2,'Madhura Valvaikar','madhuravalvaikar1906@gmail.com','123456789','7083652562'),(3,'shubham','shu@gmail.com','4455','8010311625');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-19 14:52:03
