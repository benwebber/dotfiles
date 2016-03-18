#!/usr/bin/env bats
# vim: set ft=sh:

load test_helper

@test 'no arguments: print list of paths in $PATH' {
  run path
  assert_success
  assert_equal /usr/local/bin "${lines[0]}"
  assert_equal /usr/bin "${lines[1]}"
  assert_equal /bin "${lines[2]}"
}

@test '-h: prints help' {
  run path -h
  [ $(expr "${lines[0]}" : "usage:") -ne 0 ]
}

@test '-p: can access variable other than $PATH' {
  run path -p $NON_DEFAULT_PATH first
  assert_output /foo
}

@test 'at: returns 0-indexed position of path in $PATH' {
  run path at 1
  assert_success
  assert_output /usr/bin
}

@test 'at: fails if position exceeds length of $PATH' {
  run path at 3
  assert_failure
}

@test 'contains: returns 0 if the path is in $PATH' {
  run path contains /bin
  assert_success
}

@test 'contains: returns 1 if the path is in $PATH' {
  run path contains /sbin
  assert_failure
}

@test 'delete: removes paths from $PATH' {
  OLD_PATH="${PATH}"
  path delete /bin
  assert_equal /usr/local/bin:/usr/bin $PATH
  path delete /usr/local/bin
  assert_equal /usr/bin $PATH
  export PATH="${OLD_PATH}"
}

@test 'first: prints first path in $PATH' {
  run path first
  assert_success
  assert_output /usr/local/bin
}

@test 'help: prints help' {
  run path help
  [ $(expr "${lines[0]}" : "usage:") -ne 0 ]
}

@test 'index: returns the 0-indexed position of path in $PATH' {
  run path index /bin
  assert_success
  assert_output 2
}

@test 'index: fails if path is not in $PATH' {
  run path index /foo
  assert_failure
}

@test 'insert: prepends paths to $PATH' {
  OLD_PATH="${PATH}"
  path insert /sbin
  assert_equal /sbin:/usr/local/bin:/usr/bin:/bin $PATH
  export PATH="${OLD_PATH}"
}

@test 'last: prints first path in $PATH' {
  run path last
  assert_success
  assert_output /bin
}

@test 'length: returns the number of paths in $PATH' {
  run path length
  assert_success
  assert_output 3
}

@test 'push: appends paths to $PATH' {
  OLD_PATH="${PATH}"
  path push /sbin
  assert_equal /usr/local/bin:/usr/bin:/bin:/sbin $PATH
  export PATH="${OLD_PATH}"
}

