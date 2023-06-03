#!/usr/bin/env python3
"""Configuración del logger.

Este módulo contiene las funciones que permiten configurar y usar el *logger*
para el proyecto.

https://github.com/Delgan/loguru

Author: `Alejandro Perez Londoño <mailto:perezl.alejandro@gmail.com>`_
"""

from loguru import logger

logger.add(
    "debug.log",
    rotation="1 week",
    retention="10 days",
    backtrace=True,
    diagnose=True,
)

logger.debug("Eso es todo, log fácil!")
