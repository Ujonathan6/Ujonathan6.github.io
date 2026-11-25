---
title: 'Investigación: RPO, alta disponibilidad y copias de seguridad'
description: 'Cuántos datos puede perder una organización y cómo se diseña la continuidad de una base de datos.'
pubDate: 'Nov 22 2026'
category: 'Investigacion'
tags: ['rpo', 'alta-disponibilidad', 'backups']
author: 'Jhonatan Lozano'
---

## Contexto

En el peor escenario, lo primero que hay que salvar son los datos. Esta entrada resume los conceptos de continuidad vistos en clase. Notas: [notas_etl_dwh.txt](https://github.com/Ujonathan6/Ujonathan6.github.io/blob/main/scripts-bd2/03-nosql-mongodb/notas_etl_dwh.txt)

## RPO (Recovery Point Objective)

Cuántos datos puede permitirse perder una organización, medido en **tiempo hacia atrás** desde la falla. Con un RPO de 15 minutos, la copia más reciente debe tener como máximo 15 minutos de antigüedad. Define cada cuánto se respalda o replica.

## RTO (Recovery Time Objective)

Complementa al RPO: cuánto tiempo puede estar el servicio fuera de línea. Mi nota de clase decía "cuánto tiempo puedo estar afuera"; esa pregunta corresponde al RTO, y la de "cuántos datos puedo perder", al RPO.

## Alta disponibilidad

Arquitecturas que mantienen el servicio aunque falle un componente: réplicas de la base de datos, **failover** automático hacia un nodo en espera y balanceo de carga.

## Backups y restauración

La copia de seguridad es la última línea de defensa: protege ante borrados, corrupción o desastres que una réplica también copiaría. Un respaldo que nunca se ha probado restaurar no es una garantía.

## Reflexión

RPO y RTO no los define el área técnica sola: salen de preguntarle al negocio cuánto cuesta perder datos y cuánto cuesta estar detenido. De ahí se escoge la arquitectura.
