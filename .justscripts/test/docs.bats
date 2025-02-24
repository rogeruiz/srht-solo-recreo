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
