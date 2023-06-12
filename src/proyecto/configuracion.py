#!/usr/bin/env python3
"""Variables de Configuración y Variables de Entorno.

Este módulo contiene las funciones que permiten configurar y usar el *logger*
para el proyecto.

Se usa [Python-dotenv](https://github.com/theskumar/python-dotenv) como
libraría leer los archivos de configuración.

Author: [Alejandro Perez Londoño](mailto:perezl.alejandro@gmail.com)
"""
from dotenv import dotenv_values

config = {
    **dotenv_values(".env.shared"),  # variables de configuración compartidas
    **dotenv_values(".env.secret"),  # variables de configuración PRIVADAS
}
