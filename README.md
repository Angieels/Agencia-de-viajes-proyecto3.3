#  Proyecto de Base de Datos - Agencia de Viajes

Este repositorio contiene el diseño, implementación, población y consultas para el sistema de base de datos de una **Agencia de Viajes** desarrollado en **MySQL**. El proyecto cumple estrictamente con el esquema relacional requerido, restricciones de integridad y la guía de 20 consultas estandarizadas.

##  Estructura del Repositorio

De acuerdo con las pautas de entrega del proyecto, los archivos se organizan de la siguiente manera:

| N° | Archivo | Contenido |
|--- |--- |--- |
| **1** | `01_script_creacion.sql` | Sentencias `CREATE TABLE` con todas las llaves primarias, foráneas y restricciones relacionales. |
| **2** | `02_script_insercion.sql` | Sentencias `INSERT INTO` con un mínimo de 10 registros lógicos por tabla. |
| **3** | `03_consultas.sql` | Las 20 consultas del estándar de negocio solicitadas debidamente documentadas. |
| **4** | `04_usuarios.sql` | Creación de perfiles de usuario de Base de Datos (`admin_agencia` y `docente_agencia`) con sus respectivos privilegios. |
| **5** | `backup_agencia_viajes_nombre.sql` | Copia de seguridad completa (Backup estructurado) de la base de datos en formato SQL. |
| **6** | `README.md` | Documentación técnica del proyecto (Este archivo). |

---

##  Entidades del Modelo Relacional

La base de datos se compone de las siguientes tablas interconectadas:
*   **Clientes:** Registro de usuarios principales de la agencia.
*   **Destinos:** Lugares geográficos y turísticos que ofrece la agencia.
*   **Guías de Turismo:** Personal encargado de guiar los recorridos y su capacidad máxima.
*   **Paquetes Turísticos:** Oferta comercial que asocia un destino, un guía asignado, precio y cupos.
*   **Reservas:** Entidad transaccional que une al cliente con el paquete seleccionado.
*   **Pagos:** Control de flujos económicos y estados contables de cada reserva efectuada.

---

##  Instrucciones de Instalación y Uso

1.  **Clonar el repositorio:**
    ```bash
    git clone [https://github.com/TU_USUARIO/TU_REPOSITORIO.git](https://github.com/TU_USUARIO/TU_REPOSITORIO.git)
    cd TU_REPOSITORIO
    ```

2.  **Ejecutar los Scripts en MySQL:**
    *   Abre tu terminal o tu cliente gráfico de preferencia (MySQL Workbench, DBeaver, etc.).
    *   Ejecuta el archivo `01_script_creacion.sql` para generar la estructura.
    *   Ejecuta el archivo `02_script_insercion.sql` para poblar las tablas con los registros iniciales de prueba.

3.  **Probar las consultas:**
    *   El archivo `03_consultas.sql` contiene los 20 requerimientos de negocio listos para correr de manera secuencial o individual.
