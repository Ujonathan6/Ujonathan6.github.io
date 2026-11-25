---
title: 'NoSQL: operadores de consulta de MQL'
description: 'Los operadores de comparación, lógicos, de elemento y de arreglos de MongoDB con ejemplos.'
pubDate: 'Nov 16 2026'
category: 'NoSQL'
tags: ['mongodb', 'mql', 'find', 'operadores']
author: 'Jhonatan Lozano'
---

## Contexto

MQL es el lenguaje de consultas de MongoDB. En clase revisamos la lista completa de operadores de predicado; la agrupé por familias. Notas: [notas_operadores_mql.txt](https://github.com/Ujonathan6/Ujonathan6.github.io/blob/main/scripts-bd2/03-nosql-mongodb/notas_operadores_mql.txt) y práctica [03_mongodb_practica.js](https://github.com/Ujonathan6/Ujonathan6.github.io/blob/main/scripts-bd2/05-practica-nueva/03_mongodb_practica.js).

## Familias

- **Comparación:** `$eq`, `$ne`, `$gt`, `$gte`, `$lt`, `$lte`, `$in`, `$nin`.
- **Lógicos:** `$and`, `$or`, `$not`, `$nor`.
- **Elemento:** `$exists`, `$type`.
- **Arreglos:** `$all`, `$size`, `$elemMatch`.
- **Evaluación:** `$regex`, `$expr`, `$mod`, `$jsonSchema`.
- **Geoespaciales y de bits:** `$near`, `$geoWithin`, `$bitsAllSet`, entre otros.

## Ejemplos que practiqué

```js
db.listingsAndReviews.find({ beds: { $gt: 5 } }, { name: 1, number_of_reviews: 1, _id: 0 })
db.listingsAndReviews.find({ property_type: { $in: ["House", "Condominium"] } })
db.listingsAndReviews.find({ name: { $regex: "Luxury", $options: "i" } })
db.listingsAndReviews.find({ amenities: "Heating" })
```

## Detalles no obvios

1. `{ campo: null }` devuelve los documentos donde el campo es nulo **o no existe**.
2. Filtrar un arreglo con `{ amenities: "Heating" }` ya busca dentro del arreglo.
3. `$and` explícito solo hace falta cuando se repite el mismo campo; con campos distintos basta separarlos con comas.
4. Para campos anidados se usa notación de punto entre comillas: `"address.country"`.

## Qué aprendí

La proyección (el segundo argumento de `find`) equivale al `SELECT` de SQL, y `sort` y `limit` al `ORDER BY` y `FETCH FIRST`. Con eso se cubren casi todas las consultas del día a día.
