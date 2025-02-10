# Recetas pa' chequear :: Checking recipes
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

alias help := default
alias h := default

[private]
@default:
    just --list check

pass_emoji := "✅"
fail_emoji := "❌"

[doc("Checks for CLI tool")]
[unix]
[group('terminal')]
cli app docs="https://example.com/docs/install":
    #!/usr/bin/env bash
    set -uo pipefail
    bold=$(tput bold)
    normal=$(tput sgr0)
    italic=$(tput sitm)

    if [[ -x $(which {{ app }}) ]]
    then
      echo "{{ pass_emoji }} ${italic}\`{{ app }}\`${normal} is ${bold}installed${normal}"
      exit
    else
      echo "{{ fail_emoji }} Please install ${italic}\`{{ app }}\`${normal}: ${bold}{{ docs }}${normal}"
      exit 2
    fi
