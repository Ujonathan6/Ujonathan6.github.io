---
title: 'SQL: índices, particionamiento y columnas virtuales (investigación)'
description: 'Qué tipos de índice y de particionamiento ofrece Oracle, qué es una columna virtual y por qué un B-tree ignora los nulos.'
pubDate: 'Nov 08 2026'
category: 'SQL'
tags: ['indices', 'particionamiento', 'oracle', 'investigacion']
author: 'Jhonatan Lozano'
---

## Contexto

En la clase 4 quedaron tres preguntas abiertas: qué tipos de particionamiento existen, qué es una columna virtual y qué tipos de índices ofrece el motor. Esta entrada es mi investigación. Script de práctica: [04_sql_indices_particionamiento.sql](https://github.com/Ujonathan6/Ujonathan6.github.io/blob/main/scripts-bd2/05-practica-nueva/04_sql_indices_particionamiento.sql).

## Índices

| Tipo | Uso típico |
|---|---|
| B-tree (el predeterminado) | Búsquedas por igualdad y rango con muchos valores distintos |
| Bitmap | Columnas con pocos valores distintos (estado, sexo), sobre todo en analítica |
| Basado en funciones | Consultas que filtran por una expresión, como `UPPER(last_name)` |
| Compuesto | Filtros por varias columnas a la vez |
| Único | Garantiza que no haya duplicados |

**Dato de clase:** un índice B-tree no almacena las filas donde todas las columnas indexadas son nulas, así que `WHERE columna IS NULL` no puede aprovecharlo. Para eliminar un índice: `DROP INDEX nombre_indice;`.

## Particionamiento

Dividir una tabla grande en partes más pequeñas: por **rango** (fechas), por **lista** (valores concretos como región), por **hash** (reparto uniforme) o **compuesto** (combinación). Ayuda a consultar solo la partición relevante y a mantener los datos por tramos.

## Columna virtual

Una columna cuyo valor se calcula a partir de una expresión y **no se almacena**:

```sql
ALTER TABLE EMPLEADO ADD (salario_anual NUMBER GENERATED ALWAYS AS (salary * 12) VIRTUAL);
```

Se puede indexar (equivale a un índice basado en funciones) y usar como clave de partición.

## Qué aprendí

Un índice acelera lecturas pero encarece las escrituras y ocupa espacio; no se crea uno por cada columna. La decisión depende de las consultas reales, y el plan de ejecución es la forma de comprobarla.
