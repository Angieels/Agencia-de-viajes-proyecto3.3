-- =====================================================================
-- PROYECTO: Sistema de Base de Datos para Agencia de Viajes
-- Archivo: backup_agencia-viajes_angie.sql
-- Descripción: Backup completo de la base de datos "agencia_viajes"
--              (estructura de tablas + datos de prueba) en formato SQL.
-- Autor: Angie
-- Fecha de generación: 2026-07-03
-- Motor: MySQL (InnoDB)
--
-- Este archivo puede restaurarse ejecutando:
--   mysql -u tu_usuario -p < backup_agencia-viajes_angie.sql
-- =====================================================================

DROP DATABASE IF EXISTS agencia_viajes;
CREATE DATABASE agencia_viajes;
USE agencia_viajes;

-- ---------------------------------------------------------------------
-- Tabla: clientes  (Entidad Principal 1)
-- ---------------------------------------------------------------------
CREATE TABLE clientes (
    id_cliente      INT AUTO_INCREMENT PRIMARY KEY,
    nombre          VARCHAR(50)  NOT NULL,
    apellido        VARCHAR(50)  NOT NULL,
    dui             VARCHAR(10)  NOT NULL,
    email           VARCHAR(100) NOT NULL,
    telefono        VARCHAR(15)  NOT NULL,
    ciudad          VARCHAR(50)  NOT NULL,
    fecha_registro  DATE         NOT NULL DEFAULT (CURRENT_DATE),
    CONSTRAINT uq_cliente_dui   UNIQUE (dui),
    CONSTRAINT uq_cliente_email UNIQUE (email),
    CONSTRAINT chk_cliente_telefono CHECK (telefono REGEXP '^[0-9+ -]+$')
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Tabla: destinos  (catálogo de destinos turísticos)
-- ---------------------------------------------------------------------
CREATE TABLE destinos (
    id_destino      INT AUTO_INCREMENT PRIMARY KEY,
    nombre_destino  VARCHAR(100) NOT NULL,
    pais            VARCHAR(50)  NOT NULL,
    ciudad          VARCHAR(50)  NOT NULL,
    categoria       ENUM('Playa','Montaña','Ciudad','Aventura','Cultural') NOT NULL,
    descripcion     VARCHAR(255),
    CONSTRAINT uq_destino_pais UNIQUE (nombre_destino, pais)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Tabla: guias_turismo  (catálogo de guías)
-- ---------------------------------------------------------------------
CREATE TABLE guias_turismo (
    id_guia            INT AUTO_INCREMENT PRIMARY KEY,
    nombre             VARCHAR(50)  NOT NULL,
    apellido           VARCHAR(50)  NOT NULL,
    email              VARCHAR(100) NOT NULL,
    telefono           VARCHAR(15)  NOT NULL,
    idiomas            VARCHAR(100) NOT NULL,
    anios_experiencia  INT NOT NULL,
    CONSTRAINT uq_guia_email UNIQUE (email),
    CONSTRAINT chk_guia_experiencia CHECK (anios_experiencia >= 0)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Tabla: paquetes_turisticos  (Entidad Principal 2)
-- ---------------------------------------------------------------------
CREATE TABLE paquetes_turisticos (
    id_paquete       INT AUTO_INCREMENT PRIMARY KEY,
    nombre_paquete   VARCHAR(100) NOT NULL,
    id_destino       INT NOT NULL,
    id_guia          INT NOT NULL,
    duracion_dias    INT NOT NULL,
    precio           DECIMAL(10,2) NOT NULL,
    cupo_maximo      INT NOT NULL,
    cupo_disponible  INT NOT NULL,
    fecha_salida     DATE NOT NULL,
    estado           ENUM('Activo','Agotado','Cancelado') NOT NULL DEFAULT 'Activo',
    CONSTRAINT fk_paquete_destino FOREIGN KEY (id_destino)
        REFERENCES destinos(id_destino)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_paquete_guia FOREIGN KEY (id_guia)
        REFERENCES guias_turismo(id_guia)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_paquete_duracion CHECK (duracion_dias > 0),
    CONSTRAINT chk_paquete_precio   CHECK (precio > 0),
    CONSTRAINT chk_paquete_cupomax  CHECK (cupo_maximo > 0),
    CONSTRAINT chk_paquete_cupodisp CHECK (cupo_disponible >= 0 AND cupo_disponible <= cupo_maximo)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Tabla: reservas  (Transacción -> vincula Entidad 1 y Entidad 2)
-- ---------------------------------------------------------------------
CREATE TABLE reservas (
    id_reserva         INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente         INT NOT NULL,
    id_paquete         INT NOT NULL,
    fecha_reserva      DATE NOT NULL DEFAULT (CURRENT_DATE),
    cantidad_personas  INT NOT NULL,
    total              DECIMAL(10,2) NOT NULL,
    estado             ENUM('Pendiente','Confirmada','Cancelada') NOT NULL DEFAULT 'Pendiente',
    CONSTRAINT fk_reserva_cliente FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_reserva_paquete FOREIGN KEY (id_paquete)
        REFERENCES paquetes_turisticos(id_paquete)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_reserva_personas CHECK (cantidad_personas > 0),
    CONSTRAINT chk_reserva_total    CHECK (total >= 0)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Tabla: pagos  (Pago/Movimiento asociado a la transacción)
-- ---------------------------------------------------------------------
CREATE TABLE pagos (
    id_pago       INT AUTO_INCREMENT PRIMARY KEY,
    id_reserva    INT NOT NULL,
    monto         DECIMAL(10,2) NOT NULL,
    fecha_pago    DATE NOT NULL DEFAULT (CURRENT_DATE),
    metodo_pago   ENUM('Efectivo','Tarjeta','Transferencia') NOT NULL,
    estado_pago   ENUM('Pendiente','Completado','Rechazado') NOT NULL DEFAULT 'Pendiente',
    CONSTRAINT fk_pago_reserva FOREIGN KEY (id_reserva)
        REFERENCES reservas(id_reserva)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT chk_pago_monto CHECK (monto > 0)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Índices adicionales para optimizar los JOIN y filtros más usados
-- ---------------------------------------------------------------------
CREATE INDEX idx_paquete_destino ON paquetes_turisticos(id_destino);
CREATE INDEX idx_paquete_guia    ON paquetes_turisticos(id_guia);
CREATE INDEX idx_reserva_cliente ON reservas(id_cliente);
CREATE INDEX idx_reserva_paquete ON reservas(id_paquete);
CREATE INDEX idx_pago_reserva    ON pagos(id_reserva);
-- =====================================================================
-- PROYECTO: Sistema de Base de Datos para Agencia de Viajes
-- Archivo: 02_script_insercion.sql
-- Descripción: Inserción de datos de prueba (mínimo 10 registros
--              por tabla) respetando el orden de dependencias.
-- =====================================================================

USE agencia_viajes;

-- ---------------------------------------------------------------------
-- 1. CLIENTES (10 registros)
-- ---------------------------------------------------------------------
INSERT INTO clientes (nombre, apellido, dui, email, telefono, ciudad, fecha_registro) VALUES
('María',    'González', '04512378-9', 'maria.gonzalez@gmail.com',  '7012-3456', 'San Salvador',   '2025-01-15'),
('Carlos',   'Martínez', '05893214-2', 'carlos.martinez@gmail.com', '7123-4567', 'Santa Ana',      '2025-02-03'),
('Ana',      'López',    '06234567-1', 'ana.lopez@hotmail.com',     '7234-5678', 'San Miguel',     '2025-02-20'),
('José',     'Ramírez',  '07345678-4', 'jose.ramirez@yahoo.com',    '7345-6789', 'La Libertad',    '2025-03-05'),
('Fernanda', 'Castro',   '08456789-6', 'fer.castro@gmail.com',      '7456-7890', 'Santa Tecla',    '2025-03-18'),
('Diego',    'Hernández','09567890-3', 'diego.hernandez@gmail.com', '7567-8901', 'Sonsonate',      '2025-04-02'),
('Valeria',  'Flores',   '01678901-7', 'valeria.flores@outlook.com','7678-9012', 'Ahuachapán',     '2025-04-21'),
('Andrés',   'Morales',  '02789012-5', 'andres.morales@gmail.com',  '7789-0123', 'San Vicente',    '2025-05-10'),
('Gabriela', 'Vásquez',  '03890123-8', 'gabriela.vasquez@gmail.com','7890-1234', 'Usulután',       '2025-05-27'),
('Ricardo',  'Cruz',     '04901234-0', 'ricardo.cruz@hotmail.com',  '7901-2345', 'La Unión',       '2025-06-08'),
('Silvia',   'Reyes',    '05012345-6', 'silvia.reyes@gmail.com',    '7012-9988', 'San Salvador',   '2025-06-19'),
('Mario',    'Chávez',   '06123456-9', 'mario.chavez@gmail.com',    '7123-8877', 'Santa Ana',      '2025-06-25');

-- ---------------------------------------------------------------------
-- 2. DESTINOS (10 registros)
-- ---------------------------------------------------------------------
INSERT INTO destinos (nombre_destino, pais, ciudad, categoria, descripcion) VALUES
('Playa El Tunco',       'El Salvador', 'La Libertad',   'Playa',    'Zona de surf y ambiente bohemio en la costa salvadoreña.'),
('Cancún',                'México',      'Cancún',        'Playa',    'Playas de arena blanca y aguas turquesa en el Caribe mexicano.'),
('Machu Picchu',          'Perú',        'Cusco',         'Aventura', 'Ciudadela inca ubicada en la cordillera de los Andes.'),
('París',                 'Francia',     'París',         'Cultural', 'Ciudad del arte, la moda y la gastronomía europea.'),
('Nueva York',            'Estados Unidos','Nueva York',  'Ciudad',   'Metrópoli icónica con rascacielos y vida cultural intensa.'),
('Antigua Guatemala',     'Guatemala',   'Antigua',       'Cultural', 'Ciudad colonial declarada Patrimonio de la Humanidad.'),
('Roatán',                'Honduras',    'Roatán',        'Playa',    'Isla caribeña ideal para buceo y arrecifes de coral.'),
('Tokio',                 'Japón',       'Tokio',         'Ciudad',   'Capital japonesa que combina tradición y tecnología.'),
('Bariloche',             'Argentina',   'Bariloche',     'Montaña',  'Destino patagónico famoso por sus lagos y montañas.'),
('Santorini',             'Grecia',      'Santorini',     'Playa',    'Isla griega célebre por sus atardeceres y casas blancas.'),
('Cartagena de Indias',   'Colombia',    'Cartagena',     'Cultural', 'Ciudad amurallada con historia colonial en el Caribe.');

-- ---------------------------------------------------------------------
-- 3. GUIAS_TURISMO (10 registros)
-- ---------------------------------------------------------------------
INSERT INTO guias_turismo (nombre, apellido, email, telefono, idiomas, anios_experiencia) VALUES
('Luis',    'Aguilar',  'luis.aguilar@agencia.com',   '7011-1111', 'Español, Inglés',            8),
('Karla',   'Portillo', 'karla.portillo@agencia.com', '7022-2222', 'Español, Inglés, Francés',    5),
('Pedro',   'Escobar',  'pedro.escobar@agencia.com',  '7033-3333', 'Español, Portugués',          6),
('Daniela', 'Rivas',    'daniela.rivas@agencia.com',  '7044-4444', 'Español, Inglés',              3),
('Héctor',  'Menjívar', 'hector.menjivar@agencia.com','7055-5555', 'Español, Inglés, Japonés',    10),
('Patricia','Alfaro',   'patricia.alfaro@agencia.com','7066-6666', 'Español, Italiano',            4),
('Óscar',   'Guevara',  'oscar.guevara@agencia.com',  '7077-7777', 'Español, Inglés',              7),
('Lorena',  'Sánchez',  'lorena.sanchez@agencia.com', '7088-8888', 'Español, Inglés, Alemán',      9),
('Iván',    'Zelaya',   'ivan.zelaya@agencia.com',    '7099-9999', 'Español, Griego, Inglés',      2),
('Marcela', 'Quintanilla','marcela.quintanilla@agencia.com','7010-0000','Español, Inglés',        6),
('Tomás',   'Barahona', 'tomas.barahona@agencia.com', '7021-1122', 'Español, Inglés, Portugués',   5);

-- ---------------------------------------------------------------------
-- 4. PAQUETES_TURISTICOS (10 registros)
-- ---------------------------------------------------------------------
INSERT INTO paquetes_turisticos (nombre_paquete, id_destino, id_guia, duracion_dias, precio, cupo_maximo, cupo_disponible, fecha_salida, estado) VALUES
('Escape de Surf en El Tunco',        1, 1, 3,   180.00, 20, 12, '2026-08-10', 'Activo'),
('Sol y Playa en Cancún',              2, 2, 5,   850.00, 25, 20, '2026-08-15', 'Activo'),
('Ruta Inca a Machu Picchu',           3, 3, 6,  1350.00, 15,  4, '2026-09-01', 'Activo'),
('París Romántico',                    4, 2, 7,  2100.00, 18,  0, '2026-09-20', 'Agotado'),
('Nueva York en 4 Días',               5, 4, 4,  1200.00, 20, 15, '2026-09-25', 'Activo'),
('Antigua Colonial Express',           6, 6, 2,   150.00, 30, 22, '2026-08-05', 'Activo'),
('Buceo en Roatán',                    7, 7, 5,   950.00, 15,  9, '2026-10-02', 'Activo'),
('Tokio Moderno y Tradicional',        8, 5, 8,  2600.00, 12,  6, '2026-10-15', 'Activo'),
('Aventura en la Patagonia',           9, 6, 6,  1700.00, 16, 10, '2026-11-01', 'Activo'),
('Islas Griegas: Santorini',          10, 9, 5,  1950.00, 14,  0, '2026-08-28', 'Cancelado'),
('Cartagena Histórica',               11, 10,4,   780.00, 22, 18, '2026-11-10', 'Activo');

-- ---------------------------------------------------------------------
-- 5. RESERVAS (12 registros - Transacciones)
-- ---------------------------------------------------------------------
INSERT INTO reservas (id_cliente, id_paquete, fecha_reserva, cantidad_personas, total, estado) VALUES
(1, 1,  '2026-06-01', 2,   360.00, 'Confirmada'),
(2, 3,  '2026-06-02', 1,  1350.00, 'Confirmada'),
(3, 2,  '2026-06-03', 4,  3400.00, 'Confirmada'),
(4, 4,  '2026-06-05', 2,  4200.00, 'Confirmada'),
(5, 6,  '2026-06-06', 3,   450.00, 'Pendiente'),
(6, 5,  '2026-06-08', 1,  1200.00, 'Confirmada'),
(1, 7,  '2026-06-10', 2,  1900.00, 'Pendiente'),
(7, 8,  '2026-06-12', 2,  5200.00, 'Confirmada'),
(8, 9,  '2026-06-14', 3,  5100.00, 'Cancelada'),
(9, 10, '2026-06-15', 2,  3900.00, 'Cancelada'),
(10,11, '2026-06-18', 4,  3120.00, 'Confirmada'),
(2, 6,  '2026-06-20', 1,   150.00, 'Confirmada'),
(3, 1,  '2026-06-21', 3,   540.00, 'Pendiente');

-- ---------------------------------------------------------------------
-- 6. PAGOS (13 registros - Pagos/Movimientos asociados a reservas)
-- ---------------------------------------------------------------------
INSERT INTO pagos (id_reserva, monto, fecha_pago, metodo_pago, estado_pago) VALUES
(1,  360.00, '2026-06-01', 'Tarjeta',       'Completado'),
(2, 1350.00, '2026-06-02', 'Transferencia', 'Completado'),
(3, 1700.00, '2026-06-03', 'Tarjeta',       'Completado'),
(3, 1700.00, '2026-06-10', 'Tarjeta',       'Completado'),
(4, 4200.00, '2026-06-05', 'Transferencia', 'Completado'),
(5,  225.00, '2026-06-06', 'Efectivo',      'Pendiente'),
(6, 1200.00, '2026-06-08', 'Tarjeta',       'Completado'),
(7,  950.00, '2026-06-10', 'Efectivo',      'Pendiente'),
(8, 5200.00, '2026-06-12', 'Transferencia', 'Completado'),
(9, 5100.00, '2026-06-14', 'Tarjeta',       'Rechazado'),
(11,3120.00, '2026-06-18', 'Transferencia', 'Completado'),
(12, 150.00, '2026-06-20', 'Efectivo',      'Completado'),
(13, 270.00, '2026-06-21', 'Tarjeta',       'Pendiente');
