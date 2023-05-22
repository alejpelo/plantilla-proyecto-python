from loguru import logger

# https://github.com/Delgan/loguru

logger.add(
    "debug.log",
    rotation="1 week",
    retention="10 days",
    backtrace=True,
    diagnose=True,
)

logger.debug("Eso es todo, logeo fácil!")
