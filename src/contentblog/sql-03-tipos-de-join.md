---
title: 'SQL: INNER, LEFT, RIGHT, FULL, SELF, CROSS y NATURAL JOIN'
description: 'Comparación de todos los tipos de JOIN con el caso del empleado sin departamento.'
pubDate: 'Nov 03 2026'
category: 'SQL'
tags: ['sql', 'joins', 'oracle']
author: 'Jhonatan Lozano'
---

## Contexto

La clase 2 se dedicó a los JOINs. Trabajé con empleados y departamentos porque hay casos que obligan a pensar: un empleado sin departamento y departamentos sin empleados.

Scripts: [02_tipos_de_join.sql](https://github.com/Ujonathan6/Ujonathan6.github.io/blob/main/scripts-bd2/01-sql-avanzado/02_tipos_de_join.sql), [03_practica_inner_left_join.sql](https://github.com/Ujonathan6/Ujonathan6.github.io/blob/main/scripts-bd2/01-sql-avanzado/03_practica_inner_left_join.sql) y [04_practica_self_join_full_outer.sql](https://github.com/Ujonathan6/Ujonathan6.github.io/blob/main/scripts-bd2/01-sql-avanzado/04_practica_self_join_full_outer.sql).

## Resumen de cada tipo

- **INNER JOIN:** solo las coincidencias de ambas tablas.
- **LEFT / RIGHT JOIN:** todo lo de una tabla más las coincidencias de la otra.
- **FULL OUTER JOIN:** todo lo de ambas.
- **SELF JOIN:** una tabla unida consigo misma (empleado y su gerente).
- **CROSS JOIN:** producto cartesiano, cada fila con todas las demás.
- **NATURAL JOIN:** une automáticamente por columnas con el mismo nombre.

## Resultado y hallazgos

- Con `INNER JOIN` se pierde el único empleado sin departamento; con `LEFT JOIN` aparece con el departamento vacío. Lo comprobé con `WHERE department_id IS NULL` sobre la tabla original.
- El **LEFT JOIN exclusivo** (`... WHERE d.department_id IS NULL`) devuelve solo lo que no tiene pareja.
- En el self join, el `LEFT JOIN` permite que aparezca también quien no tiene gerente.
- La sintaxis antigua de Oracle con `(+)` equivale a un outer join, pero la anoté como "no replicar": es poco legible y no estándar.

## Qué aprendí

`NATURAL JOIN` es cómodo pero peligroso: si alguien agrega una columna con el mismo nombre en cualquiera de las tablas, la consulta cambia sin avisar. Prefiero `JOIN ... ON` o `USING`, donde la condición es explícita.
