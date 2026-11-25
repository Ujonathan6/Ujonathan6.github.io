-- Contexto: practica de indices, columnas virtuales y particionamiento en Oracle.
-- Trabaja sobre la tabla EMPLEADO (copia de HR.EMPLOYEES creada en la primera clase).

-- 1. Indice B-tree sobre el apellido y prueba del plan de ejecucion
CREATE INDEX idx_empleado_apellido ON EMPLEADO (last_name);

EXPLAIN PLAN FOR
SELECT * FROM EMPLEADO WHERE last_name = 'King';
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- 2. Indice basado en funciones: busqueda sin distinguir mayusculas
CREATE INDEX idx_empleado_apellido_upper ON EMPLEADO (UPPER(last_name));

EXPLAIN PLAN FOR
SELECT * FROM EMPLEADO WHERE UPPER(last_name) = 'KING';
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- 3. Columna virtual: se calcula, no se almacena
ALTER TABLE EMPLEADO ADD (salario_anual NUMBER GENERATED ALWAYS AS (salary * 12) VIRTUAL);
SELECT last_name, salary, salario_anual FROM EMPLEADO WHERE ROWNUM <= 5;

-- 4. Los B-tree no guardan filas con la columna indexada en NULL:
--    esta consulta no puede usar un indice B-tree simple sobre commission_pct
CREATE INDEX idx_empleado_comision ON EMPLEADO (commission_pct);

EXPLAIN PLAN FOR
SELECT * FROM EMPLEADO WHERE commission_pct IS NULL;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- 5. Particionamiento por rango de fechas (tabla nueva de ejemplo)
CREATE TABLE VENTAS_PART (
    id_venta NUMBER,
    fecha    DATE,
    valor    NUMBER
)
PARTITION BY RANGE (fecha) (
    PARTITION p_2025 VALUES LESS THAN (DATE '2026-01-01'),
    PARTITION p_2026 VALUES LESS THAN (DATE '2027-01-01'),
    PARTITION p_futuro VALUES LESS THAN (MAXVALUE)
);

-- Consultar una sola particion
SELECT * FROM VENTAS_PART PARTITION (p_2026);

-- Limpieza
DROP INDEX idx_empleado_apellido;
DROP INDEX idx_empleado_apellido_upper;
DROP INDEX idx_empleado_comision;
ALTER TABLE EMPLEADO DROP COLUMN salario_anual;
DROP TABLE VENTAS_PART;
