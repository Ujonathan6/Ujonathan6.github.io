---
title: 'SQL: funciones de ventana (acumulados, ROWS vs RANGE)'
description: 'Cómo calcular totales y acumulados sin colapsar las filas y qué diferencia hay entre ROWS y RANGE.'
pubDate: 'Nov 06 2026'
category: 'SQL'
tags: ['sql', 'window-functions', 'analitica']
author: 'Jhonatan Lozano'
---

## Contexto

Las funciones de ventana calculan sobre un conjunto de filas relacionadas **sin agruparlas**: cada fila conserva su detalle y recibe además un valor agregado. Scripts: [05_nulls_subconsultas_cte_ventanas.sql](https://github.com/Ujonathan6/Ujonathan6.github.io/blob/main/scripts-bd2/01-sql-avanzado/05_nulls_subconsultas_cte_ventanas.sql) y la práctica [01_sql_practica_hr.sql](https://github.com/Ujonathan6/Ujonathan6.github.io/blob/main/scripts-bd2/05-practica-nueva/01_sql_practica_hr.sql).

## Lo que hice en clase

1. **Total sobre un `GROUP BY`:** nómina por departamento junto con la nómina total de la empresa, usando `SUM(SUM(salary)) OVER ()`.
2. **Acumulado por salario** de los empleados del departamento 90, comparando dos formas:

```sql
SUM(salary) OVER (ORDER BY salary ROWS  BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)  -- acum_rows
SUM(salary) OVER (ORDER BY salary RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) -- acum_range
```

## ROWS vs RANGE

- `ROWS` acumula **fila por fila**.
- `RANGE` trata como un solo bloque las filas con el mismo valor del `ORDER BY`: si dos empleados ganan lo mismo, ambos reciben el mismo acumulado.

## Práctica nueva

Ejercicios que preparé para reforzar: ranking de los 3 mejores salarios por departamento con `DENSE_RANK() OVER (PARTITION BY ...)`, diferencia contra el empleado anterior con `LAG`, y promedio por departamento con `AVG(...) OVER (PARTITION BY ...)` como alternativa a una subconsulta correlacionada.

## Qué aprendí

`PARTITION BY` es como un `GROUP BY` que no elimina filas. Cuando hay empates, `RANK`, `DENSE_RANK` y `ROW_NUMBER` se comportan distinto, y hay que elegir según lo que se quiera mostrar.
