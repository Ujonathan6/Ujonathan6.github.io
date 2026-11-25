---
title: 'SQL: subconsultas y CTE recursiva'
description: 'Subconsultas escalares y con IN, y recorrido del organigrama con una CTE recursiva.'
pubDate: 'Nov 05 2026'
category: 'SQL'
tags: ['sql', 'subconsultas', 'cte', 'recursividad']
author: 'Jhonatan Lozano'
---

## Contexto

Script: [05_nulls_subconsultas_cte_ventanas.sql](https://github.com/Ujonathan6/Ujonathan6.github.io/blob/main/scripts-bd2/01-sql-avanzado/05_nulls_subconsultas_cte_ventanas.sql)

## Subconsultas

- **Correlacionada en el SELECT:** para cada empleado, cuántos compañeros tiene en su departamento (`SELECT COUNT(*) FROM employees c WHERE c.department_id = e.department_id`).
- **Con `IN`:** empleados cuyo departamento coincide con alguno donde trabaja alguien con apellido King.

## CTE recursiva: el organigrama

**Problema:** recorrer la jerarquía de gerentes desde quien no tiene jefe, indicando el nivel de cada empleado.

La CTE tiene dos partes unidas con `UNION ALL`: el **ancla** (empleados con `manager_id IS NULL`, nivel 1) y el **paso recursivo** (empleados cuyo gerente ya está en la jerarquía, nivel + 1). La cláusula `CYCLE ... SET es_ciclo` protege contra ciclos.

## El error de mi primer intento

Mi primera versión no funcionaba por tres razones: escribí mal el nombre de la tabla (`EMPOYEES`) y de una columna (`EMPLOYEED_ID`), y además repetí `WHERE MANAGER_ID IS NULL` en el paso recursivo, lo que cortaba la recursión. Dejé ambas versiones en el script, la original y la corrección.

## Qué aprendí

- El filtro del ancla **no se repite** en el paso recursivo.
- Una CTE hace la consulta legible: se lee de arriba abajo en lugar de anidar subconsultas.
- Una subconsulta correlacionada se ejecuta conceptualmente una vez por fila; cuando el volumen crece, conviene considerar un JOIN o una función de ventana.
