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
-- Table structure for table `guias_turismo`
--

DROP TABLE IF EXISTS `guias_turismo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guias_turismo` (
  `id_guia` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `idiomas` varchar(100) NOT NULL,
  `anios_experiencia` int NOT NULL,
  PRIMARY KEY (`id_guia`),
  UNIQUE KEY `uq_guia_email` (`email`),
  CONSTRAINT `chk_guia_experiencia` CHECK ((`anios_experiencia` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guias_turismo`
--

LOCK TABLES `guias_turismo` WRITE;
/*!40000 ALTER TABLE `guias_turismo` DISABLE KEYS */;
INSERT INTO `guias_turismo` VALUES (1,'Luis','Aguilar','luis.aguilar@agencia.com','7011-1111','Español, Inglés',8),(2,'Karla','Portillo','karla.portillo@agencia.com','7022-2222','Español, Inglés, Francés',5),(3,'Pedro','Escobar','pedro.escobar@agencia.com','7033-3333','Español, Portugués',6),(4,'Daniela','Rivas','daniela.rivas@agencia.com','7044-4444','Español, Inglés',3),(5,'Héctor','Menjívar','hector.menjivar@agencia.com','7055-5555','Español, Inglés, Japonés',10),(6,'Patricia','Alfaro','patricia.alfaro@agencia.com','7066-6666','Español, Italiano',4),(7,'Óscar','Guevara','oscar.guevara@agencia.com','7077-7777','Español, Inglés',7),(8,'Lorena','Sánchez','lorena.sanchez@agencia.com','7088-8888','Español, Inglés, Alemán',9),(9,'Iván','Zelaya','ivan.zelaya@agencia.com','7099-9999','Español, Griego, Inglés',2),(10,'Marcela','Quintanilla','marcela.quintanilla@agencia.com','7010-0000','Español, Inglés',6),(11,'Tomás','Barahona','tomas.barahona@agencia.com','7021-1122','Español, Inglés, Portugués',5);
/*!40000 ALTER TABLE `guias_turismo` ENABLE KEYS */;
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
