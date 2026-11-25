---
title: 'Investigación: Data Warehouse y modelos estrella y copo de nieve'
description: 'Por qué existe una bodega de datos y cómo se organizan sus tablas.'
pubDate: 'Nov 20 2026'
category: 'Investigacion'
tags: ['data-warehouse', 'modelo-estrella', 'olap']
author: 'Jhonatan Lozano'
---

## Contexto

Una base de datos transaccional (**OLTP**) está optimizada para registrar operaciones rápido y sin errores. Analizar la historia del negocio sobre ella es lento y la puede afectar. Por eso se usa un **Data Warehouse (DWH)**, una bodega de datos integrada e histórica que alimenta reportes y Business Intelligence. Notas: [notas_etl_dwh.txt](https://github.com/Ujonathan6/Ujonathan6.github.io/blob/main/scripts-bd2/03-nosql-mongodb/notas_etl_dwh.txt)

## Modelos de organización

- **Estrella:** una tabla de **hechos** (ventas, pagos) en el centro, rodeada de tablas de **dimensiones** (tiempo, cliente, producto). Pocas uniones, consultas rápidas y simples.
- **Copo de nieve:** las dimensiones se normalizan en subdimensiones (producto → categoría). Ahorra espacio y evita redundancia, pero exige más JOINs.

## Diferencias frente a OLTP

| | OLTP | DWH |
|---|---|---|
| Objetivo | Operar el negocio | Analizarlo |
| Datos | Actuales | Históricos |
| Consultas | Muchas y cortas | Pocas y pesadas |
| Modelo | Normalizado | Estrella o copo de nieve |

## Reflexión

Entender esta separación explica por qué los reportes pesados no deben correr sobre la base transaccional y por qué el DWH se carga con un proceso aparte (el ETL).
