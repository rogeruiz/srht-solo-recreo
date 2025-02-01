set allow-duplicate-variables := true

here := justfile_directory() + '/.justscripts/new.just'

alias help := default
alias h := default
alias d := decisions
alias rb := run-books
alias g := guides

[private]
@default:
    just --list --justfile {{ here }}

# @variable type
# @type string
# @description A string representing the singular name to use when outputting
# messages from the main _create recipe defined in `new.just`.

type := "decision record"

# @variable folder
# @type string
# @description A string representing the file path relative to the root of the
# repository which contains the .template and where the files are being
# created.

folder := "docs/decisions"

[doc('Create a new decision from the Markdown template found in docs/decisions/.template')]
@decisions title:
    just --justfile {{ justfile() }} new _create "{{ title }}" "{{ type }}" "{{ folder }}"

# @variable type
# @type string
# @description A string representing the singular name to use when outputting
# messages from the main _create recipe defined in `new.just`.

type := "run book"

# @variable folder
# @type string
# @description A string representing the file path relative to the root of the
# repository which contains the .template and where the files are being
# created.

folder := "docs/run-books"

[doc('Create a new run book from the Markdown template found in docs/run-books/.template')]
@run-books title:
    just --justfile {{ justfile() }} new _create "{{ title }}" "{{ type }}" "{{ folder }}"

# @variable type
# @type string
# @description A string representing the singular name to use when outputting
# messages from the main _create recipe defined in `new.just`.

type := "guide"

# @variable folder
# @type string
# @description A string representing the file path relative to the root of the
# repository which contains the .template and where the files are being
# created.

folder := "docs/guides"

[doc('Create a new run book from the Markdown template found in docs/guides/.template')]
@guides title:
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
