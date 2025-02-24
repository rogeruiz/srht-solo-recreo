# Recetas de libro ejecutador :: Run book recipes
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
    just --list run-book

[confirm('Ready for the next step? [y/n] ')]
[private]
@wait:
    printf '###\n'

[private]
@run-cmd cmd:
    printf '%s\n\t%s\n' 'Run:' '{{ cmd }}'
    if test $CI != "true"; then just rb wait; fi

[private]
@git-commit username:
    printf '%s\n' 'Copy ~/new_key.pub into the `user_keys` Git repository, then run:'
    printf '\t%s\n' 'git commit {{ username }}'
    printf '\t%s\n' 'git push'
    if test $CI != "true"; then just rb wait; fi

[private]
@build-watch url:
    printf 'Wait for this build job to finish: %s\n' '{{ url }}'
    if test $CI != "true"; then just rb wait; fi

[private]
@get-user-email username:
    printf 'Go to %s:\n' 'https://example.com/directory'
    printf 'Find the email address for user: <%s>.\n' '{{ username }}'
    printf 'Copy the email address to your clipboard for the next step.\n' 
    if test $CI != "true"; then just rb wait; fi

[private]
@send-private-key email:
    printf 'Go to 1Password.\n'
    printf 'Paste the contents of ~/new_key into a new document.\n'
    printf 'Share the document with <%s>.\n' '{{ email }}'
    if test $CI != "true"; then just rb wait; fi

[doc('Setup a user')]
[group('process')]
@setup-user username="yo":
    just rb run-cmd 'ssh-keygen -t rsa -f ~/{{ username }}'
    just rb git-commit {{ username }}
    just rb build-watch 'https://example.com/builds/user_keys'
    just rb get-user-email {{ username }}
    just rb send-private-key $(pbpaste)
