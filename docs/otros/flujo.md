# Flujo de trabajo al desarrollar

En el proyecto están implementadas funcionalidades que facilitan el desarrollo. Estas promueven la colaboración, el control de versiones, la integración continua y el despliegue continuo, pero requieren que los desarrolladores sigan un flujo de trabajo específico y realicen ciertas tareas de manera rutinaria.

La herramienta principal para ejecutar estas tareas de forma sencilla es [**just**](https://github.com/casey/just), que se indica como prerrequisito en el capítulo [Uso](../index.md#uso) de la introducción de la documentación.

A continuación se describe el flujo de trabajo recomendado para trabajar en el proyecto de manera efectiva:

1. Es recomendable que de manera periódica (e.g., al iniciar su jornada de trabajo, o al finalizarla), ejecute la instrucción:

    ```sh
    just update-code # (1)!
    ```

    1. También puede usar la versión abreviada: `just u`.

    Esta se encargará de actualizar su repositorio **Git** local con los últimos cambios del repositorio remoto.

2. Antes de iniciar cualquier desarrollo nuevo, debe crear una nueva rama (_branch_) a partir de la rama `dev` o `main`, usando la instrucción (se recomienda consultar la sección [Lineamientos contribución](./lineamientos.md) para obtener más información y detalles sobre la estructura de las ramas (_branches_)):

    ```sh
    just create-branch <nombre-nueva-rama> <nombre-rama-original> # (1)!
    ```

    1. También puede usar la versión abreviada: `just b <nombre-nueva-rama> <nombre-rama-original>`.

    Por ejemplo, para crear una nueva rama llamada `feature/nueva-funcionalidad` a partir de la rama `dev`, debe ejecutar: `just create-branch "feature/nueva-funcionalidad" "dev"`.

3. En la nueva rama (_branch_), empiece a realizar ajustes o adiciones en el código y/o los datos. Recuerde que si desea versionar los datos, la recomendación es seguir las instrucciones indicadas en la página [_Data version control_](dvc.md).

    !!! tip "¡Pro Tip!"
        Puede correr los _checks_ que se ejecutan automáticamente al realizar un _commit_, ejecutando la siguiente instrucción:

        ```sh
        just run-pre-commit-checks # (1)!
        ```

        1. También puede usar la versión abreviada: `just pc`.

        Esto le permitirá detectar potenciales conflictos antes de proceder con el _commit_.

4. En la medida en que vaya produciendo, o modificando archivos, (e.g., código, cuadernos, datos, documentación, etc.), debe ir haciendo el respectivo versionamiento. Para esto, además de agregar los archivos nuevos o modificados al área de preparación (_staging area_), bien sea usando la interfaz de su editor de código, o usando la instrucción:

    ```sh
    git add <archivo1> <archivo2> ...
    ```

    debe realizar el _commit_ correspondiente con un mensaje descriptivo de los cambios realizados, usando la instrucción:

    ```sh
    just commit-code # (1)!
    ```

    1. También puede usar la versión abreviada: `just c`.

    que le permitirá escribir el mensaje de _commit_ en la terminal, siguiendo las convenciones establecidas para estos mensajes.

    !!! tip "¡Tip!"
        Si necesita escribir varias líneas (renglones) en alguna de las respuestas que le solicita la terminal al ejecutar `just commit-code`, debe escribir el carácter `|` (i.e. _pipe_) y seguir escribiendo luego de este. NO use `Enter` o alguna combinación con esta tecla porque lo llevará a la siguiente pregunta.

5. Una vez haya realizado los _commits_ correspondientes, y desee sincronizarlos con el repositorio remoto, debe ejecutar la siguiente instrucción:

    ```sh
    just push-code # (1)!
    ```

    1. También puede usar la versión abreviada: `just p`.

    Esta se encargará de hacer el _push_ de los cambios al repositorio remoto, y de actualizar su rama (_branch_) local con los últimos cambios del repositorio remoto.

    !!! tip "¡Pro Tip!"
        Puede correr los _checks_ que se ejecutan automáticamente al realizar un _push_, ejecutando la siguiente instrucción:

        ```sh
        just run-pre-push-checks # (1)!
        ```

        1. También puede usar la versión abreviada: `just pp`.

        Esto le permitirá detectar potenciales conflictos antes de proceder con el _push_.

6. Cuando desee integrar los cambios realizados a la rama `main` o `dev`, y esto vaya a representar una nueva versión del proyecto, debe, primero, seguir las reglas para sincronizar estas ramas (por lo general deben requerir un _pull request_). Posteriormente, estando en una de estas ramas (_branches_), debe actualizar la versión y propagar este cambio al repositorio remoto. Para esto, una vez haya realizado todos los _commits_ que integrarán la nueva versión, los haya fusionado con la rama `main` o `dev` y esté en esta última, debe ejecutar la siguiente instrucción:

    ```sh
    just bump-code-version # (1)!
    ```

    1. También puede usar la versión abreviada: `just bump`.

    Esta instrucción se encargará de actualizar la versión en los archivos correspondientes, hacer el _commit_ de estos cambios, crear la etiqueta (_tag_) correspondiente en Git, y hacer el _push_ de estos cambios y la etiqueta al repositorio remoto.

    !!! warning "¡Atención!"
        Para que [Commitizen](https://commitizen-tools.github.io/commitizen/) pueda actualizar la versión correctamente, es necesario que los mensajes de los _commits_ sigan las convenciones establecidas. Por lo tanto, es importante que siempre use la instrucción `just commit-code` para hacer los _commits_ y siga las indicaciones que están descritas en [Lineamientos contribución](./lineamientos.md#mensaje-commits), en la sección de los mensajes de los _commits_.

        Además, debe asegurarse que todos los archivos `.py` (incluyendo los cuadernos - _notebooks_) que contengan la versión del proyecto (i.e. `__version__ = "x.x.x"`), estén incluidos en la lista `version_files` de la herramienta **Commitizen** (i.e. `[tool.commitizen]`) que se encuentra en la parte final del archivo `pyproject.toml`.

El archivo `justfile` contiene más instrucciones que pueden ser útiles durante el desarrollo. Puede ver la lista completa de instrucciones disponibles ejecutando:

```sh
just
```
