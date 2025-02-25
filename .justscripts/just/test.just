# Recetas pa' ensayos usando Bats y Docker :: Recipes for tests using Bats &
# Docker
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

alias h := default
alias help := default
alias b := bats

[doc('Shows available recipes...')]
[private]
@default:
    just -l test

dir := absolute_path("../../test/bats")
tag := "rogeruiz/test-solo-recreo:latest"
tar_file := "rogeruiz-test-solo-recreo-latest.tar"
working_dir := "/opt/test"
# These Go template strings need to be assigned outside of recipes to avoid Just
# interpreting them as substitutions and unnecessarly escaping the curly braces.
find_build_template_str := "{{.Repository}}:{{.Tag}}"
find_id_template_str := "{{.Id}}"

# Build the image locally using Docker
[private]
@_bats-build:
    if test -z $( docker images {{ tag }} --format {{ find_build_template_str }} ); then \
      docker build --tag {{ tag }} \
        --build-arg CI=${CI:-true} \
        --file {{ dir }}/Dockerfile \
        {{ dir }}; \
    fi

# Save the image as a .tar file for loading
[private]
@_bats-cache-image-locally: (_bats-build)
    mkdir -p {{ justfile_directory() }}/tmp
    docker save -o {{ justfile_directory () }}/tmp/{{ tar_file }} {{ tag }}
    if test -d ~/.image-cache; then \
      cp {{ justfile_directory() }}/tmp/{{ tar_file }} ~/image-cache/{{ tar_file }}; \
    fi

# Save the image as a .tar file for loading
[private]
@_bats-load-image-locally:
    if test -d ~/.image-cache; then \
      docker load -i ~/image-cache/{{ tar_file }}; \
    fi

# Get the SHA256 digest for the image
[private]
@_bats-sha256-docker: (_bats-cache-image-locally)
    docker image inspect {{ tag }} -f {{ find_id_template_str }}


[doc('Run the test-just suite')]
[group('test')]
bats: (_bats-build)
    docker run -t \
      -v "{{ justfile_directory() }}:{{ working_dir }}" \
      {{ tag }} \
      {{ working_dir }}/test/bats

