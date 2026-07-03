CREATE DATABASE agencia_viajes;
USE agencia_viajes;

-- Tabla: Clientes (Entidad Principal 1)
CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    fecha_registro DATE NOT NULL
);

-- Tabla: Guias de Turismo
CREATE TABLE Guias (
    id_guia INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    idioma VARCHAR(50) NOT NULL,
    telefono VARCHAR(20),
    capacidad_max INT NOT NULL -- Capacidad máxima de turistas por grupo
);

-- Tabla: Destinos
CREATE TABLE Destinos (
    id_destino INT AUTO_INCREMENT PRIMARY KEY,
    nombre_destino VARCHAR(100) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    descripcion TEXT
);

-- Tabla: Paquetes Turísticos (Entidad Principal 2)
CREATE TABLE Paquetes (
    id_paquete INT AUTO_INCREMENT PRIMARY KEY,
    nombre_paquete VARCHAR(100) NOT NULL,
    id_destino INT NOT NULL,
    id_guia INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL, -- Cupos disponibles
    FOREIGN KEY (id_destino) REFERENCES Destinos(id_destino),
    FOREIGN KEY (id_guia) REFERENCES Guias(id_guia)
);

-- Tabla: Reservas (Transacción)
CREATE TABLE Reservas (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_paquete INT NOT NULL,
    fecha_reserva DATE NOT NULL,
    estado_reserva VARCHAR(30) NOT NULL, -- Ej: 'Pendiente', 'Confirmada', 'Cancelada'
    cantidad_personas INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_paquete) REFERENCES Paquetes(id_paquete)
);

-- Tabla: Pagos (Movimiento Económico asociado)
CREATE TABLE Pagos (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_reserva INT NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    fecha_pago DATE NOT NULL,
    metodo_pago VARCHAR(40) NOT NULL, -- Ej: 'Tarjeta', 'Transferencia', 'Efectivo'
    FOREIGN KEY (id_reserva) REFERENCES Reservas(id_reserva) ON DELETE CASCADE
);