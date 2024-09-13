#!/usr/bin/env python3
"""Variables de Configuración y Variables de Entorno.

Este módulo contiene las funciones que permiten leer los archivos .env con las
variables de configuración tanto públicas (que se comparten con el proyecto),
como aquellas privadas (_secrets_) que no se comparten y cada usuario del
proyecto debe alimentar.

Esta forma de trabajar permite tener adecuadas prácticas de seguridad para no
compartir información sensible como por ejemplo: contraseñas, nombres de
usuario, entre otros.

En la raíz del proyecto debe haber dos archivos:

- `.env.public`: archivo con variables de configuración públicas. Este archivo
    **SI** se agrega al versionamiento y **SI** va al repositorio.

- `.env.private`: archivo con variables de configuración privadas. Este
    archivo **NO** se agrega al versionamiento y **NO** va al repositorio.

Se usa [Pydantic-Settings](https://docs.pydantic.dev/latest/concepts/pydantic_settings/)
como libraría para leer los archivos con las variables de entorno.

Author: [Alejandro Perez Londoño](mailto:perezl.alejandro@gmail.com)
"""

from pydantic import Field
from pydantic_settings import BaseSettings, SettingsConfigDict


class Configuracion(BaseSettings):
    """Lee y valida las variables de configuración de los archivos .env."""

    model_config = SettingsConfigDict(
        env_file=(".env.public", ".env.private"),
    )

    # Las variables de configuración que aparecen de aquí para abajo se deben
    # ajustar dependiendo de las variables que estén incluidas en los archivos
    # .env (.env.public y .env.private)

    domain: str = Field(alias="DOMAIN")
    admin_email: str = Field(alias="ADMIN_EMAIL")
    root_url: str = Field(alias="ROOT_URL")

    password: str = Field(alias="PASSWORD", min_length=8)
    secret_access_key: str = Field(alias="SECRET_ACCESS_KEY", min_length=20)


configuracion = Configuracion()
