# Lineamientos para contribuir a un proyecto

Se deben seguir los siguientes lineamientos para para contribuir al desarrollo de un proyecto. Esto garantiza que la trazabilidad y el versionamiento sean robustos.

## Git _Workflow_

Se utiliza [Gitflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow) con la siguiente estructura de _branches_:

- **main** _branch_: solo guarda los _releases_ oficiales. Cada _release_ debe estar identificado con su respectivo _tag_ que hace alusión a la versión del código (ver Etiquetas (Git _tags_)). Este es el _branch_ principal del proyecto. A este _branch_ no se le pueden hacer _commits_ directamente, par aplicar cambios en el, se debe hacer un _pull request_ desde el **dev** _branch_ o un **hotfix/** _branch_.

    Sobre el **main** _branch_ están configuradas unas [_GitHub Actions_](https://github.com/features/actions) que cuidan que se apliquen las mejores prácticas cuando se lleve una actualización a este _branch_. Además, se encargan de desplegar la documentación en [_GitHub Pages_](https://pages.github.com/).

- **dev** _branch_: funciona como integrador de los distintos ajustes, cambios, correcciones, mejoras o adiciones (_bug fixes_ o _features_) que se están desarrollando. Este es el _branch_ del que se deben crear los _forks_ para desarrollar correcciones, mejoras o adiciones en el código.

- **bugfix/** _branches_: Cada corrección debe residir en su propio _branch_. Siempre se deben crear a partir del **dev** _branch_.

- **feature/** _branches_: Cada nuevo cambio, mejora o adición debe residir en su propio _branch_. Siempre se deben crear a partir del **dev** _branch_.

- **release/** _branches_: Cuando se tienen acumulados varios cambios, mejoras, correcciones y/o adiciones, se crea un _branch_ de este tipo desde el **dev** _branch_. Esto inicia el ciclo de _release_ y a partir de este momento no se pueden añadir nuevas mejoras o cambios al código, en este _branch_, que no estén relacionadas con la corrección de errores, la documentación o tareas específicas orientadas al proceso de _release_.

- **hotfix/** _branches_: Usadas para reparar rápidamente errores en la versión de producción (**main** _branch_). Este es el único _branch_ que se puede (y debe) crear a partir del **main** _branch_. Una vez terminada la corrección se fusiona nuevamente (a través de un _pull request_) con el **main** _branch_, con el **release** _branch_ actual y con el **dev** _branch_. La fusión con el **main** _branch_ debe llevar su respectiva _**tag**_ con el número de versión actualizado.

## Mensaje _Commits_

Es obligatorio incluir un mensaje en cada _commit_. El mensaje debe utilizar la siguiente plantilla:

```git
<tipo>: <asunto> (Si se aplica, este commit...)
|<--------  Usar máximo 50 caracteres  --------->|

Explique por qué se realiza el cambio.
|<----  Trate de limitar cada línea a máximo 72 caracteres  ---->|

Descripción: Provea links o claves a cualquier ticket, artículo u
otro recurso relevante para el commit
Ejemplo: Issue #23

---- FIN DEL COMMIT ----

<tipo> puede ser: 
    feat     nueva característica
    data     versionamiento de datos
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

## Etiquetas (Git _tags_)

Se usa [SemVer](http://semver.org/) como lineamiento para administrar y denotar el versionamiento. Para nombrar las etiquetas (**_tags_**) se debe usar la forma `v0.0.0`.

Para ver las versiones disponibles, consulte las [_tags_ en este repositorio](https://github.com/alejpelo/plantilla-proyecto-python/tags).
