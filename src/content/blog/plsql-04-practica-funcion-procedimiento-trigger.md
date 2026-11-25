---
title: 'PL/SQL: práctica con función, procedimiento y trigger'
description: 'Tres objetos almacenados nuevos sobre la tabla EMPLEADO: una función, un procedimiento con validaciones y un trigger.'
pubDate: 'Nov 13 2026'
category: 'PLSQL'
tags: ['plsql', 'funciones', 'procedimientos', 'triggers']
author: 'Jhonatan Lozano'
---

## Contexto

Para consolidar el tema preparé una práctica adicional sobre la tabla `EMPLEADO` (copia de `HR.EMPLOYEES`), de modo que no se modifique el esquema original. Script: [02_plsql_practica.sql](https://github.com/Ujonathan6/Ujonathan6.github.io/blob/main/scripts-bd2/05-practica-nueva/02_plsql_practica.sql)

## Los cuatro ejercicios

1. **Función `fn_salario_total`:** recibe un empleado y devuelve su salario más comisión; devuelve `NULL` si no existe (`NO_DATA_FOUND`).
2. **Procedimiento `sp_aumentar_salario`:** sube el salario de un departamento en un porcentaje. Valida que el porcentaje esté entre 0 y 30 y que el departamento tenga empleados (usa `SQL%ROWCOUNT`), y lanza `RAISE_APPLICATION_ERROR` con códigos propios.
3. **Cursor `FOR` con validación previa:** el reporte por departamento con el caso "no existe" resuelto.
4. **Trigger `trg_no_bajar_salario`:** `BEFORE UPDATE OF salary` que impide disminuir un salario comparando `:OLD` y `:NEW`.

## Resultado esperado

- La función con un empleado existente devuelve su total; con uno inexistente, `NULL`.
- Llamar al procedimiento con un porcentaje fuera de rango o un departamento vacío produce un error `ORA-20001` u `ORA-20002`.
- Un `UPDATE` que reduce el salario falla con `ORA-20010`.

## Qué aprendí

- La diferencia entre función (devuelve un valor y se usa dentro de un `SELECT`) y procedimiento (ejecuta una acción).
- El procedimiento debe terminar la transacción de forma controlada (`COMMIT` si todo salió bien, `ROLLBACK` si no).
- Un trigger permite imponer una regla de negocio en la base de datos, sin depender de que cada aplicación la respete.
