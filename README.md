# Sistema de Base de Datos — Agencia de Viajes

* **Estudiante:** Nicole Angelina Beltrán Ramírez
* **Propuesta elegida:** Agencia de Viajes (Propuesta N° [Ingresa aquí el número de tu propuesta])
* **Motor de base de datos utilizado:** PostgreSQL

Proyecto de base de datos relacional para la gestión de una **Agencia de Viajes**. El sistema administra clientes, destinos turísticos, paquetes, guías de turismo, reservas y pagos, aplicando normalización, integridad referencial y consultas SQL avanzadas.

---

## Descripción del proyecto

La agencia necesita controlar de forma ordenada:

* Los **clientes** que contratan viajes.
* Los **destinos** turísticos disponibles.
* Los **guías de turismo** asignados a cada paquete.
* Los **paquetes turísticos** ofrecidos (precio, cupos, fechas).
* Las **reservas** que hacen los clientes sobre esos paquetes.
* Los **pagos** asociados a cada reserva.

Este repositorio contiene el modelo de datos, los scripts SQL y la documentación necesaria para desplegar la base de datos completa.

---

## Estructura del repositorio

| N° | Archivo | Contenido |
|----|----------|-----------|
| 1 | `01_script_creacion.sql` | Sentencias `CREATE TABLE` con todas sus restricciones en PostgreSQL. |
| 2 | `02_script_insercion.sql` | `INSERT INTO` con al menos 10 registros por tabla. |
| 3 | `03_consultas.sql` | Las 20 consultas solicitadas con comentarios identificadores. |
| 4 | `04_usuarios.sql` | Scripts para crear los roles y usuarios correspondientes. |
| 5 | `backup_agencia-viajes_angie.sql` | Backup completo de la base de datos. |
| 6 | `README.md` | Documentación completa del proyecto. |

---

## Diagrama Entidad-Relación

*(Reemplaza la ruta de la imagen con el archivo de tu diagrama exportado)*

![Diagrama Entidad-Relación de la Agencia de Viajes](./ruta_a_tu_imagen_exportada.png)

---

## Normalización de la Base de Datos

El diseño de esta base de datos cumple con las reglas de normalización para garantizar la integridad de los datos y evitar redundancias:

* **Primera Forma Normal (1FN):** Todos los atributos son atómicos (indivisibles). No existen grupos repetidos ni arrays en las tablas. Por ejemplo, los datos del cliente (nombre, apellido, teléfono, email) están separados en columnas individuales.
* **Segunda Forma Normal (2FN):** Cumple con la 1FN y todos los atributos no clave dependen por completo de la clave primaria. En tablas como `reservas`, detalles como la `cantidad_pers` dependen directamente del `id_reserva` y no de una parte de la clave.
* **Tercera Forma Normal (3FN):** Cumple con la 2FN y no existen dependencias transitivas entre los atributos no clave. Por ejemplo, la información detallada del país y ciudad se almacena en la tabla `destinos` (catálogo) y no directamente en `paquetes_turisticos`, vinculándose únicamente mediante su clave foránea `id_destino`.

---

## Tabla comparativa de usuarios y permisos

| Usuario / Rol | Permisos Asignados | Propósito |
|---------|----------|-----------|
| `admin_agencia` | `ALL PRIVILEGES` | Control total sobre la base de datos (crear, alterar, eliminar tablas y datos). |
| `docente_agencia` | `SELECT` en todas las tablas | Solo lectura, pensado para la revisión y calificación del proyecto. |
| `operador_agencia` | `SELECT`, `INSERT`, `UPDATE` | Uso operativo diario. No tiene permisos de borrado (`DELETE`) ni de alterar la estructura (`ALTER`). |

---

## Instrucciones de ejecución (Scripts en orden)

Asegúrate de tener instalado PostgreSQL y configurado en tus variables de entorno. 

1. Clona este repositorio y abre una terminal en la carpeta del proyecto.
2. Inicia sesión en PostgreSQL con tu superusuario (usualmente `postgres`):
   ```bash
   psql -U postgres
