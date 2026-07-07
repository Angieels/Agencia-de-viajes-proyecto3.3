-- =====================================================================
-- PROYECTO: Sistema de Base de Datos para Agencia de Viajes
-- Archivo: 03_consultas.sql
-- Descripción: Guía de 20 consultas estandarizadas aplicadas al
--              modelo de la Agencia de Viajes.
--
-- Mapeo de entidades usado en esta guía:
--   Entidad Principal 1  -> clientes
--   Entidad Principal 2  -> paquetes_turisticos
--   Transacción          -> reservas
--   Pago/Movimiento       -> pagos
-- =====================================================================

USE agencia_viajes;

-- 01 | INSERT | Insertar Entidad Principal 1
-- Agregar un nuevo registro a la tabla principal de clientes.
INSERT INTO clientes (nombre, apellido, dui, email, telefono, ciudad, fecha_registro)
VALUES ('Roberto', 'Peña', '07234561-3', 'roberto.pena@gmail.com', '7654-3210', 'San Salvador', CURRENT_DATE);

-- 02 | INSERT | Insertar Entidad Principal 2
-- Crear un nuevo registro en la tabla de paquetes turísticos.
INSERT INTO paquetes_turisticos (nombre_paquete, id_destino, id_guia, duracion_dias, precio, cupo_maximo, cupo_disponible, fecha_salida, estado)
VALUES ('Ruta Colonial Antigua + Cartagena', 6, 6, 5, 990.00, 20, 20, '2026-12-01', 'Activo');

-- 03 | INSERT | Insertar Transacción
-- Registrar una nueva reserva vinculada a un cliente y a un paquete.
INSERT INTO reservas (id_cliente, id_paquete, fecha_reserva, cantidad_personas, total, estado)
VALUES (11, 2, CURRENT_DATE, 2, 1700.00, 'Pendiente');

-- 04 | INSERT | Insertar Pago/Movimiento
-- Registrar un pago asociado a una reserva existente.
INSERT INTO pagos (id_reserva, monto, fecha_pago, metodo_pago, estado_pago)
VALUES (LAST_INSERT_ID(), 850.00, CURRENT_DATE, 'Tarjeta', 'Completado');

-- 05 | SELECT | Filtrar Entidad 1
-- Filtrar clientes por ciudad de residencia.
SELECT id_cliente, nombre, apellido, ciudad
FROM clientes
WHERE ciudad = 'San Salvador';

-- 06 | SELECT | Filtrar Entidad 2
-- Filtrar paquetes turísticos por rango de precio.
SELECT id_paquete, nombre_paquete, precio, estado
FROM paquetes_turisticos
WHERE precio BETWEEN 500 AND 1500;

-- 07 | SELECT | Transacciones por fechas
-- Obtener reservas realizadas en un rango de fechas usando BETWEEN.
SELECT id_reserva, id_cliente, id_paquete, fecha_reserva, total
FROM reservas
WHERE fecha_reserva BETWEEN '2026-06-01' AND '2026-06-15';

-- 08 | UPDATE | Actualizar atributo
-- Modificar el cupo disponible de un paquete turístico.
UPDATE paquetes_turisticos
SET cupo_disponible = cupo_disponible - 1
WHERE id_paquete = 2;

-- 09 | UPDATE | Cambiar estado
-- Actualizar el estado de una reserva a Confirmada.
UPDATE reservas
SET estado = 'Confirmada'
WHERE id_reserva = 5;

-- 10 | DELETE | Eliminar registro
-- Eliminar un registro de prueba usando DELETE WHERE.
DELETE FROM reservas
WHERE id_reserva = 13;

-- 11 | JOIN | Transacción + Entidad 1
-- Ver el detalle de la reserva junto con los datos del cliente.
SELECT r.id_reserva, c.nombre, c.apellido, r.fecha_reserva, r.total, r.estado
FROM reservas r
INNER JOIN clientes c ON r.id_cliente = c.id_cliente;

-- 12 | JOIN | Detalle Completo
-- INNER JOIN múltiple: reserva + cliente + paquete + destino.
SELECT r.id_reserva, c.nombre AS cliente, p.nombre_paquete, d.nombre_destino,
       r.cantidad_personas, r.total, r.estado
FROM reservas r
INNER JOIN clientes c            ON r.id_cliente = c.id_cliente
INNER JOIN paquetes_turisticos p ON r.id_paquete = p.id_paquete
INNER JOIN destinos d            ON p.id_destino = d.id_destino;

-- 13 | JOIN | Pagos + Transacciones
-- JOIN combinado para historial de pagos con detalle de la reserva.
SELECT pg.id_pago, r.id_reserva, c.nombre, pg.monto, pg.metodo_pago, pg.estado_pago
FROM pagos pg
INNER JOIN reservas r  ON pg.id_reserva = r.id_reserva
INNER JOIN clientes c  ON r.id_cliente = c.id_cliente;

-- 14 | LEFT JOIN | Entidad 1 sin transacciones
-- Listar clientes que nunca han generado una reserva.
SELECT c.id_cliente, c.nombre, c.apellido
FROM clientes c
LEFT JOIN reservas r ON c.id_cliente = r.id_cliente
WHERE r.id_reserva IS NULL;

-- 15 | LEFT JOIN | Entidad 2 sin transacciones
-- Listar paquetes turísticos que nunca han sido reservados.
SELECT p.id_paquete, p.nombre_paquete
FROM paquetes_turisticos p
LEFT JOIN reservas r ON p.id_paquete = r.id_paquete
WHERE r.id_reserva IS NULL;

-- 16 | AGG | Total de ingresos
-- Calcular el total recaudado usando SUM (solo pagos completados).
SELECT SUM(monto) AS total_ingresos
FROM pagos
WHERE estado_pago = 'Completado';

-- 17 | AGG | Promedio de montos
-- Calcular el ticket promedio de los pagos usando AVG.
SELECT AVG(monto) AS promedio_pago
FROM pagos;

-- 18 | AGG | Top Entidad 2
-- Obtener el "Top 3" de paquetes más reservados con COUNT + LIMIT.
SELECT p.id_paquete, p.nombre_paquete, COUNT(r.id_reserva) AS total_reservas
FROM paquetes_turisticos p
INNER JOIN reservas r ON p.id_paquete = r.id_paquete
GROUP BY p.id_paquete, p.nombre_paquete
ORDER BY total_reservas DESC
LIMIT 3;

-- 19 | HAVING | Clientes frecuentes
-- Listar clientes con más de 1 reserva (GROUP BY + HAVING).
SELECT c.id_cliente, c.nombre, c.apellido, COUNT(r.id_reserva) AS total_reservas
FROM clientes c
INNER JOIN reservas r ON c.id_cliente = r.id_cliente
GROUP BY c.id_cliente, c.nombre, c.apellido
HAVING COUNT(r.id_reserva) > 1;

-- 20 | Subconsulta | Mayor gasto
-- Encontrar el cliente con el mayor monto total gastado.
SELECT nombre, apellido, total_gastado
FROM (
    SELECT c.id_cliente, c.nombre, c.apellido, SUM(r.total) AS total_gastado
    FROM clientes c
    INNER JOIN reservas r ON c.id_cliente = r.id_cliente
    WHERE r.estado <> 'Cancelada'
    GROUP BY c.id_cliente, c.nombre, c.apellido
) AS gasto_por_cliente
ORDER BY total_gastado DESC
LIMIT 1;
