---
title: 'NoSQL: patrones de diseño de datos'
description: 'Los siete patrones vistos en clase explicados con mis palabras y cuándo usar cada uno.'
pubDate: 'Nov 18 2026'
category: 'NoSQL'
tags: ['mongodb', 'patrones', 'modelado']
author: 'Jhonatan Lozano'
---

## Contexto

Modelar en NoSQL se apoya en patrones reutilizables. En clase se enumeraron siete. Notas: [notas_patrones_nosql.txt](https://github.com/Ujonathan6/Ujonathan6.github.io/blob/main/scripts-bd2/03-nosql-mongodb/notas_patrones_nosql.txt)

## Los patrones

| Patrón | Idea | Cuándo usarlo |
|---|---|---|
| **Embebido** | Incluir los datos relacionados dentro del mismo documento | Se leen siempre juntos (un pedido y sus ítems) |
| **Referencia** | Guardar el identificador de otro documento | Los datos son compartidos o muy grandes; implica integridad referencial manual |
| **Atributo** | Convertir muchos campos parecidos en un arreglo de pares clave-valor | Atributos variables que se quieren indexar |
| **Polimórfico** | Documentos de formas distintas en una colección | Entidades parecidas con campos propios (productos de varias categorías) |
| **Bucket** | Agrupar datos de series de tiempo por lotes | Lecturas de sensores o eventos |
| **Cómputo** | Guardar resultados ya calculados | Cálculos costosos que se consultan mucho |
| **Subset** | Guardar en el documento principal solo los datos más usados | Un listing con sus últimas reseñas y no todas |

## Ejemplo en sample_airbnb

La colección `listingsAndReviews` aplica varios: la dirección está **embebida** como objeto, los servicios son un arreglo y las reseñas viven dentro del propio listing, en lugar de en una colección aparte (patrón embebido).

## Qué aprendí

No hay un patrón correcto en abstracto: embeber acelera lecturas pero hace crecer el documento (MongoDB limita su tamaño a 16 MB), y referenciar evita duplicados a costa de más consultas. La decisión depende de qué se lee junto y qué cambia con frecuencia.
