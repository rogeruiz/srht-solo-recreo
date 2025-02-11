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
- Tener una manera de saber si una aplicación esta instalada y se puede
  encontrar en el variable del camino, `$PATH`, en el terminal.

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

### Recetes de tipo haga-nada

Los guiones haga-nada son inspirado por [el ensayo de Dan Slimmon sobre el
tema][haga-nada]. Usando las recetas privadas, `[private]`, se puede combinar
diferente recetas en una series de pasos. Con este tipo de receta se puede
empezar la automatización sin el trabajo de actualmente automatizar los pasos.
Con las recetas haga-nada, se puede minimizar el tiempo pa' ejecutar procesos en
un equipo. También con este estilo se puede iterar más rápido ciertas partes de
la automatización mientras los comandos no cambian en el la documentación y el
proceso de un libro ejecutor (run book).

Ejecutar este comando en su terminal para probarlo.

```sh
just run-book setup-user "a_user_name"
```

Note que las recetas privadas en este ejemplo se pueden remplazar poco a poco
con varios otros comandos que `just` soporta.

### Verificando que algo esta instalado

Con la recetas que usan varias herramientas, es importante que verifiquen que
están instaladas en el camino, `$PATH`, de el terminal que estas usando. El
módulo `check` y la receta `cli` ayudan para ver si la herramienta esta
instalada. Si no esta instalada, el segundo parámetro a la receta `cli` se usa
para proporcionar un enlace para descargar la herramienta desaparecida.

Ejecutar este comando en su terminal para probarlo. Cambie la cadena de texto
`"zsh"` con un programa que no existe en el camino pa' que falle. Asegúrate de
cambiar el segundo parámetro para proporcionar las instrucciones de descarga
para los usuarios que no tengan la herramienta instalada.

```sh
just check cli "zsh" "https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH#macos"
```

[haga-nada]: https://blog.danslimmon.com/2019/07/15/do-nothing-scripting-the-key-to-gradual-automation/
