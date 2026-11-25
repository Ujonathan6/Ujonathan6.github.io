---
title: 'SQL: valores nulos, COUNT, AVG y la diferencia entre WHERE y ON'
description: 'Por qué NULL no se compara con igual, cómo lo tratan las funciones de grupo y qué cambia al filtrar en ON.'
pubDate: 'Nov 04 2026'
category: 'SQL'
tags: ['sql', 'null', 'joins']
author: 'Jhonatan Lozano'
---

## Contexto

Los valores nulos fueron una de las fuentes de errores más sutiles. Los ejercicios están en [05_nulls_subconsultas_cte_ventanas.sql](https://github.com/Ujonathan6/Ujonathan6.github.io/blob/main/scripts-bd2/01-sql-avanzado/05_nulls_subconsultas_cte_ventanas.sql).

## 1. NULL no es igual a nada

Un `CASE` con `NULL = NULL` y `NULL <> NULL` ninguna de las dos es verdadera: el resultado es desconocido y cae en el `ELSE`. Por eso se usa `IS NULL` / `IS NOT NULL`.

## 2. Funciones de grupo

```sql
SELECT COUNT(*) AS filas,
       COUNT(commission_pct) AS con_comision,
       AVG(commission_pct) AS prom_real
FROM HR.employees;
```

`COUNT(*)` cuenta filas, `COUNT(columna)` solo las no nulas, y `AVG` ignora los nulos. Comprobé que `SUM(x) / COUNT(x)` da lo mismo que `AVG(x)`: el promedio es solo entre quienes tienen comisión.

## 3. WHERE vs ON en un LEFT JOIN

En mi script lo marqué como "estudiar la diferencia". Con `LEFT JOIN` entre departamentos y empleados:

- `WHERE e.salary > 5000` filtra **después** de unir: los departamentos sin empleados quedan con salario nulo y desaparecen.
- `... ON d.department_id = e.department_id AND e.salary > 5000` filtra **antes** de unir: se conservan todos los departamentos.

## 4. Anti join

`LEFT JOIN ... WHERE e.employee_id IS NULL` devuelve los departamentos sin empleados.

## Qué aprendí

Ante una columna que admite nulos siempre debo decidir qué hacer con ellos (`IS NULL`, `NVL`, `COALESCE`). Y un filtro sobre la tabla "opcional" de un LEFT JOIN puede convertirlo, sin querer, en un INNER JOIN.
