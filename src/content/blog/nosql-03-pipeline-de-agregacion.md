---
title: 'NoSQL: pipeline de agregación'
description: 'Cómo encadenar $match, $unwind, $group, $sort y $limit para analizar datos en MongoDB.'
pubDate: 'Nov 17 2026'
category: 'NoSQL'
tags: ['mongodb', 'aggregate', 'pipeline']
author: 'Jhonatan Lozano'
---

## Contexto

El pipeline de agregación es el equivalente analítico del `GROUP BY` de SQL: una lista de etapas donde la salida de cada una es la entrada de la siguiente. Práctica: [03_mongodb_practica.js](https://github.com/Ujonathan6/Ujonathan6.github.io/blob/main/scripts-bd2/05-practica-nueva/03_mongodb_practica.js)

## Etapas principales

| Etapa | Qué hace | Equivalente SQL |
|---|---|---|
| `$match` | Filtra documentos | `WHERE` / `HAVING` |
| `$group` | Agrupa y calcula (`$sum`, `$avg`) | `GROUP BY` |
| `$unwind` | Convierte un arreglo en un documento por elemento | Una fila por elemento |
| `$sort`, `$limit` | Ordena y recorta | `ORDER BY`, `FETCH FIRST` |
| `$project`, `$addFields` | Selecciona o calcula campos | `SELECT` |
| `$facet` | Varias agregaciones en una consulta | Varias consultas |

## Ejemplo: los servicios más comunes

```js
db.listingsAndReviews.aggregate([
  { $unwind: "$amenities" },
  { $group: { _id: "$amenities", frecuencia: { $sum: 1 } } },
  { $sort: { frecuencia: -1 } },
  { $limit: 5 }
])
```

Se expande el arreglo, se cuenta cada servicio, se ordena de mayor a menor y se toman cinco.

## Otras consultas de práctica

Precio por huésped con `$addFields` y `$divide`; cantidad y rating promedio por país y tipo, filtrando con un segundo `$match` después del `$group` (como un `HAVING`); y anfitriones con más listings.

## Qué aprendí

- El **orden de las etapas** cambia el resultado y el rendimiento: conviene filtrar con `$match` lo antes posible.
- Un `$match` después de un `$group` actúa sobre los grupos, igual que `HAVING`.
- `$unwind` multiplica los documentos, así que antes de agrupar hay que tener claro qué se está contando.
