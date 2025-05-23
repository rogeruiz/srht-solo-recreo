# Sólo recreo :: Just recess
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

[private]
@default:
    just --list

# Alias for `new` recipes
[group('docs')]
mod n './.justscripts/just/new.just'
# Recipes for creating files
[group('docs')]
mod new './.justscripts/just/new.just'

# Alias for `run-book` recipes
[group('docs')]
mod rb './.justscripts/just/run-book.just'
# Recipes for performing actions within run book documentation
[group('docs')]
mod run-book './.justscripts/just/run-book.just'

# Alias for `check` recipes'
[group('utils')]
mod ch './.justscripts/just/check.just'
# Recipes for checking things
[group('utils')]
mod check './.justscripts/just/check.just'

# Alias for `test` recipes'
[group('test')]
mod t './.justscripts/just/test.just'
# Recipes for checking things
[group('test')]
mod test './.justscripts/just/test.just'

[doc('Format justfiles in project using `git`, `grep`, and `just --fmt using `/bin/sh`')]
[unix]
[group('lint')]
@fmt:
    for file in $(git status --porcelain | grep '^M' | grep -o -E '[a-zA-Z_0-9\./]*justfile'); do if [[ -n $file ]]; then just --justfile=$file --fmt --unstable; fi; done

[doc('Format justfiles in project using `git`, `Select-String`, `ForEach-Object` using powershell.exe')]
[windows]
[group('lint')]
@fmt:
    (git status --porcelain | Select-String -Pattern '^M' -Raw | Select-String -Pattern '[\d\w/\.]*justfile').Matches.Value | ForEach-Object -Process { if ($_) { just.exe --justfile=$_ --fmt --unstable } }

alias diga_hola := say_hello

[unix]
say_hello users_name:
    #!/usr/bin/env ruby
    name = "{{ users_name }}"
    {{ read('./.justscripts/rb/say.rb') }}
