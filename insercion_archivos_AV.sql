-- =============================================================================
-- 2. SCRIPT DE INSERCIÓN DE DATOS (Mínimo 10 registros por tabla)
-- Archivo: 02_script_insercion.sql
-- =============================================================================

USE agencia_viajes;

-- Inserciones en Clientes (12 registros)
INSERT INTO Clientes (nombre, apellido, email, telefono, fecha_registro) VALUES
('Carlos', 'Mendoza', 'carlos.men@email.com', '+50371111111', '2026-01-10'),
('Ana', 'Gómez', 'ana.gomez@email.com', '+50372222222', '2026-01-15'),
('Luis', 'Martínez', 'luis.mar@email.com', '+50373333333', '2026-02-01'),
('Sofia', 'Rodríguez', 'sofia.rod@email.com', '+50374444444', '2026-02-12'),
('Diego', 'Alvarado', 'diego.alv@email.com', '+50375555555', '2026-03-01'),
('Elena', 'Vasquez', 'elena.vas@email.com', '+50376666666', '2026-03-15'),
('Fernando', 'Torres', 'fer.torres@email.com', '+50377777777', '2026-04-05'),
('Lucía', 'Peña', 'lucia.pena@email.com', '+50378888888', '2026-04-20'),
('Ricardo', 'Castro', 'ric.castro@email.com', '+50379999999', '2026-05-02'),
('Valeria', 'Mejía', 'val.mejia@email.com', '+50370000000', '2026-05-18'),
('Roberto', 'Sosa', 'roberto.sosa@email.com', '+50371234567', '2026-06-01'), -- Cliente sin reserva para Q14
('Gabriela', 'Pinto', 'gaby.pinto@email.com', '+50377654321', '2026-06-10'); -- Cliente sin reserva para Q14

-- Inserciones en Guias (10 registros)
INSERT INTO Guias (nombre, apellido, idioma, telefono, capacidad_max) VALUES
('Juan', 'Pérez', 'Español/Inglés', '+50361111111', 15),
('María', 'López', 'Español/Francés', '+50362222222', 12),
('Jorge', 'Ramírez', 'Español/Italiano', '+50363333333', 20),
('Patricia', 'Flores', 'Inglés/Alemán', '+50364444444', 10),
('Miguel', 'Hernández', 'Español', '+50365555555', 25),
('Laura', 'Benítez', 'Inglés/Portugués', '+50366666666', 15),
('Andrés', 'Guillén', 'Español/Inglés', '+50367777777', 18),
('Carmen', 'Rivas', 'Español/Japonés', '+50368888888', 8),
('Roberto', 'Díaz', 'Español/Inglés', '+50369999999', 30),
('Alicia', 'Monge', 'Francés/Italiano', '+50360000000', 14);

-- Inserciones en Destinos (10 registros)
INSERT INTO Destinos (nombre_destino, pais, descripcion) VALUES
('Machu Picchu', 'Perú', 'Antigua ciudadela inca en los Andes.'),
('París', 'Francia', 'La ciudad de la luz y la Torre Eiffel.'),
('Cancún', 'México', 'Playas de arena blanca y mar turquesa.'),
('Roma', 'Italia', 'Historia colonial, el Coliseo y el Vaticano.'),
('Tokio', 'Japón', 'Metrópolis moderna combinada con templos antiguos.'),
('Nueva York', 'EE.UU.', 'La gran manzana, Times Square y Central Park.'),
('Río de Janeiro', 'Brasil', 'Cristo Redentor y playas de Copacabana.'),
('El Tunco', 'El Salvador', 'Playa famosa por el surf y la vida nocturna.'),
('Barcelona', 'España', 'Arquitectura de Gaudí y playas del Mediterráneo.'),
('El Cairo', 'Egipto', 'Las pirámides milenarias de Giza y el Río Nilo.');

-- Inserciones en Paquetes (11 registros)
INSERT INTO Paquetes (nombre_paquete, id_destino, id_guia, precio, stock) VALUES
('Aventura Inca', 1, 1, 1200.00, 15),
('París Romántico', 2, 2, 2500.00, 10),
('Caribe Express', 3, 5, 850.00, 20),
('Roma Imperial', 4, 3, 1800.00, 12),
('Tokio Tecnológico', 5, 8, 3200.00, 8),
('Luces de NY', 6, 4, 1500.00, 14),
('Samba y Sol', 7, 6, 1100.00, 15),
('Surf en El Tunco', 8, 7, 450.00, 25),
('Arte en Barcelona', 9, 9, 1750.00, 10),
('Misterios de Egipto', 10, 10, 2100.00, 5),
('Paquete Fantasma', 3, 5, 999.00, 10); -- Paquete sin reservas para Q15

-- Inserciones en Reservas (11 registros)
INSERT INTO Reservas (id_cliente, id_paquete, fecha_reserva, estado_reserva, cantidad_personas) VALUES
(1, 1, '2026-01-12', 'Confirmada', 2),
(2, 2, '2026-01-20', 'Confirmada', 1),
(3, 3, '2026-02-05', 'Confirmada', 4),
(4, 4, '2026-02-18', 'Pendiente', 2),
(5, 5, '2026-03-05', 'Confirmada', 2),
(6, 6, '2026-03-20', 'Confirmada', 3),
(7, 7, '2026-04-10', 'Confirmada', 2),
(8, 8, '2026-04-25', 'Cancelada', 1),
(9, 9, '2026-05-10', 'Confirmada', 2),
(10, 10, '2026-05-25', 'Confirmada', 1),
(1, 3, '2026-06-02', 'Confirmada', 3); -- Segunda reserva de Carlos Mendoza para probar históricos y HAVING

-- Inserciones en Pagos (10 registros)
INSERT INTO Pagos (id_reserva, monto, fecha_pago, metodo_pago) VALUES
(1, 2400.00, '2026-01-12', 'Tarjeta de Crédito'),
(2, 2500.00, '2026-01-20', 'Transferencia'),
(3, 3400.00, '2026-02-05', 'Efectivo'),
(5, 6400.00, '2026-03-06', 'Tarjeta de Crédito'),
(6, 4500.00, '2026-03-21', 'Transferencia'),
(7, 2200.00, '2026-04-11', 'Tarjeta de Débito'),
(9, 3500.00, '2026-05-11', 'Transferencia'),
(10, 2100.00, '2026-05-26', 'Tarjeta de Crédito'),
(11, 2550.00, '2026-06-02', 'Efectivo'),
(4, 3600.00, '2026-02-19', 'Tarjeta de Crédito'); -- El pago de la reserva pendiente