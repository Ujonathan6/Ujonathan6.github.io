---
title: 'NoSQL: práctica con operadores avanzados y agregaciones'
description: 'Ocho ejercicios de solo lectura sobre sample_airbnb con $or, $all, $elemMatch, $addFields y $facet.'
pubDate: 'Nov 19 2026'
category: 'NoSQL'
tags: ['mongodb', 'practica', 'aggregate']
author: 'Jhonatan Lozano'
---

## Contexto

Práctica adicional, de solo lectura (`find` y `aggregate`), para no modificar la colección. Script: [03_mongodb_practica.js](https://github.com/Ujonathan6/Ujonathan6.github.io/blob/main/scripts-bd2/05-practica-nueva/03_mongodb_practica.js)

## Los ocho ejercicios

1. `$or`: listings baratos (menos de 50) o muy reseñados (más de 30).
2. `$all`: listings que tengan Wifi, Kitchen **y** Heating a la vez.
3. `$elemMatch`: listings con una reseña de un reviewer concreto dentro de un arreglo de objetos.
4. `$nin` y `$exists`: tipos de propiedad distintos de House y Apartment que tengan rating.
5. `$addFields` y `$divide`: precio por huésped, ordenado de menor a mayor.
6. `$group` por país y tipo, y `$match` posterior para quedarse con grupos de 50 o más.
7. `$facet`: conteo por tipo y precio promedio global en una sola consulta.
8. Anfitriones con más listings (`$group` por `host.host_id`).

## Resultado esperado

Cada consulta devuelve documentos proyectados o grupos ordenados según el criterio. Si un campo no existe en algún documento, esa fila simplemente no entra en el resultado.

## Qué aprendí

- `$all` exige todos los elementos; `$in` basta con uno.
- `$elemMatch` es necesario cuando varias condiciones deben cumplirse **sobre el mismo elemento** del arreglo.
- `$facet` ahorra recorridos cuando se necesitan varios resúmenes de la misma colección.
