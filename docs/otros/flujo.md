# Flujo de trabajo al desarrollar

En el proyecto se implementan funcionalidades que facilitan el desarrollo. Estas promueven la colaboración, el control de versiones, la integración continua y el despliegue continuo pero requieren que los desarrolladores sigan un flujo de trabajo específico y realicen ciertas tareas de manera rutinaria.

La herramienta principal para ejecutar estas tareas de forma sencilla es [**just**](https://github.com/casey/just), que se indica como prerrequisito en la sección [Uso](../index.md#uso) de la introducción.

A continuación se describe el flujo de trabajo recomendado para trabajar en proyecto de manera efectiva:

1. Es recomendable que de manera periódica (e.g., al iniciar su jornada de trabajo, o al finalizarla), ejecute la instrucción:

    ```bash
    just update-code # (1)!
    ```

    1. También puede usar la versión abreviada: `just u`.

    que se encargará de actualizar su rama local con los últimos cambios del repositorio remoto.

2. Antes de iniciar cualquier desarrollo nuevo, debe crear una nueva rama (_branch_) a partir de la rama `dev` o `main`, usando la instrucción (se recomienda consultar la sección[Lineamientos contribución](./lineamientos.md) para obtener más información y detalles sobre la estructura de las ramas (_branches)):

    ```bash
    just create-branch <nombre-nueva-rama> <nombre-rama-original> # (1)!
    ```

    1. También puede usar la versión abreviada: `just b <nombre-nueva-rama> <nombre-rama-original>`.

    Por ejemplo, para crear una nueva rama llamada `feature/nueva-funcionalidad` a partir de la rama `dev`, debe ejecutar: `just create-branch "feature/nueva-funcionalidad" "dev"`.

3. En la medida en que vaya produciendo, o modificando archivos, (e.g., código, cuadernos, datos, documentación, etc.), debe ir haciendo el respectivo versionamiento. Para esto, además de agregar los archivos nuevos o modificados al área de preparación (_staging area_), bien sea usando la interfaz de su editor de código, o usando la instrucción:

    ```bash
    git add <archivo1> <archivo2> ...
    ```

    debe realizar el _commit_ correspondiente con un mensaje descriptivo de los cambios realizados, usando la instrucción:

    ```bash
    just commit-code # (1)!
    ```

    1. También puede usar la versión abreviada: `just c`.

    que le permitirá escribir el mensaje de _commit_ en la terminal, siguiendo las convenciones establecidas para estos mensajes.

    !!! tip "¡Tip!"
        Si necesita escribir varias líneas (renglones) en alguna de las respuestas que le solicita la terminal al ejecutar `just commit-code`, debe escribir el carácter `|` (i.e. _pipe_) y seguir escribiendo luego de este. NO use `Enter` o alguna combinación con esta tecla porque lo llevará a la siguiente pregunta.

4. Una vez haya realizado los _commits_ correspondientes de los cambios realizados, y desee sincronizarlos con el repositorio remoto, debe ejecutar la siguiente instrucción:

    ```bash
    just push-code # (1)!
    ```

    1. También puede usar la versión abreviada: `just p`.

    que se encargará de hacer el _push_ de los cambios al repositorio remoto, y de actualizar su rama local con los últimos cambios del repositorio remoto.

5. Cuando desee integrar los cambios realizados en la rama `main` o `dev`, y esto vaya a representar una nueva versión del proyecto, debe actualizar la versión y propagar este cambio al repositorio remoto. Para esto, una vez haya realizado todos los _commits_ que integrarán la nueva versión, debe ejecutar la siguiente instrucción:

    ```bash
    just bump-code-version # (1)!
    ```

    1. También puede usar la versión abreviada: `just bump`.

    Esta instrucción se encargará de actualizar la versión en los archivos correspondientes, hacer el _commit_ de estos cambios, crear la etiqueta (_tag_) correspondiente en Git, y hacer el _push_ de estos cambios y la etiqueta al repositorio remoto.

    !!! warning "¡Atención!"
        Para que [Commitizen](https://commitizen-tools.github.io/commitizen/) pueda actualizar la versión correctamente, es necesario que los mensajes de los _commits_ sigan las convenciones establecidas. Por lo tanto, es importante que siempre use la instrucción `just commit-code` para hacer los _commits_ y siga las indicaciones que están descritas en [Lineamientos contribución](./lineamientos.md#mensaje-commits), en la sección de los mensajes de los _commits_.

        Además debe asegurarse que todos los archivos `.py` (incluyendo los cuadernos - _notebooks_) que tengan la versión del proyecto, estén incluídos en la lista `version_files` de la herramienta **Commitizen** (`[tool.commitizen]`) que se encuentra al final en el archivo `pyproject.toml`.

El archivo `justfile` contiene más instrucciones que pueden ser útiles durante el desarrollo. Puede ver la lista completa de instrucciones disponibles ejecutando:

```bash
just
```
