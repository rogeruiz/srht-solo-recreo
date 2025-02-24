# Ensayos de run books :: Run book tests
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

@test "can run help for just run-book" {
  run just run-book help
  assert_success
  assert_output --partial 'Available recipes:'
  assert_output --partial '[process]'
  run just rb h
  assert_success
  assert_output --partial 'setup-user'
  refute_output --partial 'run-cmd'
  refute_output --partial 'build-watch'
  refute_output --partial 'gwt-user-email'
  refute_output --partial 'send-private-key'
  refute_output --partial 'git-commit'
}

@test "can run just run-book run-cmd" {
  run just run-book run-cmd "command"
  assert_success
  assert_output --partial 'Run:
	command'
}

@test "can run just run-book build-watch" {
  local url
  url="https://example.com"
  run just run-book build-watch "${url}"
  assert_success
  assert_output --partial "Wait for this build job to finish: ${url}"
}

@test "can run just run-book get-user-email" {
  local email
  email="test@example.com"
  run just run-book get-user-email "${email}"
  assert_success
  assert_output --partial "Find the email address for user: <${email}>."
}

@test "can run just run-book send-private-key" {
  local email
  email="test@example.com"
  run just run-book send-private-key "${email}"
  assert_success
  assert_output --partial "Share the document with <${email}>."
}

@test "can run just run-book git-commit" {
  local name
  name="yo"
  run just run-book git-commit "${name}"
  assert_success
  assert_output --partial "git commit ${name}"
  assert_output --partial "git push"
}