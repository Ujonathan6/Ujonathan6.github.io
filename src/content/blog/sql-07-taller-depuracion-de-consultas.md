---
title: 'SQL: taller de depuración de consultas defectuosas'
description: 'Revisión de consultas que funcionan pero responden mal: JOINs, NULL, empates y promedios.'
pubDate: 'Nov 07 2026'
category: 'SQL'
tags: ['sql', 'depuracion', 'taller']
author: 'Jhonatan Lozano'
---

## Contexto

El taller de SQL propuso bloques temáticos (casos borde, JOINs, nulos, agregación, subconsultas, conjuntos, CTE y ventanas) y un bloque final de **depuración**: consultas que se ejecutan sin error pero pueden dar un resultado engañoso. Script: [06_taller_depuracion_consultas.sql](https://github.com/Ujonathan6/Ujonathan6.github.io/blob/main/scripts-bd2/01-sql-avanzado/06_taller_depuracion_consultas.sql).

## Casos que revisé

1. **Contar empleados por departamento.** `LEFT JOIN` más `COUNT(e.employee_id)` (no `COUNT(*)`) para que un departamento vacío muestre 0.
2. **Filtrar con `IN` y nulos.** `department_id IN (10, 20, 30)` nunca devuelve los empleados sin departamento; hay que agregar `OR department_id IS NULL` si se quieren incluir.
3. **Filtro en el `ON` de un segundo JOIN.** La condición `l.country_id = 'US'` en el `ON` de un LEFT JOIN no elimina departamentos: solo deja vacías las columnas de ubicación. Si la intención era filtrar departamentos, está mal ubicada.
4. **Máximo salario por departamento.** El JOIN contra una subconsulta con `MAX(salary)` devuelve a **todos** los empleados que empatan en el máximo, no solo a uno.
5. **Promedio de comisión.** `AVG(commission_pct)` ignora los nulos, así que no es el promedio de toda la plantilla.

## Inventario de departamentos

Un reporte con ciudad, país, cantidad de empleados y salario promedio por departamento: `INNER JOIN` para ubicación y país, y `LEFT JOIN` hacia empleados para conservar los departamentos vacíos.

## Qué aprendí

Una consulta correcta sintácticamente puede contestar otra pregunta distinta. Hay que verificar el resultado contra un conteo conocido y pensar en empates, nulos y filas sin pareja.

Los bloques A a H del taller todavía están pendientes de completar en mi script.
