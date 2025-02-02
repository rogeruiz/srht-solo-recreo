set windows-shell := ['powershell.exe', '-NoLogo', '-Command']

alias help := default
alias h := default

[private]
@default:
    just --list

mod new '.justscripts/new.just'

[doc('Format justfiles in project using `git`, `grep`, and `just --fmt using `/bin/sh`')]
[unix]
@fmt:
    for file in $(git status --porcelain | grep '^M' | grep -o -E '[a-zA-Z_0-9\./]*justfile'); do if [[ -n $file ]]; then just --justfile=$file --fmt --unstable; fi; done

[doc('Format justfiles in project using `git`, `Select-String`, `ForEach-Object` using powershell.exe')]
[windows]
@fmt:
    (git status --porcelain | Select-String -Pattern '^M' -Raw | Select-String -Pattern '[\d\w/\.]*justfile').Matches.Value | ForEach-Object -Process { if ($_) { just.exe --justfile=$_ --fmt --unstable } }
