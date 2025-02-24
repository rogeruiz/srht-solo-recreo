# Load the libraries coming from the `bats/bats` Docker image
bats_load_library bats-support
bats_load_library bats-assert
bats_load_library bats-file
# Require a minimum version
bats_require_minimum_version 1.5.0

@test "can run default help" {
  run just help
  assert_success
  assert_output --partial 'Available recipes:'
  assert_output --partial '[docs]'
  assert_output --partial '[lint]'
  assert_output --partial '[test]'
  assert_output --partial '[utils]'
}

@test "can run help for just checks" {
  run just check help
  assert_success
  assert_output --partial '[terminal]'
  assert_output --partial 'cli'
}

@test "can run help for just new ..." {
  run just new help
  assert_success
  assert_output --partial '[docs]'
  assert_output --partial 'decisions'
  assert_output --partial 'Create a new decision'
  assert_output --partial 'guides'
  assert_output --partial 'Create a new guide'
  assert_output --partial 'run-books'
  assert_output --partial 'Create a new run book'
  run just n help
  assert_success
  assert_output --partial '[alias: d]'
  assert_output --partial '[alias: g]'
  assert_output --partial '[alias: rb]'
}
