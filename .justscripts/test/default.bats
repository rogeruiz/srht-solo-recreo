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
