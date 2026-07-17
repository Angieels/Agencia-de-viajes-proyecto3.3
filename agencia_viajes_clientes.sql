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
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `dui` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `ciudad` varchar(50) NOT NULL,
  `fecha_registro` date NOT NULL DEFAULT (curdate()),
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `uq_cliente_dui` (`dui`),
  UNIQUE KEY `uq_cliente_email` (`email`),
  CONSTRAINT `chk_cliente_telefono` CHECK (regexp_like(`telefono`,_utf8mb4'^[0-9+ -]+$'))
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'María','González','04512378-9','maria.gonzalez@gmail.com','7012-3456','San Salvador','2025-01-15'),(2,'Carlos','Martínez','05893214-2','carlos.martinez@gmail.com','7123-4567','Santa Ana','2025-02-03'),(3,'Ana','López','06234567-1','ana.lopez@hotmail.com','7234-5678','San Miguel','2025-02-20'),(4,'José','Ramírez','07345678-4','jose.ramirez@yahoo.com','7345-6789','La Libertad','2025-03-05'),(5,'Fernanda','Castro','08456789-6','fer.castro@gmail.com','7456-7890','Santa Tecla','2025-03-18'),(6,'Diego','Hernández','09567890-3','diego.hernandez@gmail.com','7567-8901','Sonsonate','2025-04-02'),(7,'Valeria','Flores','01678901-7','valeria.flores@outlook.com','7678-9012','Ahuachapán','2025-04-21'),(8,'Andrés','Morales','02789012-5','andres.morales@gmail.com','7789-0123','San Vicente','2025-05-10'),(9,'Gabriela','Vásquez','03890123-8','gabriela.vasquez@gmail.com','7890-1234','Usulután','2025-05-27'),(10,'Ricardo','Cruz','04901234-0','ricardo.cruz@hotmail.com','7901-2345','La Unión','2025-06-08'),(11,'Silvia','Reyes','05012345-6','silvia.reyes@gmail.com','7012-9988','San Salvador','2025-06-19'),(12,'Mario','Chávez','06123456-9','mario.chavez@gmail.com','7123-8877','Santa Ana','2025-06-25'),(13,'Roberto','Peña','07234561-3','roberto.pena@gmail.com','7654-3210','San Salvador','2026-07-16');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-16 20:54:50
