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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'María','González','04512378-9','maria.gonzalez@gmail.com','7012-3456','San Salvador','2025-01-15'),(2,'Carlos','Martínez','05893214-2','carlos.martinez@gmail.com','7123-4567','Santa Ana','2025-02-03'),(3,'Ana','López','06234567-1','ana.lopez@hotmail.com','7234-5678','San Miguel','2025-02-20'),(4,'José','Ramírez','07345678-4','jose.ramirez@yahoo.com','7345-6789','La Libertad','2025-03-05'),(5,'Fernanda','Castro','08456789-6','fer.castro@gmail.com','7456-7890','Santa Tecla','2025-03-18'),(6,'Diego','Hernández','09567890-3','diego.hernandez@gmail.com','7567-8901','Sonsonate','2025-04-02'),(7,'Valeria','Flores','01678901-7','valeria.flores@outlook.com','7678-9012','Ahuachapán','2025-04-21'),(8,'Andrés','Morales','02789012-5','andres.morales@gmail.com','7789-0123','San Vicente','2025-05-10'),(9,'Gabriela','Vásquez','03890123-8','gabriela.vasquez@gmail.com','7890-1234','Usulután','2025-05-27'),(10,'Ricardo','Cruz','04901234-0','ricardo.cruz@hotmail.com','7901-2345','La Unión','2025-06-08'),(11,'Silvia','Reyes','05012345-6','silvia.reyes@gmail.com','7012-9988','San Salvador','2025-06-19'),(12,'Mario','Chávez','06123456-9','mario.chavez@gmail.com','7123-8877','Santa Ana','2025-06-25'),(13,'Roberto','Peña','07234561-3','roberto.pena@gmail.com','7654-3210','San Salvador','2026-07-16');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Table structure for table `pagos`
--

DROP TABLE IF EXISTS `pagos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagos` (
  `id_pago` int NOT NULL AUTO_INCREMENT,
  `id_reserva` int NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `fecha_pago` date NOT NULL DEFAULT (curdate()),
  `metodo_pago` enum('Efectivo','Tarjeta','Transferencia') NOT NULL,
  `estado_pago` enum('Pendiente','Completado','Rechazado') NOT NULL DEFAULT 'Pendiente',
  PRIMARY KEY (`id_pago`),
  KEY `idx_pago_reserva` (`id_reserva`),
  CONSTRAINT `fk_pago_reserva` FOREIGN KEY (`id_reserva`) REFERENCES `reservas` (`id_reserva`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chk_pago_monto` CHECK ((`monto` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagos`
--

LOCK TABLES `pagos` WRITE;
/*!40000 ALTER TABLE `pagos` DISABLE KEYS */;
INSERT INTO `pagos` VALUES (1,1,360.00,'2026-06-01','Tarjeta','Completado'),(2,2,1350.00,'2026-06-02','Transferencia','Completado'),(3,3,1700.00,'2026-06-03','Tarjeta','Completado'),(4,3,1700.00,'2026-06-10','Tarjeta','Completado'),(5,4,4200.00,'2026-06-05','Transferencia','Completado'),(6,5,225.00,'2026-06-06','Efectivo','Pendiente'),(7,6,1200.00,'2026-06-08','Tarjeta','Completado'),(8,7,950.00,'2026-06-10','Efectivo','Pendiente'),(9,8,5200.00,'2026-06-12','Transferencia','Completado'),(10,9,5100.00,'2026-06-14','Tarjeta','Rechazado'),(11,11,3120.00,'2026-06-18','Transferencia','Completado'),(12,12,150.00,'2026-06-20','Efectivo','Completado'),(14,14,850.00,'2026-07-16','Tarjeta','Completado');
/*!40000 ALTER TABLE `pagos` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Table structure for table `reservas`
--

DROP TABLE IF EXISTS `reservas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservas` (
  `id_reserva` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `id_paquete` int NOT NULL,
  `fecha_reserva` date NOT NULL DEFAULT (curdate()),
  `cantidad_personas` int NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `estado` enum('Pendiente','Confirmada','Cancelada') NOT NULL DEFAULT 'Pendiente',
  PRIMARY KEY (`id_reserva`),
  KEY `idx_reserva_cliente` (`id_cliente`),
  KEY `idx_reserva_paquete` (`id_paquete`),
  CONSTRAINT `fk_reserva_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_reserva_paquete` FOREIGN KEY (`id_paquete`) REFERENCES `paquetes_turisticos` (`id_paquete`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_reserva_personas` CHECK ((`cantidad_personas` > 0)),
  CONSTRAINT `chk_reserva_total` CHECK ((`total` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservas`
--

LOCK TABLES `reservas` WRITE;
/*!40000 ALTER TABLE `reservas` DISABLE KEYS */;
INSERT INTO `reservas` VALUES (1,1,1,'2026-06-01',2,360.00,'Confirmada'),(2,2,3,'2026-06-02',1,1350.00,'Confirmada'),(3,3,2,'2026-06-03',4,3400.00,'Confirmada'),(4,4,4,'2026-06-05',2,4200.00,'Confirmada'),(5,5,6,'2026-06-06',3,450.00,'Confirmada'),(6,6,5,'2026-06-08',1,1200.00,'Confirmada'),(7,1,7,'2026-06-10',2,1900.00,'Pendiente'),(8,7,8,'2026-06-12',2,5200.00,'Confirmada'),(9,8,9,'2026-06-14',3,5100.00,'Cancelada'),(10,9,10,'2026-06-15',2,3900.00,'Cancelada'),(11,10,11,'2026-06-18',4,3120.00,'Confirmada'),(12,2,6,'2026-06-20',1,150.00,'Confirmada'),(14,11,2,'2026-07-16',2,1700.00,'Pendiente');
/*!40000 ALTER TABLE `reservas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-17  7:34:24
