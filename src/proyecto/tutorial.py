#!/usr/bin/env python3
"""Tutorial.

Este módulo muestra como usar:

- El archivo de configuración desde cualquier parte del proyecto.
- El log desde cualquier módulo del proyecto.

La idea es que el usuario borre este archivo y ajuste el archivo de
configuración de prueba una vez esté familiarizado con lo que aquí se muestra.

Author: [Alejandro Perez Londoño](mailto:perezl.alejandro@gmail.com)
"""
import hydra
from logger import log
from omegaconf import DictConfig, OmegaConf


# ¿Cómo usar los archivos de configuración?
@hydra.main(
    config_path="../../conf",
    config_name="main",
    version_base=None,
)
def my_app(cfg: DictConfig) -> None:
    """Muestra el uso de archivos de configuración para toda la aplicación.

    Imprime el archivo de configuración de prueba que está en conf/main.yaml

    Args:
        cfg (DictConfig): Diccionario con toda la configuración
    """
    log.debug("Configuración: {}", OmegaConf.to_object(cfg))

    # ¿Cómo usar "logear" algo en cualquier módulo?
    log.debug(
        "Si está usando Python {}, es, por supuesto, preferible {feature}!",
        ">=3.6",
        feature="f-strings",
    )
    log.info("Eso es todo, log fácil!")

    # ¿Cómo agregar más información al log (agregar contexto)?
    log_contextualizado = log.bind(cliente_id="001", producto_id="123")
    log_contextualizado.info("Fácil, log con la información adicional")


if __name__ == "__main__":
    my_app()
