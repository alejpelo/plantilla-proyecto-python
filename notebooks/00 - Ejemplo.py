import marimo

__generated_with = "0.14.0"
app = marimo.App(width="medium")


@app.cell
def _():
    import marimo as mo

    return (mo,)


@app.cell
def _(mo):
    mo.md(r"""# -- _CUADERNO DE MUESTRA [EJEMPLO]_ --""")
    return


@app.cell
def _(mo):
    mo.md(
        r"""
    #Título

    El título del cuaderno debe ser coherente con el nombre del archivo. Además tenga presente que las extenciones de los cuadernos de marimo son `.py`. Por ejemplo:

    `01 - Exploración de Datos.py`
    """
    )
    return


@app.cell
def _(mo):
    mo.md(
        r"""
    ### Autores

    Autor 1, email, afiliación

    Autor 2, email, afiliación
    """
    )
    return


@app.cell
def _(mo):
    mo.md(
        r"""
    ### Vínculos

    <table class="tfo-notebook-buttons" align="left">
      <td>
        <a target="_blank" href="https://colab.research.google.com/github/tensorflow/docs/blob/master/tools/templates/notebook.ipynb"><img src="https://www.tensorflow.org/images/colab_logo_32px.png" />Run in Google Colab</a>
      </td>
      <td>
        <a target="_blank" href="https://github.com/tensorflow/docs/blob/master/tools/templates/notebook.ipynb"><img src="https://www.tensorflow.org/images/GitHub-Mark-32px.png" />View on GitHub</a>
      </td>
    </table>

    [No olvide actualizar los hipervínculos de los botones...]
    """
    )
    return


@app.cell
def _(mo):
    mo.md(
        r"""
    ## Visión General

    [Incluya uno o dos párrafos explicando qué muestra este cuaderno, a quién podría interesarle y qué se necesita saber antes de comenzar.]
    """
    )
    return


@app.cell
def _(mo):
    mo.md(
        r"""
    ## Configuración

    [Importe todas las librerías en una sección de configuración. Realice cualquier configuración (e.g. el _logger_) en esta sección.]
    """
    )
    return


@app.cell
def _():
    return


@app.cell
def _():
    from configuracion import configuracion
    from logger import log

    return configuracion, log


@app.cell
def _(mo):
    mo.md(
        r"""
    ## Recursos

    [Describa los recursos (artículos, páginas web, documentación, videos, etc.) que sirvan para ambientar y sustentar lo que se presenta en este cuaderno.]

    Por ejemplo:

    * [Polars](https://pola.rs/)
    * [Plotnine](https://plotnine.org/)
    * [Google developer documentation style guide](https://developers.google.com/style/highlights)
    """
    )
    return


@app.cell
def _(mo):
    mo.md(
        r"""
    ## Guía de estilo para el cuaderno

    [Esta sección se puede borrar. Únicamente se presenta para dejar documentadas las prácticas recomendadas para estructurar el cuederno.]

    - Como práctica recomendada por **marimo**, se debe empezar siempre con una celda que contenga: `import marimo as mo` 
    - Usar un encabezado H1 para el título.
    - Incluir la barra de botones inmediatamente después de los Autores.
    - Incluye una sección de visión general antes de cualquier código.
    - Ubicar todas las instalaciones de libarías y configuraciones en una sección de configuración.
    - Mantener las celdas de código y texto lo más breves posible.
    - Separar las celdas de texto con encabezados.
    - Dividir las celdas de código entre "construcción" y "ejecución", y entre "mostrar un resultado" y "mostrar otro resultado".
    """
    )
    return


@app.cell
def _(mo):
    mo.md(
        r"""
    ## Guía de estilo para el código

    [Esta sección se puede borrar. Únicamente se presenta para dejar documentadas las prácticas recomendadas para estructurar el código dentro del cuaderno.]

    - Los notebooks son para personas. Escriba el código optimizado para la claridad.
    - Use la Guía de estilo de Python de Google ([Google Python Style Guide](http://google.github.io/styleguide/pyguide.html)), cuando sea aplicable.
    - Mantenga los ejemplos breves. Use conjuntos de datos pequeños o fragmentos reducidos de ellos.
    - Si define una función, ejecútela y muestre lo que hace antes de usarla dentro de otra función.
    - Demuestre partes pequeñas antes de combinarlas en algo más complejo, como en el siguiente ejemplo:
    """
    )
    return


@app.cell
def _(configuracion):
    # Load environmental variables, example
    configuracion.admin_email
    return


@app.cell
def _(log):
    # Try the logger
    log.info("Eso es todo, log fácil!")
    return


@app.cell
def _():
    # Build the model
    # model = tf.keras.Sequential(
    #    [
    #        tf.keras.layers.Dense(10, activation="relu", input_shape=(None, 5)),
    #        tf.keras.layers.Dense(3),
    #    ]
    # )
    return


@app.cell
def _(mo):
    mo.md(r"""Run the model on a single batch of data, and inspect the output:""")
    return


@app.cell
def _():
    # result = model(tf.constant(np.random.randn(10, 5), dtype=tf.float32)).numpy()

    # print("min:", result.min())
    # print("max:", result.max())
    # print("mean:", result.mean())
    # print("shape:", result.shape)
    return


@app.cell
def _(mo):
    mo.md(r"""Compile the model for training:""")
    return


@app.cell
def _():
    # model.compile(
    #    optimizer=tf.keras.optimizers.Adam(), loss=tf.keras.losses.categorical_crossentropy
    # )
    return


@app.cell
def _(mo):
    mo.md(
        r"""
    ## Guía de estilo para textos

    [Esta sección se puede borrar. Únicamente se presenta para dejar documentadas las prácticas recomendadas para estructurar el texto dentro del cuaderno.]

    - Use estilo imperativo. Por ejemplo: "Ejecuta un lote de imágenes a través del modelo."
    - Use mayúsculas solo al inicio en títulos y encabezados.
    - Utilice títulos y encabezados cortos: "Descargar los datos", "Construir el modelo", "Entrenar el modelo".
    - Siga la Guía de estilo para documentación de desarrolladores de Google ([Google developer documentation style guide](https://developers.google.com/style/highlights)).
    """
    )
    return


@app.cell
def _(mo):
    mo.md(r"""### Ejemplo de uso de LaTeX""")
    return


@app.cell
def _(mo):
    mo.md(
        r"""
    La función exponencial $f(x) = e^x$ puede ser representada de la siguiente forma:

    \[
        f(x) = 1 + x + \frac{x^2}{2!} + \frac{x^3}{3!} + \ldots.
    \]
    """
    )
    return


if __name__ == "__main__":
    app.run()
