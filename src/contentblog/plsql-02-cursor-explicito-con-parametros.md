---
title: 'PL/SQL: cursor explícito con parámetros'
description: 'Recorrer los empleados de un departamento con OPEN, FETCH, LOOP y CLOSE.'
pubDate: 'Nov 11 2026'
category: 'PLSQL'
tags: ['plsql', 'cursores', 'oracle']
author: 'Jhonatan Lozano'
---

## Contexto

**Problema:** listar los empleados de un departamento con el nombre de su gerente, su sueldo y el sueldo más comisión.

**Propósito:** procesar varias filas una por una, algo que un `SELECT ... INTO` no permite. Script: [02_cursor_explicito_parametrizado.sql](https://github.com/Ujonathan6/Ujonathan6.github.io/blob/main/scripts-bd2/02-plsql/02_cursor_explicito_parametrizado.sql)

## Cómo lo resolví

Declaré un cursor que recibe el número de departamento como parámetro y lo recorrí con el ciclo clásico:

```sql
OPEN cursor_80_90(80);
LOOP
  FETCH cursor_80_90 INTO nombre_empleado, nombre_manager, sueldo, salario_mas_comision;
  EXIT WHEN cursor_80_90%NOTFOUND;
  DBMS_OUTPUT.PUT_LINE(nombre_empleado || '  ' || nombre_manager);
END LOOP;
CLOSE cursor_80_90;
```

## Detalles que importan

- El `LEFT JOIN` hacia el gerente evita perder al empleado que no tiene jefe.
- `NVL(commission_pct, 0)` evita que el sueldo más comisión sea `NULL` cuando no hay comisión.
- `EXIT WHEN %NOTFOUND` va **justo después del `FETCH`**; si va antes de procesar, se saltaría o repetiría una fila.

## Qué aprendí

Un cursor explícito da control total (abrir, leer, cerrar) y admite parámetros, lo que lo hace reutilizable para cualquier departamento. A cambio, hay que acordarse del `CLOSE`.
