# Sólo recreo

> 👀 **Look**
>
> To read this in [English, click here](https://git.sr.ht/~rogeruiz/solo-recreo/tree/main/item/README.en.md).

El repositorio de `solo-recreo` es un laboratorio de el programa `just` que se
usa con interfaz en un terminal. Los ejemplos y guiones que están aquí son
diferente maneras de configurar proyectos usando `just` pa' varias cosas y
casos. Unos ejemplos siguen:

- Creando nuevos archivos de tipos de documentación como decisiones (ADR),
  libros de pasos (run books), y más usando un modelo o patrón.
- Usando una lengua de programación para recetas que usen archivos guion escrito
  en archivos separados de los archivos de `just`.
- Varios ejemplos de guiones tipo haga-nada (do-nothing) que establecen
  practicas para automatización que no esta automatizado ahorra y se puede
  automatizar gradualmente. [Más sobre este tema esta escrito aquí][haga-nada].

Este proyecto sigue la version mas reciente de `just`: [1.39.0](https://github.com/casey/just/releases/tag/1.39.0)

## Arquitectura

Este repositorio se puede usar como un ejemplo vivo pa' como se debe organizar
los archivos y recetas para un proyecto maduro usando la herramienta `just`.

Las recetas de `just` se escribir así: `just <receta> [parámetros]`.

Las carpeta de `.justscripts/` se usa para guardar y esconder los archivos que
se pueden crear pa' extender las funciones de `just` con módulos pa' crear
comandos secundarios. Esto ayuda a separar las recetas de una manera más
practica.

Este tipo de receta se escribir así: `just <módulo> <receta> [parámetros]`.

### Carpetas adentro de `.justscripts/`

Esta carpeta se puede organizar de cualquier manera. Lo que recomendó es poner
los guiones adentro de carpetas nombradas por la lengua de programación. Así es
que los guiones escritos pa' Node.js se ponen en una carpeta nombrada `js/`. Con
este tipo de separación, las recetas `just` y los guiones escritos en JavaScript
están en su propio archivo. Una cosa de tomar en cuenta es que por esta razón,
los variables que se capturan en `just` para usarlos en el guion leído en las
recetas se tienen que definir antes de leer el archivo con los guiones. [Lea más
sobre shebangs](#recetas-usando-shebang).

### Recetas usando shebang

Para las carpetas de lenguajes en `.justscripts/`, los guiones aquí se pueden
poner adentro de recetas `just` con la función `read()` que se añadió en versión
`1.39.0`. Esto nos deja escribir guiones en el lenguaje apropiado. La linea
actual de el shebang se defina en la receta `just` con los variables que se
necesitan pa' que corra el guion shebang.

Este método se usa en las siguiente recetas en este proyecto.

- `just new decisions "Titolo para documento ADR"`
- `just new run-books "Titolo para documento de libro de pasos"`
- `just new guides "Titolo para documento de guia"`

Este tipo de abstracción es útil pa' las recetas que son reutilizable y las
recetas se usan pa' configurar opciones pa' cuando se correr la receta.

---

# Just recess

The repository `solo-recreo` is a lab for the `just` CLI tool. The examples and
scripts here are different ways to configure projects using `just` for a variety
of cases. Some examples follow:

- Creating new files for documentation types like decisions (ADR), run books,
  and more using templates or patterns.
- Using a programming language for recipes that use script files written in
  files separate from the `just` files.
- Various examples of do-nothing scripts that establish best-practices for
  automation that is not automated yet and can be further automated gradually.
  [Read more about this here][haga-nada].

This project follows the most recent version of `just`: [1.39.0](https://github.com/casey/just/releases/tag/1.39.0)

## Architecture

This repository can be used as an live-example for how to organize files and
recipes for a mature project that utilizes `just`.

The `just` recipes are written like: `just <recipe> [arguments]`.

The directory `.justscripts/` is used to organize and separate the files that
you can create to extend `just` functionality using modules to create
sub-commands. This helps in separating recipes in practical ways.

This kind of recipe is written like: `just <module> <recipe> [arguments]`.

### Folders inside of `.justscripts/`

Inside this folder, you can organize things any way you want. I recommend
putting all scripts inside of folders named after the programming language. That
way scripts written for Node.js are placed inside of `js/`. With this kind of
separation, the `just` recipes and the JavaScript scripts are stored in their
appropriate file. Something to have in mind, variables that are set from `just`
need to be defined before the script file is read into the recipe. [Read more
about shebangs](#shebang-recipes).

### Shebang recipes

For the language folders in `.justscripts/`, the scripts here can be read into
`just` recipes using the `read()` function added in version `1.39.0`. This
allows for easy authoring of scripts in the language they're being written in.
The actual shebang line for the shebang recipes is written within the `just`
recipe along with any variable definitions that the shebang script is expecting.

This technique is what current powers the following recipes in this project.

- `just new decisions "Title for ADR document"`
- `just new run-books "Title for run book document"`
- `just new guides "Title for guide document"`

This kind of abstraction can be used for recipes that are going to be re-used
and mostly need a way to configure options for the recipe run.

[haga-nada]: https://blog.danslimmon.com/2019/07/15/do-nothing-scripting-the-key-to-gradual-automation/
