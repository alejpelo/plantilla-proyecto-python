#!/usr/bin/env python3
"""Pruebas generales del proyecto.

Author: [Alejandro Perez Londoño](mailto:perezl.alejandro@gmail.com)
"""

from src import __version__


def test_version_proyecto():
    """Prueba la versión del proyecto."""
    assert __version__ == "0.11.0"
