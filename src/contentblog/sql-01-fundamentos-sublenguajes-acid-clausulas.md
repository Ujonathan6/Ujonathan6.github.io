---
title: 'SQL: sublenguajes, propiedades ACID y orden de las cláusulas'
description: 'Qué son DDL, DML, DCL y TCL, qué garantiza ACID y en qué orden se evalúa realmente una consulta SELECT.'
pubDate: 'Nov 01 2026'
category: 'SQL'
tags: ['sql', 'acid', 'fundamentos']
author: 'Jhonatan Lozano'
---

## Contexto

En la primera clase se presentó SQL como un lenguaje con cuatro grupos de sentencias y se dejó como tarea investigar el orden de las cláusulas. Este tema no tiene un script propio: es la base conceptual de todo lo demás.

## Los cuatro sublenguajes

| Grupo | Para qué sirve | Ejemplos |
|---|---|---|
| DDL (definición) | Crear y modificar objetos | `CREATE`, `ALTER`, `DROP` |
| DML (manipulación) | Trabajar con los datos | `INSERT`, `UPDATE`, `DELETE`, `SELECT` |
| DCL (control) | Dar y quitar privilegios | `GRANT`, `REVOKE` |
| TCL (transacciones) | Controlar transacciones | `COMMIT`, `ROLLBACK`, `SAVEPOINT` |

## ACID

Una transacción es confiable si cumple cuatro propiedades: **Atomicidad** (se hace todo o nada), **Consistencia** (la base pasa de un estado válido a otro), **Aislamiento** (transacciones simultáneas no se estorban) y **Durabilidad** (lo confirmado sobrevive a una caída).

## Orden de las cláusulas (la tarea de investigar)

En mis notas lo dejé pendiente porque el orden en que *se escribe* una consulta no es el orden en que *se evalúa*:

1. `FROM` / `JOIN`
2. `WHERE`
3. `GROUP BY`
4. `HAVING`
5. `SELECT`
6. `ORDER BY`

## Qué aprendí

Entender el orden lógico explica errores comunes: por qué un alias definido en el `SELECT` no se puede usar en el `WHERE` (todavía no existe), y por qué el filtro de grupos va en `HAVING` y no en `WHERE`.
