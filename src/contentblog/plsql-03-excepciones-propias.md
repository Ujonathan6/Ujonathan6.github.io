---
title: 'PL/SQL: excepciones propias y lo que aprendí al corregirlas'
description: 'Cómo avisar que un departamento no existe: mi intento fallido, el porqué y la solución.'
pubDate: 'Nov 12 2026'
category: 'PLSQL'
tags: ['plsql', 'excepciones', 'depuracion']
author: 'Jhonatan Lozano'
---

## Contexto

**Reto:** lanzar un error claro cuando el departamento consultado no existe. Script de clase: [02_cursor_explicito_parametrizado.sql](https://github.com/Ujonathan6/Ujonathan6.github.io/blob/main/scripts-bd2/02-plsql/02_cursor_explicito_parametrizado.sql) (segundo bloque) y solución en [02_plsql_practica.sql](https://github.com/Ujonathan6/Ujonathan6.github.io/blob/main/scripts-bd2/05-practica-nueva/02_plsql_practica.sql).

## Mi intento

Declaré una excepción propia (`departamento_no_existe EXCEPTION`), hice un primer `FETCH` y, si el cursor no encontraba nada, ejecutaba `RAISE departamento_no_existe`. La sección `EXCEPTION` mostraba el mensaje.

## Por qué no compilaba

Mezclé el primer `FETCH` (pensado solo para validar) con el ciclo: quedó un `EXIT WHEN` fuera de un `LOOP`, un `LOOP;` suelto y una fila leída que nunca se imprimía.

## La solución que adopté

Separar las dos tareas: **validar primero** contando las filas y **recorrer después**.

```sql
SELECT COUNT(*) INTO v_existe FROM EMPLEADO WHERE department_id = v_depto;
IF v_existe = 0 THEN
  DBMS_OUTPUT.PUT_LINE('El departamento no existe');
ELSE
  FOR r IN (SELECT ... FROM EMPLEADO WHERE department_id = v_depto) LOOP
    DBMS_OUTPUT.PUT_LINE(r.first_name || ' ' || r.last_name);
  END LOOP;
END IF;
```

El `FOR ... LOOP` abre, recorre y cierra el cursor solo.

## Qué aprendí

- Un `FETCH` de validación consume una fila; no es gratis mezclarlo con el ciclo principal.
- Validar antes de recorrer es más claro que detectar el caso vacío dentro del ciclo.
- Una excepción propia convierte una situación de negocio ("el departamento no existe") en un mensaje comprensible; para errores que deben llegar a la aplicación sirve `RAISE_APPLICATION_ERROR`.
