#!/usr/bin/env python3
"""Variables de Configuración y Variables de Entorno.

Este módulo contiene las funciones que permiten leer los archivos .env con las
variables de configuración tanto públicas (que se comparten con el proyecto),
como aquellas privadas (_secrets_) que no se comparten y cada usuario del
proyecto debe alimentar.

Esta forma de trabajar permite tener adecuados controles de seguridad para no
compartir información sensible como por ejemplo: contraseñas, nombres de
usuario, entre otros.

En la raíz del proyecto debe haber dos archivos:

- `.env.shared`: archivo con variables de configuración públicas. Este archivo
    **SI** se agrega al versionamiento y **SI** va al repositorio.

- `.env.secrets`: archivo con variables de configuración privadas. Este
    archivo **NO** se agrega al versionamiento y **NO** va al repositorio.

Se usa [Python-dotenv](https://github.com/theskumar/python-dotenv) como
libraría leer los archivos de configuración.

Author: [Alejandro Perez Londoño](mailto:perezl.alejandro@gmail.com)
"""
from dotenv import dotenv_values

config = {
    **dotenv_values(".env.shared"),  # variables de configuración compartidas
    **dotenv_values(".env.secrets"),  # variables de configuración PRIVADAS
}
