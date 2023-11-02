#!/usr/bin/env python3
"""Configuración del logger.

Este módulo contiene las funciones que permiten configurar y usar el *logger*
para el proyecto.

Se usa [Loguru](https://github.com/Delgan/loguru) como libraría para gestionar
el log.

Author: [Alejandro Perez Londoño](mailto:perezl.alejandro@gmail.com)
"""
from __future__ import annotations

import json

import loguru
from loguru import logger


def serialize(record: loguru.Record) -> str:
    """Extrae y serializa en JSON la información del record para el log.

    Args:
        record (dict): record del log definido por loguru

    Returns:
        str: subconjunto de información del record en formato JSON
    """
    subset = {
        "timestamp": record["time"].timestamp(),
        "time": record["time"].strftime("%Y-%m-%d %H:%M:%S.%f tz %z"),
        "level": record["level"].name,
        "file": record["file"].name,
        "line": record["line"],
        "message": record["message"],
    }
    return json.dumps(subset, ensure_ascii=False)


def patching(record: loguru.Record):
    """Parcha el record del log.

    Ajusta la información que va en el log

    Args:
        record (dict): record del log definido por loguru
    """
    record["extra"]["serialized"] = serialize(record)


log = logger

log.remove(0)

log = logger.patch(patching)

log.add(
    "debug.log",
    level="DEBUG",
    format="{time:YYYY-MM-DD HH:mm:ss.SSS} tz {time:Z} | "
    "{level} | {file} | {line} | {message} || {extra}",
    rotation="1 week",
    retention="15 days",
    backtrace=True,
    diagnose=True,  # False en Producción para evitar que se filtre información
)
