# Plantilla para proyectos: Python

Click [aquí](https://alejpelo.github.io/plantilla-proyecto-python/) para acceder a la documentación en línea

<!--docs-start-->

Plantilla para organizar proyectos que usan **Python** e incorpora mejores prácticas relacionadas con:

- _Version control_: [Git](https://git-scm.com/), (libro: [Pro Git](https://git-scm.com/book/en/v2), tutorial: [Getting Git Right: Learn Git with Tutorials, News and Tips](https://www.atlassian.com/git))
- _Virtual environments_ y _Dependency management_: [Poetry](https://python-poetry.org/)
- _Static typing_: [Mypy](https://mypy-lang.org/)
- _Code formatting_, _Linting_ y _Style enforcement_: [Ruff](https://beta.ruff.rs/docs/)
- _Package vulnerability analysis_: [Pip-audit](https://pypi.org/project/pip-audit/)
- _Pre-Commit hooks_: [Pre-commit](https://pre-commit.com/)
- _Documentation_: [MkDocs](https://www.mkdocs.org/), [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/), [Google docstrings](https://google.github.io/styleguide/pyguide.html#38-comments-and-docstrings)
- _Environmental variables_ y _`.env` files_: [Pydantic-Settings](https://docs.pydantic.dev/latest/concepts/pydantic_settings/)
- _Logging_: [Loguru](https://github.com/Delgan/loguru)
- _Debugging (print)_: [IceCream](https://github.com/gruns/icecream)
- _Model Configuration files_: [Hydra](https://hydra.cc/)

## Uso

Para instalar la plantilla y empezarla a usar en un nuevo proyecto, debe tener instalado previamente en su equipo, [**Git**](https://git-scm.com/), **Python** (versión 3.11) y [**Poetry**](https://python-poetry.org/docs/#installation) (versión >= 1.5).

=== "WindowsOS"

    Para instalar Python se recomienda seguir las instrucciones que están en la página oficial de [Python](https://www.python.org/). Con el instalador es posible administrar múltiples versiones de Python.

    En Windows es necesario instalar, adicionalmente, [Make](https://gnuwin32.sourceforge.net/packages/make.htm). (Tutorial: [How to setup/install GNU make on Windows](https://leangaurav.medium.com/how-to-setup-install-gnu-make-on-windows-324480f1da69))

=== "MacOS / Linux"

    Para instalar Python se recomienda usar [Homebrew](https://brew.sh/) y primero instalar [pyenv](https://github.com/pyenv/pyenv). Con esta última herramienta es posible administrar múltiples versiones de Python simultáneamente de Python muy fácilmente.

Posteriormente, siga los pasos descritos a continuación:

1. Cree un nuevo repositorio a partir de esta [plantilla](https://github.com/alejpelo/plantilla-proyecto-python) (_template_) con el nombre de su nuevo proyecto en el que quiere implementar las mejores prácticas.

2. Clone el nuevo repositorio en su equipo.

3. Asegúrese que _Poetry_ está usando la versión de _Python_ adecuada para crear el ambiente virtual[^1] (i.e. 3.11)

    === "WindowsOS"

        ```shell
        poetry env use "C:/Users/<USUARIO>/AppData/Local/Programs/Python/Python<##>/python.exe"
        ```

    === "MacOS / Linux"

        ```
        pyenv local 3.11
        ```

4. Instale el proyecto, ejecute:

    ```shell
    poetry install
    ```

5. En el proyecto se usa [pre-commit](https://pre-commit.com/) para automatizar la verificación del código antes de los _commits_ y de los _pushs_. La librería ya está incluida en las dependencias necesarias para contribuir al proyecto, sin embargo, es necesario configurarla usando las siguientes instrucciones:

    ```shell
    pre-commit install
    pre-commit install --hook-type pre-commit
    pre-commit install --hook-type pre-push
    ```

6. Consulte el archivo `src/proyecto/tutorial.py` para conocer cómo usar los archivos de configuración y el log.

7. Consulte el archivo `docs/tutorial.md` para conocer las capacidades instaladas de la documentación. Para trabajar en la documentación, con el ambiente virtual activado, ejecute:

    ```shell
    mkdocs serve
    ```

    Esto hará que la documentación se actualice en línea en la medida que realice cambios.

    Al final para construir el sitio, ejecute:

    ```shell
    mkdocs build
    ```

    Y para deplegar la documentación en el [GitHub Pages](https://pages.github.com/), estando en la **master**/**main** _branch_, ejecute:

    !!! tip "Tener presente..."
        Para que esta instrucción funcione y la página quede publicada, el repositorio debe ser público o el usuario debe estar suscrito a [GitHub Teams](https://github.com/team)

    ```shell
    mkdocs gh-deploy
    ```

!!! danger "¡Atención!"
    El proyecto tiene un `Makefile` y un archivo _shell_ (`write_requirements.sh`) que no corren en WindowsOS por defecto. Si siguió todas las instrucciones descritas anteriormente, todas las funcionalidades de la plantilla debe funcionar adecuadamente tanto en WindowsOS como en MacOS y LinuxOS. Si se le presentan errores:

    1. Es necesario remover el pre-commit que exporta los archivos de librarías requeridas de `.pre-commit-config.yaml`. y no usar el `Makefile`.
    2. Agradecemos lo reporte para buscar una solución.

**Eso es todo, puede empezar con su nuevo proyecto.**

## Librarías útiles para los proyectos

- _Scientific and Numerical Computing_: [NumPy](https://numpy.org/), [SciPy](https://scipy.org/)
- _Dataframes_: [Pandas](https://pandas.pydata.org/) (tutorial: [Pandas Illustrated: The Definitive Visual Guide to Pandas](https://betterprogramming.pub/pandas-illustrated-the-definitive-visual-guide-to-pandas-c31fa921a43)), [Polars](https://www.pola.rs/)
- _Graphics_ / _Plots_: [matplotlib](https://matplotlib.org/), [Seaborn](https://seaborn.pydata.org/), [Plotnine](https://plotnine.readthedocs.io/en/stable/), [Plotly](https://plotly.com/python/), [Bokeh](http://bokeh.org/)
- _Data Validation_: [Pydantic](https://docs.pydantic.dev/latest/)
- _Machine Learning_ / _Deep Learning_: [Scikit-learn](https://scikit-learn.org/stable/), [PyTorch](https://pytorch.org/), [Keras](https://keras.io/)
- _In Memory DB_: [Duck DB](https://duckdb.org)
- _Data Workflow Orchestration_: [Kestra](https://kestra.io/), [Prefect](https://www.prefect.io/opensource)
- _Web Scrapping_: [Beautiful Soup](https://beautiful-soup-4.readthedocs.io/en/latest/), [Selenium](https://www.selenium.dev)
- _Data Version Control_: [DVC](https://dvc.org/)
- _Graphical User Interfaces_ (_GUIs_) / _Web Clients_: [Tkinker](https://docs.python.org/3/library/tkinter.html#module-tkinter), [Streamlit](https://streamlit.io/), [DearPyGUI](https://github.com/hoffstadt/DearPyGui), [Gradio](https://github.com/gradio-app/gradio), [Vizro](https://vizro.readthedocs.io/en/stable/), [Django](https://www.djangoproject.com/)
- _APIs_: [FastAPI](https://fastapi.tiangolo.com/lo/), [Litestar](https://litestar.dev/), [Django](https://www.djangoproject.com/)
- _Dates_: [Arrow](https://arrow.readthedocs.io/en/latest/)
- _Cloud Developer Toolkits_: [_Power tools for AWS Lambda_](https://docs.powertools.aws.dev/lambda/python/latest/)
- _Automate testing_: [Nox](https://nox.thea.codes/en/stable/index.html)

Para instalar una de estas librerías, o cualquier otra que vaya a utilizar, haciendo uso de **Poetry**, se debe ejecutar, por ejemplo:

```shell
poetry add pandas
```

Si la va a instalar solo para desarrollo (_dev_), o en cualquier otro grupo de librerías (i.e. _tests_, _docs_, _kernels_), ejecutar:

```shell
poetry add nox --group dev
```

## Lineamientos para Contribuir al Proyecto

Se deben seguir los siguientes lineamientos para para contribuir al desarrollo del proyecto. Esto garantiza que la trazabilidad y el versionamiento sea robusto.

### _Workflow_

Se utiliza [Gitflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow) con la siguiente estructura de _branches_:

- **master**/**main** _branch_: solo guarda los _releases_ oficiales. Cada _release_ debe estar identificado con su respectivo _tag_ que hace alusión a la versión del código (ver Versionamiento (_tags_)).

- **develop**/**dev** _branch_: funciona como integrador de los distintos ajustes, cambios, correcciones, mejoras o adiciones (_bug fixes_ o _features_) que se están desarrollando. Este es el _branch_ del que se deben crear los _forks_ para desarrollar correcciones, mejoras o adiciones en el código.

- **bugfix/** _branches_: Cada corrección debe residir en su propio _branch_. Siempre se deben crear a partir del **develop**/**dev** _branch_.

- **feature/** _branches_: Cada nuevo cambio, mejora o adición debe residir en su propio _branch_. Siempre se deben crear a partir del **develop**/**dev** _branch_.

- **release/** _branches_: Cuando se tienen acumulados varios cambios, mejoras, correcciones y/o adiciones, se crea un _branch_ de este tipo desde el **develop**/**dev** _branch_. Esto inicia el ciclo de _release_ y a partir de este momento no se pueden añadir nuevas mejoras o cambios al código, en este _branch_, que no estén relacionadas con la corrección de errores, la documentación o tareas específicas orientadas al proceso de _release_.

- **hotfix/** _branches_: Usadas para reparar rápidamente errores en la versión de producción (**master**/**main** _branch_). Este es el único _branch_ que se puede (y debe) crear a partir del **master**/**main** _branch_. Una vez terminada la corrección se fusiona nuevamente con el **master**/**main** _branch_, con el **release-** _branch_ actual y con el **develop**/**dev** _branch_. La fusión con el **master**/**main** _branch_ debe llevar su respectiva **tag** con el número de versión actualizado.

### _Commits_

Es obligatorio incluir un mensaje en cada _commit_. El mensaje debe utilizar la siguiente plantilla:

```git
<tipo>: <asunto> (Si se aplica, este commit...)
|<----  Usar máximo 50 caracteres  ---->|

Explique por qué se realiza el cambio.
|<----  Trate de limitar cada línea a máximo 72 caracteres  ---->|

Provea links o claves a cualquier ticket, artículo u otro recurso relevante para el commit
Ejemplo: Issue #23

---- FIN DEL COMMIT ----

Type can be: 
    feat     nueva característica
    fix      corrección de error
    style    formato (e.g. agregar comas que faltaban); no se cambia el código
    docs     cambios a la documentación
    test     añadir o ajustar tests; no se cambia el código de producción
    chore    cambia configuración CI/CD, pre-commits, etc.; no se cambia el código de producción

---------------

Recuerde...
    Empezar con mayúscula la línea del asunto
    Usar el modo imperativo en la línea del asunto
    No terminar la línea del asunto con punto
    Separar la línea del asunto del cuerpo del commit (descripción) con una línea en blanco
    Usar el cuerpo del commit para explicar el qué y el por qué, no el cómo
    Puede usar múltiple líneas con "-" para viñetas en el cuerpo del commit
```

### Versionamiento (_tags_)

Se usa [SemVer](http://semver.org/) como lineamiento para el versionamiento. Para nombrar las **_tags_** se debe usar la forma `v0.0.0`.

Para ver las versiones disponibles, consulte las [_tags_ en este repositorio](https://github.com/alejpelo/plantilla-proyecto-python/tags).

---

[^1]: [Poetry, Managing Environments](https://python-poetry.org/docs/managing-environments/).

<!--docs-end-->
