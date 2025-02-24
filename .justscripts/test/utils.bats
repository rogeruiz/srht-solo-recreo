# Load the libraries coming from the `bats/bats` Docker image
bats_load_library bats-support
bats_load_library bats-assert
bats_load_library bats-file
# Require a minimum version
bats_require_minimum_version 1.5.0

setup() {
  export bold
  export italic
  export normal
  bold=$(tput bold)
  italic=$(tput sitm)
  normal=$(tput sgr0)
}

@test "can run help for just checks" {
  run just check help
  assert_success
  assert_output --partial '[terminal]'
  assert_output --partial 'cli'
}

@test "checking for CLI tool that exists" {
  run just check cli "just" "https://just.systems/man/en"
  assert_success
  # shellcheck disable=SC2016
  assert_output --partial "${italic}\`just\`${normal} is ${bold}installed${normal}"
}

@test "checking for CLI tool that doesn't exists" {
  local cli_name
  local url
  cli_name="example-missing"
  url="https://example.com/install"
  run just check cli ${cli_name} ${url}
  assert_failure 2
  assert_output --partial "Please install ${italic}\`${cli_name}\`${normal}: ${bold}${url}${normal}"

}
