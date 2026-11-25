---
title: 'SQL: copias de tablas, vistas y JOINs de varias tablas'
description: 'Cómo se llega al continente de un empleado encadenando cinco tablas y guardando la consulta como una vista.'
pubDate: 'Nov 02 2026'
category: 'SQL'
tags: ['sql', 'vistas', 'joins', 'oracle']
author: 'Jhonatan Lozano'
---

## Contexto

**Problema:** listar los empleados que trabajan en Europa, con su salario y país.

**Propósito:** entender que no hay relación directa entre empleado y continente; hay que recorrer `empleado → departamento → ubicación → país → región`.

Script: [01_vistas_y_joins_europa.sql](https://github.com/Ujonathan6/Ujonathan6.github.io/blob/main/scripts-bd2/01-sql-avanzado/01_vistas_y_joins_europa.sql)

## Qué hice

1. Copié las tablas de HR a mi esquema con `CREATE TABLE ... AS SELECT` (`EMPLEADO`, `DEPARTAMENTOS`, `LOCACIONES`, `CONTINENTES`, `REGIONES`), para practicar sin tocar el esquema original.
2. Creé la vista `VW_EMPLEADO`, que muestra solo algunas columnas (con alias en español) de los departamentos 80, 90 y 100.
3. Creé `VW_EUROPEOS`, con cinco JOINs y el filtro `region_name = 'Europe'`.

## Resultado

Con `SELECT * FROM VW_EUROPEOS` obtengo nombre, apellido, salario y país sin volver a escribir la consulta.

## Qué aprendí

- Una vista **no guarda datos**, guarda la consulta; siempre muestra el estado actual de las tablas.
- Una vista sirve también para limitar qué columnas ve alguien.
- Trabajar sobre copias evita dañar el esquema de ejemplo.
