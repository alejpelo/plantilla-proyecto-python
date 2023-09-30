#!/usr/bin/env python3
"""Tutorial para _configuration files_ y _log_.

Este módulo muestra como usar:

- El archivo con variables de entorno.
- El archivo de configuración desde cualquier parte del proyecto.
- El log desde cualquier módulo del proyecto.

La idea es que el usuario borre este archivo y ajuste el archivo de
configuración de prueba una vez esté familiarizado con lo que aquí se muestra.

Author: [Alejandro Perez Londoño](mailto:perezl.alejandro@gmail.com)
"""
import hydra
from omegaconf import DictConfig, OmegaConf

from configuracion import CONFIG
from logger import log


# ¿Cómo usar los archivos de configuración?
@hydra.main(
    config_path="../../conf",
    config_name="main",
    version_base=None,
)
def my_app(cfg: DictConfig) -> None:
    """Usa archivos de configuración y variables de entorno en la aplicación.

    - Lleva al log todas las variables del archivo de configuración de prueba
        que está en conf/main.yaml
    - Lleva al log todas las variables de los archivos .env.shared y
        .env.secrets

    Args:
        cfg (DictConfig): Diccionario con toda la configuración
    """
    log.debug("Configuración: {}", OmegaConf.to_object(cfg))
    log.debug("Entorno: {}", CONFIG)

    # ¿Cómo usar "logear" algo en cualquier módulo?
    log.debug(
        "Si está usando Python {}, es, por supuesto, preferible {feature}!",
        ">=3.6",
        feature="f-strings",
    )
    log.info("Eso es todo, log fácil!")

    # ¿Cómo agregar más información al log (agregar contexto)?
    log_contextualizado = log.bind(cliente_id="001", producto_id="123")
    log_contextualizado.info("Fácil, log con información adicional")


if __name__ == "__main__":
    my_app()
