here := justfile_directory() + '/.justscripts/new.just'

alias help := default
alias h := default

[private]
@default:
    just --list --justfile {{ here }}

# @variable type
# @type string
# @description A string representing the singular name to use when outputting
# messages from the main _new recipe defined at the root `justfile`.

type := "decision record"

# @variable folder
# @type string
# @description A string representing the file path relative to the root of the
# repository which contains the .template.md and where the files are being
# created.

folder := "docs/decisions"

[doc('Create a new decision from the template found in docs/decisions/.template')]
@decisions title:
    just --justfile {{ justfile() }} new _create "{{ title }}" "{{ type }}" "{{ folder }}"

# README: This is here to support Shebang recipes across operating systems.
# https://just.systems/man/en/chapter_43.html

node_shebang := if os_family() == "windows" { " node" } else { "/usr/bin/env node" }

# NOTE: The recipe below named `_new` is **only** called from other Justfiles
# that create files from .template files found next to them. Currently it's
# used in `docs/guides`, `docs/runbooks`, and `docs/decisions`.

[private]
_create title type folder:
    #!{{ node_shebang }}
    // NOTE: Variables hosted here are coming from `just`.
    // es: Variables definado aquí vienen desde `just`.
    const title = "{{ title }}"
    const fileTitle = "{{ kebabcase(title) }}"
    const type = "{{ type }}"
    const normalizedPath = "{{ replace(justfile_directory(), '\', '/') }}"
    const folderPath = "{{ folder }}"
    {{ read('./create.js') }}
