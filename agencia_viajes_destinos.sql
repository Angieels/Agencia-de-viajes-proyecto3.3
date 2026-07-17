-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: agencia_viajes
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `destinos`
--

DROP TABLE IF EXISTS `destinos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `destinos` (
  `id_destino` int NOT NULL AUTO_INCREMENT,
  `nombre_destino` varchar(100) NOT NULL,
  `pais` varchar(50) NOT NULL,
  `ciudad` varchar(50) NOT NULL,
  `categoria` enum('Playa','Montaña','Ciudad','Aventura','Cultural') NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_destino`),
  UNIQUE KEY `uq_destino_pais` (`nombre_destino`,`pais`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `destinos`
--

LOCK TABLES `destinos` WRITE;
/*!40000 ALTER TABLE `destinos` DISABLE KEYS */;
INSERT INTO `destinos` VALUES (1,'Playa El Tunco','El Salvador','La Libertad','Playa','Zona de surf y ambiente bohemio en la costa salvadoreña.'),(2,'Cancún','México','Cancún','Playa','Playas de arena blanca y aguas turquesa en el Caribe mexicano.'),(3,'Machu Picchu','Perú','Cusco','Aventura','Ciudadela inca ubicada en la cordillera de los Andes.'),(4,'París','Francia','París','Cultural','Ciudad del arte, la moda y la gastronomía europea.'),(5,'Nueva York','Estados Unidos','Nueva York','Ciudad','Metrópoli icónica con rascacielos y vida cultural intensa.'),(6,'Antigua Guatemala','Guatemala','Antigua','Cultural','Ciudad colonial declarada Patrimonio de la Humanidad.'),(7,'Roatán','Honduras','Roatán','Playa','Isla caribeña ideal para buceo y arrecifes de coral.'),(8,'Tokio','Japón','Tokio','Ciudad','Capital japonesa que combina tradición y tecnología.'),(9,'Bariloche','Argentina','Bariloche','Montaña','Destino patagónico famoso por sus lagos y montañas.'),(10,'Santorini','Grecia','Santorini','Playa','Isla griega célebre por sus atardeceres y casas blancas.'),(11,'Cartagena de Indias','Colombia','Cartagena','Cultural','Ciudad amurallada con historia colonial en el Caribe.');
/*!40000 ALTER TABLE `destinos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-16 20:54:51
