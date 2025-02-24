# Recetas pa' documentación nueva :: Documentation creation recipes
# Public Domain (CC0) 2025 Roger Steve Ruiz
#
# This program is free software: you can redistribute it and/or modify it
# freely. It is in the public domain within the United States.
#
# The person who associated a work with this deed has dedicated the work to the
# public domain by waiving all of his or her rights to the work worldwide under
# copyright law, including all related and neighboring rights, to the extent
# allowed by law.
#
# You can copy, modify, distribute and perform the work, even for commercial
# purposes, all without asking permission.
#
# In no way are the patent or trademark rights of any person affected by CC0, nor
# are the rights that other persons may have in the work or in how the work is
# used, such as publicity or privacy rights.
#
# Unless expressly stated otherwise, the person who associated a work with this
# deed makes no warranties about the work, and disclaims liability for all uses of
# the work, to the fullest extent permitted by applicable law. When using or
# citing the work, you should not imply endorsement by the author or the affirmer.
#
# You should have received a copy of the CC0 1.0 Universal License along with
# this program. If not, see <https://creativecommons.org/publicdomain/zero/1.0/>.

set windows-shell := ['powershell.exe', '-NoLogo', '-Command']

alias help := default
alias h := default
alias d := decisions
alias rb := run-books
alias g := guides

[private]
@default:
    just --list new

[doc('Create a new decision from the Markdown template found in docs/decisions/.template')]
[group('docs')]
@decisions title:
    just --justfile {{ justfile() }} new _create "{{ title }}" "decision record" "docs/decisions"

[doc('Create a new run book from the Markdown template found in docs/run-books/.template')]
[group('docs')]
@run-books title:
    just --justfile {{ justfile() }} new _create "{{ title }}" "run book" "docs/run-books"

[doc('Create a new guide from the Markdown template found in docs/guides/.template')]
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
    {{ read('../js/create.js') }}
