-- =====================================================================
-- PROYECTO: Sistema de Base de Datos para Agencia de Viajes
-- Archivo: 01_script_creacion.sql
-- Descripción: Creación de la base de datos y sus tablas con todas
--              las restricciones de integridad (PK, FK, UNIQUE, CHECK).
-- Motor: MySQL (InnoDB)
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
