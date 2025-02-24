set windows-shell := ['powershell.exe', '-NoLogo', '-Command']

alias h := default
alias help := default
alias b := bats

[doc('Shows available recipes...')]
[private]
@default:
    just -l test

dir := absolute_path("../test")
tag := "rogeruiz/test-solo-recreo:latest"
tar_file := "rogeruiz-test-solo-recreo-latest.tar"
working_dir := "/opt/test"
# These Go template strings need to be assigned outside of recipes to avoid Just
# interpreting them as substitutions and unnecessary escaping of curly braces.
find_build_template_str := "{{.Repository}}:{{.Tag}}"
find_id_template_str := "{{.Id}}"

# Build episync/test-just:latest locally using Docker
[private]
@_bats-build:
    if test -z $( docker images {{ tag }} --format {{ find_build_template_str }} ); then \
      docker build --tag {{ tag }} \
        --file {{ dir }}/bats.dockerfile \
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
      {{ working_dir }}/.justscripts/test

