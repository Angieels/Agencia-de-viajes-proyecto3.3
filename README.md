# Sistema de Base de Datos — Agencia de Viajes

Proyecto de base de datos relacional para la gestión de una **Agencia de Viajes**, desarrollado en **MySQL**. El sistema administra clientes, destinos turísticos, paquetes, guías de turismo, reservas y pagos, aplicando normalización, integridad referencial y consultas SQL avanzadas.

---

## Descripción del proyecto

La agencia necesita controlar de forma ordenada:

- Los **clientes** que contratan viajes.
- Los **destinos** turísticos disponibles.
- Los **guías de turismo** asignados a cada paquete.
- Los **paquetes turísticos** ofrecidos (precio, cupos, fechas).
- Las **reservas** que hacen los clientes sobre esos paquetes.
- Los **pagos** asociados a cada reserva.

Este repositorio contiene el modelo de datos, los scripts SQL y la documentación necesaria para desplegar la base de datos completa.

---

## Estructura del repositorio

| N° | Archivo | Contenido |
|----|----------|-----------|
| 1 | `01_script_creacion.sql` | Sentencias `CREATE TABLE` con todas sus restricciones. |
| 2 | `02_script_insercion.sql` | `INSERT INTO` con al menos 10 registros por tabla. |
| 3 | `03_consultas.sql` | Las 20 consultas solicitadas con comentarios identificadores. |
| 4 | `04_usuarios.sql` | Scripts para crear los usuarios `admin` y `docente` con sus permisos. |
| 5 | `backup_agencia-viajes_angie.sql` | Backup completo de la base de datos en formato SQL. |
| 6 | `README.md` | Documentación completa del proyecto. |

---

## Modelo Entidad-Relación

**Entidades principales:**

- `clientes` — Entidad Principal 1
- `paquetes_turisticos` — Entidad Principal 2
- `reservas` — Transacción (vincula cliente y paquete)
- `pagos` — Pago/Movimiento (asociado a una reserva)

**Entidades de apoyo (catálogos):**

- `destinos`
- `guias_turismo`

### Diagrama Entidad-Relación (representación textual)

```
 clientes                     paquetes_turisticos                  destinos
+---------------+           +------------------------+          +------------------+
| id_cliente PK |           | id_paquete PK          |          | id_destino PK    |
| nombre        |           | nombre_paquete         |   N:1    | nombre_destino   |
| apellido      |           | id_destino FK  --------|--------->| pais             |
| dui           |           | id_guia FK     --------|----+     | ciudad           |
| email         |           | duracion_dias          |    |     | categoria        |
| telefono      |           | precio                 |    |     | descripcion      |
| ciudad        |           | cupo_maximo            |    |     +------------------+
| fecha_registro|           | cupo_disponible        |    |
+-------+-------+           | fecha_salida           |    |     guias_turismo
        | 1                 | estado                 |    |    +------------------+
        |                   +-----------+------------+    +--->| id_guia PK       |
        | N                             | 1                    | nombre           |
+-------v-------+                       | N                    | apellido         |
|   reservas    +<----------------------+                      | email            |
| id_reserva PK |                                               | telefono        |
| id_cliente FK |                                               | idiomas         |
| id_paquete FK |                                               | anios_experiencia|
| fecha_reserva |                                               +------------------+
| cantidad_pers.|
| total         |
| estado        |
+-------+-------+
        | 1
        |
        | N
+-------v-------+
|     pagos     |
| id_pago PK    |
| id_reserva FK |
| monto         |
| fecha_pago    |
| metodo_pago   |
| estado_pago   |
+---------------+
```

### Cardinalidades

| Relación | Cardinalidad |
|----------|--------------|
| `clientes` → `reservas` | 1 a N |
| `paquetes_turisticos` → `reservas` | 1 a N |
| `destinos` → `paquetes_turisticos` | 1 a N |
| `guias_turismo` → `paquetes_turisticos` | 1 a N |
| `reservas` → `pagos` | 1 a N |

---

## Integridad referencial

- `ON DELETE CASCADE` en `reservas.id_cliente` y `pagos.id_reserva`: si se elimina un cliente o una reserva, se eliminan sus registros dependientes.
- `ON DELETE RESTRICT` en `paquetes_turisticos.id_destino`, `paquetes_turisticos.id_guia` y `reservas.id_paquete`: evita eliminar destinos, guías o paquetes que ya tienen datos asociados.
- `ON UPDATE CASCADE` en todas las llaves foráneas: si cambia un ID referenciado, se actualiza automáticamente en las tablas hijas.
- Restricciones `CHECK` para validar precios positivos, cupos coherentes (`cupo_disponible <= cupo_maximo`), cantidades de personas mayores a 0 y montos de pago positivos.
- Restricciones `UNIQUE` en DUI y correo de clientes, correo de guías, y combinación destino/país.

---

## Usuarios de la base de datos

| Usuario | Permisos |
|---------|----------|
| `admin_agencia` | Control total sobre la base de datos. |
| `docente_agencia` | Solo lectura (`SELECT`), pensado para revisión del proyecto. |
| `operador_agencia` | `SELECT`, `INSERT`, `UPDATE` (sin permisos de borrado ni de modificar estructura). |

Ver detalle en `04_usuarios.sql`.

---

## Instalación y ejecución

1. Clonar el repositorio:
   ```bash
   git clone https://github.com/tu-usuario/agencia-viajes-db.git
   cd agencia-viajes-db
   ```

2. Ejecutar los scripts en orden desde la terminal de MySQL:
   ```bash
   mysql -u root -p < 01_script_creacion.sql
   mysql -u root -p < 02_script_insercion.sql
   mysql -u root -p < 04_usuarios.sql
   ```

3. Ejecutar las consultas de prueba:
   ```bash
   mysql -u root -p agencia_viajes < 03_consultas.sql
   ```

4. (Opcional) Restaurar desde el backup completo:
   ```bash
   mysql -u root -p < backup_agencia-viajes_angie.sql
   ```

---

## Tecnologías utilizadas

- **Motor de base de datos:** MySQL (InnoDB)
- **Lenguaje:** SQL
- **Control de versiones:** Git y GitHub

---

## Notas

- Todas las tablas están en **Tercera Forma Normal (3FN)**: sin dependencias transitivas ni datos repetidos innecesariamente.
- Las 20 consultas de `03_consultas.sql` cubren `INSERT`, `SELECT` con filtros, `UPDATE`, `DELETE`, `JOIN`, `LEFT JOIN`, funciones de agregación (`SUM`, `AVG`, `COUNT`), `HAVING` y subconsultas.

---

## Autoría

Proyecto desarrollado por **Angie** para la asignatura de Base de Datos — Técnico en Desarrollo de Software, Complejo Educativo República del Ecuador. Docente: Ing. Reina Díaz Morales.
