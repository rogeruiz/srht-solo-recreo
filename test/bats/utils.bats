# Ensayos util :: Utility tests
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
