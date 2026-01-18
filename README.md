# Plantilla para proyectos: Python

Click [aquí](https://alejpelo.github.io/plantilla-proyecto-python/) para acceder a la documentación completa en línea.

<!--docs-start-->

## Descripción

Plantilla para organizar proyectos que usan **Python** e incorporar mejores prácticas relacionadas con:

- _Version control_: [Git](https://git-scm.com/) (libro: [_Pro Git_](https://git-scm.com/book/en/v2), tutorial: [_Getting Git Right: Learn Git with Tutorials, News and Tips_](https://www.atlassian.com/git))
- _Project management_, _Virtual environments_ y _Dependencies management_: [uv](https://docs.astral.sh/uv/)
- _Static typing_: [Ty](https://docs.astral.sh/ty/)
- _Code formatting_, _Linting_ y _Style enforcement_: [Ruff](https://docs.astral.sh/ruff/)
- _Package vulnerability analysis_: [pip-audit](https://pypi.org/project/pip-audit/)
- _Commit management_: [pre-commit](https://pre-commit.com/), [Commitizen] (https://commitizen-tools.github.io/commitizen/)
- _Documentation_: [MkDocs](https://www.mkdocs.org/), [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/), [Google docstrings](https://google.github.io/styleguide/pyguide.html#38-comments-and-docstrings)
- _Environmental variables_ y _`.env` files_: [Pydantic-Settings](https://docs.pydantic.dev/latest/concepts/pydantic_settings/)
- _Logging_: [Loguru](https://github.com/Delgan/loguru)
- _Debugging_: [_The Python Debugger_](https://docs.python.org/3/library/pdb.html) (tutorial: [_Python Debugging With Pdb_](https://arc.net/l/quote/ggofsxtp)), [IceCream](https://github.com/gruns/icecream)
- _Testing_: [pytest](https://docs.pytest.org/en/stable/) (tutorial: [Effective Python Testing With Pytest](https://realpython.com/pytest-python-testing/)), [pytest-cov](https://pytest-cov.readthedocs.io/en/latest/)

Opcionalmente:

- `nb`: _Python notebooks_: [marimo](https://marimo.io/), (ver página [_Notebooks_](docs/otros/notebooks.md) para más detalles)
- `dvc`: _Data version control_: [DVC](https://dvc.org/), (ver página [_Data version control_](docs/otros/dvc.md) para más detalles)

!!! warning "¡Atención!"
    Es conocido que [DVC](https://dvc.org/) puede presentar problemas de compatibilidad cuando se usa en WindowsOS. Se recomienda revisar la [documentación oficial de DVC](https://doc.dvc.org/), particularmente las siguientes páginas:

    - [Installation on Windows](https://doc.dvc.org/install/windows)
    - [How to Run DVC on Windows](https://doc.dvc.org/user-guide/how-to/run-dvc-on-windows)

    Si va a usar esa práctica opcional, es preferible usar MacOS o LinuxOS para evitar inconvenientes.

## Estructura

El proyecto usa la siguiente estructura de carpetas y archivos:

<figure markdown>
  ![Estructura del Proyecto](docs/assets/project-structure.png){ width=50% }
  <figcaption>Estructura de carpetas y archivos del proyecto</figcaption>
</figure>

A continuación se describe el propósito de cada una de las carpetas:

:material-folder: `data/`

:   Carpeta para almacenar los archivos de datos (e.g. archivos `.txt`, `.csv`, `.parquet`, `.xlsx`, ...). Dentro de la carpeta se pueden crear sub-carpetas para almacenar los datos en distintos estados (e.g. crudos (_raw_), pre-procesados, procesados, ...).

    Esta carpeta **NO** debe estar versionada con Git, y por defecto, está incluida en el archivo `.gitignore` del proyecto[^1].
    
    Se incluye una sub-carpeta especial (`querys/`) destinada a almacenar los _querys_ (archivos `.sql`) que se utilizan para generar los datos. Esta sub-carpeta si se debe versionar en Git, y por defecto, está configurada para que así sea.
    
    Para hacer versionamiento de los datos que hagan parte del proyecto y sean necesarios para asegurar la reproducibilidad del mismo, y se almacenen dentro de esta carpeta, se debe hacer uso lo explicado en la práctica relacionada con [_Data version control_](docs/otros/dvc.md).

:material-folder: `docs/`

:   Carpeta para almacenar y gestionar la documentación del proyecto. Se administra usando [MkDocs](https://www.mkdocs.org/), [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) y [Google docstrings](https://google.github.io/styleguide/pyguide.html#38-comments-and-docstrings).

:material-folder: `notebooks/`

:   Carpeta para almacenar los cuadernos (_notebooks_ usando [marimo](https://marimo.io/)) que utilice en el proyecto.

    Para gestionar (i.e. crear, editar y eliminar) cuadernos (_notebooks_), se debe hacer uso lo explicado en la práctica relacionada con [_Notebooks_](docs/otros/notebooks.md).

:material-folder: `outputs/`

:   Carpeta para almacenar los archivos de resultados (e.g. archivos `.pdf`, `.png`, `.txt`, `.csv`, `.parquet`, `.xlsx`, ...). Dentro de la carpeta se pueden crear sub-carpetas para almacenar distintos tipos de resultados (e.g. informes, gráficos, resultados ...).

    Esta carpeta **NO** debe estar versionada con Git, y por defecto, está incluida en el archivo `.gitignore` del proyecto[^1].
    
    Para hacer versionamiento de los datos que hagan parte del proyecto y sean necesarios para asegurar la reproducibilidad del mismo, y se almacenen dentro de esta carpeta, se debe hacer uso lo explicado en la práctica relacionada con [_Data version control_](docs/otros/dvc.md).

    Si se generan informes, se recomienda que en ellos incluya el _tag_ que identifica la versión del proyecto que permite reproducirlos. De esta manera, en cualquier otro momento es posible recrear los datos, los modelos y el código que permite llegar a los mismos resultados.

:material-folder: `src/`

:   Carpeta para almacenar el código (archivos  `.py`). Dentro de la carpeta se pueden crear sub-carpetas para organizar el código adecuadamente.

:material-folder: `tests/`

:   Carpeta para almacenar las pruebas del proyecto (archivos  `.py`). Dentro de la carpeta se pueden crear sub-carpetas para organizar las pruebas adecuadamente. Las pruebas se deben escribir usando [pytest](https://docs.pytest.org/en/stable/).

## Uso

Para instalar la plantilla y empezarla a usar en un nuevo proyecto, debe tener instalado previamente en su equipo, [**Git**](https://git-scm.com/) (versión >= 2.52.0), [**uv**](https://docs.astral.sh/uv/) (versión >= 0.9.26) y [**just**](https://github.com/casey/just) (versión >= 1.46.0).

!!! warning "¡Atención!"
    El proyecto incluye algunas funcionalidades que requieren un _shell_ (`sh`) compatible con Unix (e.g. MacOS, LinuxOS). Al instalar Git en WindowsOS, es posible instalar adicionalmente **Git Bash** que proporciona un _shell_ compatible con Unix. Si realiza esta instalación adicional y configura su sistema para usar Git Bash como _shell_ predeterminado, tal como lo explica la documentación de la instalación de **just**, no debería tener inconvenientes al usar el proyecto en WindowsOS.

    Si se le presentan errores, le agradecemos lo reporte para buscar soluciones.

Posteriormente, siga los pasos descritos a continuación:

1. Cree un nuevo repositorio a partir de esta [plantilla](https://github.com/alejpelo/plantilla-proyecto-python) (_template_) con el nombre de su nuevo proyecto. _Asegúrese de marcar la opción **Include all branches**_.

2. Clone el nuevo repositorio en su equipo local.

3. Instale el proyecto, ejecutando:

    ```sh
    just set-dev-env
    ```

    Si desea usar algunas de las librerías que proporcionan prácticas opcionales, ejecute:

    ```sh
    just set-dev-env <práctica opcional> # (1)!
    ```

    1. Debe reemplazar `<práctica opcional>` por el código de la práctica opcional. Por ejemplo: `"--extra dvc"` o `"--extra nb"`.

    Si desea usar más de una práctica opcional, simplemente repita `<práctica opcional>`, separado por un espacio, las veces que necesite al final de la instrucción.

4. En el proyecto se usan [pre-commit](https://pre-commit.com/) _hooks_ para automatizar la verificación del código antes de los _commits_ y los _pushs_. La librería ya está incluida en las dependencias necesarias para contribuir al proyecto, sin embargo, es necesario configurar la herramienta usando las siguientes instrucciones:

    ```sh
    just install-pre-commit-hooks
    ```

5. Consulte el archivo `src/tutorial.py` para conocer cómo usar las variables de entorno, el log y cómo hacer _debugging_ fácilmente.

6. Consulte el archivo `docs/tutorial.md` para conocer las capacidades instaladas para documentar el proyecto. Para visualizar en limpio la documentación, ejecute:

    ```sh
    just serve-docs
    ```

    Esto le permitirá ver en el explorador la versión final de la documentación y hará que esta se actualice en línea en la medida que realice cambios.

**¡Eso es todo!, puede empezar a trabajar en su nuevo proyecto.**

[^1]: Este archivo se encuentra en la siguiente ruta: `~/gitconfig`.

<!--docs-end-->
