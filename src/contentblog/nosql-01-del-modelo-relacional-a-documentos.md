---
title: 'NoSQL: del modelo relacional a colecciones y documentos'
description: 'Equivalencias entre SQL y MongoDB y qué cambia al pensar los datos como documentos.'
pubDate: 'Nov 15 2026'
category: 'NoSQL'
tags: ['mongodb', 'nosql', 'modelado']
author: 'Jhonatan Lozano'
---

## Contexto

En MongoDB cambian los nombres y también la forma de pensar los datos. Trabajé con la base de ejemplo `sample_airbnb` (colección `listingsAndReviews`) en Atlas. Notas: [notas_operadores_mql.txt](https://github.com/Ujonathan6/Ujonathan6.github.io/blob/main/scripts-bd2/03-nosql-mongodb/notas_operadores_mql.txt)

## Equivalencias

| Relacional | MongoDB |
|---|---|
| Tabla | Colección |
| Fila | Documento (JSON/BSON) |
| Columna | Campo |
| JOIN | `$lookup` o documentos incrustados |
| `GROUP BY` | `$group` en un pipeline de agregación |

## Lo distinto de verdad

Un documento puede contener **objetos anidados y arreglos**. En un listing, la dirección es un objeto (`address.country`) y los servicios son un arreglo (`amenities`); en SQL harían falta tablas adicionales. Además, dos documentos de la misma colección pueden tener campos diferentes: no hay un esquema rígido.

## Cuándo conviene

Identificar qué tipo de base de datos le conviene a un proyecto fue una de las ideas de la clase: MongoDB encaja cuando los datos son flexibles y se leen juntos; el modelo relacional, cuando hay relaciones complejas e integridad estricta.

## Qué aprendí

- El modelado parte de **las consultas que hará la aplicación**, no de la normalización.
- Los tipos importan: en esta base el precio se guarda como decimal, y mezclar tipos al insertar afecta ordenamientos y cálculos.
- La unicidad de `_id` la garantiza el motor: insertar un duplicado produce el error `E11000`.
