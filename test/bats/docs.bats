# Ensayos pa' documentación :: Documentation tests
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
  export today
  today=$(date +"%Y-%m-%d")
}

teardown_file() {
  rm -rvf /opt/test/docs/decisions/*-test-a-new-*.md
  rm -rvf /opt/test/docs/guides/*-test-a-new-*.md
  rm -rvf /opt/test/docs/run-books/*-test-a-new-*.md
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

@test "creating decisions requires a title argument" {
  run just new decisions
  assert_failure
  assert_output --partial 'error:'
  assert_output --partial 'got 0 arguments but takes 1'
}

@test "creating guides requires a title argument" {
  run just new guides
  assert_failure
  assert_output --partial 'error:'
  assert_output --partial 'got 0 arguments but takes 1'
}

@test "creating run books require a title argument" {
  run just new run-books
  assert_failure
  assert_output --partial 'error:'
  assert_output --partial 'got 0 arguments but takes 1'
}

@test "creating a decision record" {
  run just new decisions "test A new decision Record"
  assert_success
  assert_exists /opt/test/docs/decisions/*-test-a-new-decision-record.md
  assert_file_not_empty /opt/test/docs/decisions/*-test-a-new-decision-record.md
  assert_file_contains /opt/test/docs/decisions/*-test-a-new-decision-record.md '. test A new decision Record'
  assert_file_contains /opt/test/docs/decisions/*-test-a-new-decision-record.md "${today}"
  assert_file_contains /opt/test/docs/decisions/*-test-a-new-decision-record.md '## Status

Proposed'
}

@test "creating a guide" {
  run just new guides "test A new guidE"
  assert_success
  assert_exists /opt/test/docs/guides/*-test-a-new-guid-e.md
  assert_file_not_empty /opt/test/docs/guides/*-test-a-new-guid-e.md
  assert_file_contains /opt/test/docs/guides/*-test-a-new-guid-e.md '## test A new guidE'
  assert_file_contains /opt/test/docs/guides/*-test-a-new-guid-e.md '### Step 1'
  assert_file_contains /opt/test/docs/guides/*-test-a-new-guid-e.md '#### Sub-Step 1.a'
}

@test "creating a run book" {
  run just new run-books "test A new Run Book"
  assert_success
  assert_exists /opt/test/docs/run-books/*-test-a-new-run-book.md
  assert_file_not_empty /opt/test/docs/run-books/*-test-a-new-run-book.md
  assert_file_contains /opt/test/docs/run-books/*-test-a-new-run-book.md '. test A new Run Book'
  assert_file_contains /opt/test/docs/run-books/*-test-a-new-run-book.md "${today}"
  assert_file_contains /opt/test/docs/run-books/*-test-a-new-run-book.md '### Service details'
  assert_file_contains /opt/test/docs/run-books/*-test-a-new-run-book.md '### Confirm the problem'
  assert_file_contains /opt/test/docs/run-books/*-test-a-new-run-book.md '### Resolution options'
  assert_file_contains /opt/test/docs/run-books/*-test-a-new-run-book.md '### Notes'
  assert_file_contains /opt/test/docs/run-books/*-test-a-new-run-book.md '### Other run books to reference'
}
