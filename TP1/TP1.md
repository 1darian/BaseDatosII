#### Puntos: 
[1](#1) [2](#2) [3](#3) [4](#4) [5](#5) [6](#6) [7](#7) [8](#8)
#### 1. 
<p> Al agregar una Tabla intermedia (AlumnosMatriculados) solo se representarían entradas y datos validos. 
Cada fila está obligada, por la FK, a apuntar a un alumno existente y a una materia existente. </p>
<img src="img/Tablas1.png">
<p> El problema se soluciona ya que la base de datos evita que borres un alumno si hay alguna fila en AlumnosMatriculados que lo referencie. 
Se utiliza la Normalización para separar la relación en su propia tabla evita repetir datos de alumno o materia en cada inscripción.
</p>

```sql
    CREATE TABLE Matricula (
    id INT AUTO_INCREMENT,
    id_alumno INT,
    id_materia INT,
    PRIMARY KEY (id),
    FOREIGN KEY (id_alumno) REFERENCES Alumnos(id_alumno) ON DELETE CASCADE, -- Agrega ON DELETE CASCADE a la FK de alumno para eliminar inscripciones al borrar un alumno
    FOREIGN KEY (id_materia) REFERENCES Materias(id_materia)
);

```

### 2. 

<p> Al crear la tabla Materias, Alumnos y Matricula con las respectivas restricciones: </p>

<img src="img/tablas.png" width="200px"> 

<p>Y luego ejecutar el siguiente script: </p>


```sql
    INSERT INTO Matriculas (id,id_alumno,id_materia) VALUES (1, 2, 1);
```

<p> Se obtiene el siguiente error: </p>

<img src="img/ErrorConstraint.png">

### 3.

## Preparación de la Base de Datos

```sql
CREATE TABLE cuentas (
  id    INT AUTO_INCREMENT PRIMARY KEY,
  saldo DECIMAL(10,2) NOT NULL
);

INSERT INTO cuentas (saldo) VALUES (500.00);
```

## Escenario: Retiro Concurrente de 100 por T1 y T2

### A) READ COMMITTED

```sql
-- Configuración para ambas sesiones
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;

-- Transacción T1
SELECT saldo FROM cuentas WHERE id=1;  -- Lee 500
UPDATE cuentas SET saldo = saldo - 100 WHERE id=1;
COMMIT;

-- Transacción T2 (ejecutada concurrentemente)
SELECT saldo FROM cuentas WHERE id=1;  -- Lee 500 también
UPDATE cuentas SET saldo = saldo - 100 WHERE id=1;
COMMIT;
```

**Resultado final**: 400  
**Anomalía detectada**: **Lost Update** (uno de los retiros "se pierde")

### B) SERIALIZABLE

```sql
-- Configuración para ambas sesiones
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
START TRANSACTION;

-- Transacción T1
SELECT saldo FROM cuentas WHERE id=1;  -- Lee 500
UPDATE cuentas SET saldo = saldo - 100 WHERE id=1;
COMMIT;

-- Transacción T2
-- Su SELECT queda bloqueado hasta que T1 haga COMMIT
SELECT saldo FROM cuentas WHERE id=1;  -- Ahora lee 400
UPDATE cuentas SET saldo = saldo - 100 WHERE id=1;
COMMIT;
```

**Resultado final**: 300  
**Comportamiento**: T2 espera, lee el saldo actualizado y aplica su retiro correctamente.

## Comparativa de Niveles de Aislamiento

| Nivel de Aislamiento | Saldo Final | Anomalía | Características |
|----------------------|-------------|----------|-----------------|
| READ COMMITTED       | 400         | Lost Update | Mayor concurrencia, posible pérdida de actualizaciones |
| SERIALIZABLE         | 300         | Ninguna    | Menor concurrencia (usa bloqueos), garantiza consistencia secuencial |

### Conclusiones

- **READ COMMITTED**: Proporciona mayor concurrencia pero permite anomalías como la pérdida de actualizaciones.
- **SERIALIZABLE**: Ofrece menor concurrencia debido a los bloqueos, pero garantiza la consistencia como si las transacciones se ejecutaran secuencialmente.

### 4.
## Creación de la Base de Datos y Tablas

```sql
CREATE TABLE datosMasivos (
    id INT,
    nombre VARCHAR(10)
);
```
Script python que crea los datos masivos en un .csv:

```python
import pandas as pd
import random

# Lista de posibles nombres (cada uno <= 10 caracteres para caber en VARCHAR(10))
nombres = ['Ana', 'Luis', 'Carlos', 'María', 'Jorge', 'Sofía', 'Pablo', 'Elena', 'Diego', 'Lucía']

# Número de registros
N = 100_000

# Generar los datos
data = {
    'id': range(1, N+1),
    'nombre': [ random.choice(nombres) for _ in range(N) ]
}

df = pd.DataFrame(data)

# Exportar a CSV sin índice, listo para cargar en la tabla DatosMasivos
df.to_csv('datos_100k.csv', index=False)
```

Luego de importar el .CSV en la tabla creada y ejecutar:

```sql
EXPLAIN SELECT * FROM datosMasivos WHERE nombre = 'Ana';
```

Se obtiene como resultado:

<img src="img/EXPLAIN.png">

### 5.

### 6.

## I. Creación de Tablas Base

Primero creamos las estructuras fundamentales para almacenar nuestros datos.

### Tabla de Productos

```sql
CREATE TABLE Productos (
    producto_id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    categoria VARCHAR(50)
);
```

### Tabla de Ventas

```sql
CREATE TABLE Ventas (
    venta_id INT PRIMARY KEY,
    producto_id INT,
    cantidad INT NOT NULL,
    fecha_venta DATE NOT NULL,
    FOREIGN KEY (producto_id) REFERENCES Productos(producto_id)
);
```

## II. Creación de la Vista de Ventas Mensuales

Ahora creamos una vista que nos permite analizar los datos de ventas agrupados por mes.

```sql
CREATE VIEW VentasMensualesPorProducto AS
SELECT 
    p.producto_id,
    p.nombre AS nombre_producto,
    EXTRACT(YEAR FROM v.fecha_venta) AS año,
    EXTRACT(MONTH FROM v.fecha_venta) AS mes,
    SUM(v.cantidad) AS total_vendido,
    SUM(v.cantidad * p.precio) AS importe_total
FROM 
    Productos p
JOIN 
    Ventas v ON p.producto_id = v.producto_id
GROUP BY 
    p.producto_id, p.nombre, EXTRACT(YEAR FROM v.fecha_venta), EXTRACT(MONTH FROM v.fecha_venta)
ORDER BY 
    EXTRACT(YEAR FROM v.fecha_venta), EXTRACT(MONTH FROM v.fecha_venta), total_vendido DESC;
```

## III. Consulta de los 5 Productos Más Vendidos

```sql
SELECT 
    p.producto_id,
    p.nombre AS nombre_producto,
    SUM(v.cantidad) AS total_vendido,
    SUM(v.cantidad * p.precio) AS importe_total
FROM 
    Productos p
JOIN 
    Ventas v ON p.producto_id = v.producto_id
GROUP BY 
    p.producto_id, p.nombre
ORDER BY 
    total_vendido DESC
LIMIT 5;
```

### 7.
Creacion de usuario analista que solo puede hacer uso de SELECT, puede hacer solo uso de lectura.

```sql
Create user 'analista'@'%' IDENTIFIED BY 'contrasenia123';

GRANT SELECT ON BaseDatosII.* TO 'analista'@'%';

FLUSH PRIVILEGES;

```

### 8.

Creacion de tablas de productos

```sql
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    email VARCHAR(100),
    telefono VARCHAR(20),
    fecha_registro DATE
);
```
```sql
-- Tabla de auditoría
CREATE TABLE auditoria_clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    accion VARCHAR(10),
    cliente_id INT,
    datos_viejos JSON,
    datos_nuevos JSON,
    usuario VARCHAR(50),
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

Creacion del trigger DELETE
```sql
DELIMITER $$
CREATE TRIGGER t_auditoria_clientes_delete
BEFORE DELETE ON clientes
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_clientes (
        accion,
        cliente_id,
        datos_viejos,
        datos_nuevos,
        usuario
    ) VALUES (
        'DELETE',
        OLD.id,
        JSON_OBJECT('nombre', OLD.nombre, 'email', OLD.email, 'telefono', OLD.telefono, 'fecha_registro', OLD.fecha_registro),
        NULL,
        CURRENT_USER()
    );
END$$
DELIMITER ;
```

### 9.

# Backup y Restauración en MySQL

## 1. Backup completo (Dump)

### Backup de una base de datos específica
```bash
mysqldump -u TU_USUARIO -p NOMBRE_BASE_DE_DATOS > backup_completo.sql
```

### Backup de todas las bases de datos
```bash
mysqldump -u TU_USUARIO -p --all-databases > backup_full.sql
```

## 2. Restauración desde un archivo de respaldo

```bash
mysql -u TU_USUARIO -p NOMBRE_BASE_DE_DATOS < backup_completo.sql
```

## 3. Simulación de pérdida de datos y recuperación

1. **Borrar datos** (por error o intencionalmente):
   ```sql
   DELETE FROM tabla WHERE condición;
   DROP TABLE nombre_tabla;
   ```

2. **Restaurar** desde el archivo de respaldo:
   ```bash
   mysql -u TU_USUARIO -p NOMBRE_BASE_DE_DATOS < backup_completo.sql
   ```

3. **Verificar** que la información haya vuelto correctamente:
   ```sql
   SELECT COUNT(*) FROM tabla;
   SHOW TABLES;
   ```