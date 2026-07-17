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
-- Table structure for table `paquetes_turisticos`
--

DROP TABLE IF EXISTS `paquetes_turisticos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paquetes_turisticos` (
  `id_paquete` int NOT NULL AUTO_INCREMENT,
  `nombre_paquete` varchar(100) NOT NULL,
  `id_destino` int NOT NULL,
  `id_guia` int NOT NULL,
  `duracion_dias` int NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `cupo_maximo` int NOT NULL,
  `cupo_disponible` int NOT NULL,
  `fecha_salida` date NOT NULL,
  `estado` enum('Activo','Agotado','Cancelado') NOT NULL DEFAULT 'Activo',
  PRIMARY KEY (`id_paquete`),
  KEY `idx_paquete_destino` (`id_destino`),
  KEY `idx_paquete_guia` (`id_guia`),
  CONSTRAINT `fk_paquete_destino` FOREIGN KEY (`id_destino`) REFERENCES `destinos` (`id_destino`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_paquete_guia` FOREIGN KEY (`id_guia`) REFERENCES `guias_turismo` (`id_guia`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_paquete_cupodisp` CHECK (((`cupo_disponible` >= 0) and (`cupo_disponible` <= `cupo_maximo`))),
  CONSTRAINT `chk_paquete_cupomax` CHECK ((`cupo_maximo` > 0)),
  CONSTRAINT `chk_paquete_duracion` CHECK ((`duracion_dias` > 0)),
  CONSTRAINT `chk_paquete_precio` CHECK ((`precio` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paquetes_turisticos`
--

LOCK TABLES `paquetes_turisticos` WRITE;
/*!40000 ALTER TABLE `paquetes_turisticos` DISABLE KEYS */;
INSERT INTO `paquetes_turisticos` VALUES (1,'Escape de Surf en El Tunco',1,1,3,180.00,20,12,'2026-08-10','Activo'),(2,'Sol y Playa en Cancún',2,2,5,850.00,25,19,'2026-08-15','Activo'),(3,'Ruta Inca a Machu Picchu',3,3,6,1350.00,15,4,'2026-09-01','Activo'),(4,'París Romántico',4,2,7,2100.00,18,0,'2026-09-20','Agotado'),(5,'Nueva York en 4 Días',5,4,4,1200.00,20,15,'2026-09-25','Activo'),(6,'Antigua Colonial Express',6,6,2,150.00,30,22,'2026-08-05','Activo'),(7,'Buceo en Roatán',7,7,5,950.00,15,9,'2026-10-02','Activo'),(8,'Tokio Moderno y Tradicional',8,5,8,2600.00,12,6,'2026-10-15','Activo'),(9,'Aventura en la Patagonia',9,6,6,1700.00,16,10,'2026-11-01','Activo'),(10,'Islas Griegas: Santorini',10,9,5,1950.00,14,0,'2026-08-28','Cancelado'),(11,'Cartagena Histórica',11,10,4,780.00,22,18,'2026-11-10','Activo'),(12,'Ruta Colonial Antigua + Cartagena',6,6,5,990.00,20,20,'2026-12-01','Activo');
/*!40000 ALTER TABLE `paquetes_turisticos` ENABLE KEYS */;
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
