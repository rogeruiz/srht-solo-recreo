set windows-shell := ['powershell.exe', '-NoLogo', '-Command']

alias help := default
alias h := default
alias d := decisions
alias rb := run-books
alias g := guides

[private]
@default:
    just --list --justfile '{{ justfile_directory() }}/.justscripts/new.just'

[doc('Create a new decision from the Markdown template found in docs/decisions/.template')]
[group('docs')]
@decisions title:
    just --justfile {{ justfile() }} new _create "{{ title }}" "decision record" "docs/decisions"

[doc('Create a new run book from the Markdown template found in docs/run-books/.template')]
[group('docs')]
@run-books title:
    just --justfile {{ justfile() }} new _create "{{ title }}" "run book" "docs/run-books"

[doc('Create a new run book from the Markdown template found in docs/guides/.template')]
[group('docs')]
@guides title:
    just --justfile {{ justfile() }} new _create "{{ title }}" "guide" "docs/guides"

# README: This is here to support NodeJS shebang recipes across operating
# systems. https://just.systems/man/en/chapter_43.html

node_shebang := if os_family() == "windows" { " node" } else { "/usr/bin/env node" }

# HACK: The private recipe below named `_create` is **only** called from other
# recipes that create files from .template files found in the folder passed
# into them.
# It also uses `read()` to pull in language specific scripts that are in-lined
# in the recipe.

[private]
_create title type folder:
    #!{{ node_shebang }}
    // en: Variables are hoisted here are coming from `just` and are used in
    // the file being read.
    // es: Variables definado aquí vienen desde `just` y se usan en el archivo
    // que estamos leyendo.
    const title = "{{ title }}"
    const fileTitle = "{{ kebabcase(title) }}"
    const type = "{{ type }}"
    const normalizedPath = "{{ replace(justfile_directory(), '\', '/') }}"
    const folderPath = "{{ folder }}"
    {{ read('./js/create.js') }}
