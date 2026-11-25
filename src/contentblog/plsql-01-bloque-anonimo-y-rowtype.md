---
title: 'PL/SQL: bloque anónimo, variables y %ROWTYPE'
description: 'De un SELECT a un programa: estructura DECLARE/BEGIN/END y tres formas de manejar las variables.'
pubDate: 'Nov 10 2026'
category: 'PLSQL'
tags: ['plsql', 'oracle', 'rowtype']
author: 'Jhonatan Lozano'
---

## Contexto

**Problema:** imprimir nombre, salario y fecha de contratación del empleado 100.

**Propósito:** aprender la estructura de un bloque PL/SQL y llevar el resultado de un `SELECT` a variables. Script: [01_bloque_anonimo_rowtype.sql](https://github.com/Ujonathan6/Ujonathan6.github.io/blob/main/scripts-bd2/02-plsql/01_bloque_anonimo_rowtype.sql)

## Estructura

`DECLARE` (variables), `BEGIN` (lógica) y `END;`. Para ver mensajes se activa `SET SERVEROUTPUT ON` y se usa `DBMS_OUTPUT.PUT_LINE`.

## Tres versiones, de menos a más robusta

1. **Tipos fijos:** `VARCHAR2(50)`, `NUMBER`, `DATE`.
2. **`%TYPE`:** la variable hereda el tipo de la columna (`HR.EMPLOYEES.FIRST_NAME%TYPE`).
3. **`%ROWTYPE`:** un solo registro con todas las columnas (`vrEmpleado HR.EMPLOYEES%ROWTYPE`), y se leen sus campos con `vrEmpleado.SALARY`.

Dejé las versiones anteriores comentadas en el script para ver la evolución.

## Convenciones

Usé prefijos para el tipo de cada variable (`vv` texto, `vn` número, `vd` fecha, `vr` registro) y un encabezado con autor, fecha y versión de cambios.

## Qué aprendí

`%TYPE` y `%ROWTYPE` hacen que el programa se adapte si cambia la tabla: si se amplía una columna, un `VARCHAR2(50)` fijo podría fallar y el tipo heredado no. Además, `SELECT ... INTO` exige que la consulta devuelva **exactamente una fila**.
