-- =====================================================================
-- PROYECTO: Sistema de Base de Datos para Agencia de Viajes
-- Archivo: 04_usuarios.sql
-- Descripción: Creación de usuarios de base de datos con distintos
--              niveles de permisos (administrador y docente/revisor).
-- =====================================================================

-- ---------------------------------------------------------------------
-- Usuario ADMIN
-- Permisos completos sobre la base de datos agencia_viajes
-- ---------------------------------------------------------------------
DROP USER IF EXISTS 'admin_agencia'@'localhost';
CREATE USER 'admin_agencia'@'localhost' IDENTIFIED BY 'AdminAgencia#2026';

GRANT ALL PRIVILEGES ON agencia_viajes.* TO 'admin_agencia'@'localhost';

-- ---------------------------------------------------------------------
-- Usuario DOCENTE
-- Permisos de solo lectura para revisión del proyecto
-- ---------------------------------------------------------------------
DROP USER IF EXISTS 'docente_agencia'@'localhost';
CREATE USER 'docente_agencia'@'localhost' IDENTIFIED BY 'DocenteRevisor#2026';

GRANT SELECT ON agencia_viajes.* TO 'docente_agencia'@'localhost';

-- ---------------------------------------------------------------------
-- Usuario OPERADOR (opcional)
-- Permisos intermedios: puede insertar y actualizar, pero no eliminar
-- estructuras ni tablas, pensado para el personal de la agencia.
-- ---------------------------------------------------------------------
DROP USER IF EXISTS 'operador_agencia'@'localhost';
CREATE USER 'operador_agencia'@'localhost' IDENTIFIED BY 'Operador#2026';

GRANT SELECT, INSERT, UPDATE ON agencia_viajes.* TO 'operador_agencia'@'localhost';
REVOKE DELETE, DROP, ALTER ON agencia_viajes.* FROM 'operador_agencia'@'localhost';

-- ---------------------------------------------------------------------
-- Aplicar los cambios de privilegios
-- ---------------------------------------------------------------------
FLUSH PRIVILEGES;

-- Para verificar los permisos otorgados a cada usuario:
-- SHOW GRANTS FOR 'admin_agencia'@'localhost';
-- SHOW GRANTS FOR 'docente_agencia'@'localhost';
-- SHOW GRANTS FOR 'operador_agencia'@'localhost';
