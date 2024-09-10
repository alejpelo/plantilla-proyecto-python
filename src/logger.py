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

# Los niveles permitidos para el log, por defecto, son:
#       Level name  Severity value  Logger method
#       TRACE       5               logger.trace()
#       DEBUG       10              logger.debug()
#       INFO        20              logger.info()
#       SUCCESS     25              logger.success()
#       WARNING     30              logger.warning()
#       ERROR       40              logger.error()
#       CRITICAL    50              logger.critical()

log.add(
    "debug.log",
    level="DEBUG",  # Ajustar según nivel que se quiera imprimir (ver arriba)
    format="{time:YYYY-MM-DD HH:mm:ss.SSS} tz {time:Z} | "
    "{level} | {file} | linea: {line} | {message} || {extra}",
    rotation="1 week",
    retention="15 days",
    backtrace=True,
    diagnose=True,  # False en Producción para evitar que se filtre información
)
