---
title: 'Investigación: procesos ETL y ELT'
description: 'Cómo viajan los datos desde las fuentes hasta el almacén analítico y qué diferencia hay entre ETL y ELT.'
pubDate: 'Nov 21 2026'
category: 'Investigacion'
tags: ['etl', 'elt', 'pentaho']
author: 'Jhonatan Lozano'
---

## Contexto

Los datos que llegan a un Data Warehouse vienen de varias fuentes con formatos y calidades distintas. El proceso que los lleva hasta allí es el ETL. Notas: [notas_etl_dwh.txt](https://github.com/Ujonathan6/Ujonathan6.github.io/blob/main/scripts-bd2/03-nosql-mongodb/notas_etl_dwh.txt)

## ETL

1. **Extraer** de las fuentes.
2. **Transformar:** limpiar, unificar formatos, validar y calcular.
3. **Cargar** en el destino.

Se diseña un flujo con sus fuentes, reglas de limpieza y destino. En clase se mencionó **Pentaho** como herramienta.

## ELT

El orden cambia: se **extrae**, se **carga** tal cual en el destino y **después se transforma** dentro de él, aprovechando su capacidad de cómputo.

## Cuándo elegir cada uno

- **ETL:** cuando hay que depurar o proteger datos antes de que lleguen al destino, o el destino tiene poca capacidad.
- **ELT:** cuando el destino es potente (bodegas en la nube) y se quiere conservar el dato crudo para transformarlo de varias formas.

## Reflexión

Una idea de la clase que me quedó: las bases de datos no guardan información, guardan **datos**; la información aparece cuando se limpian, se relacionan y se analizan. Ahí es donde el ETL agrega valor.
