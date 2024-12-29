test "integer odd test" {
  assert_eq!(@lib.is_odd(1), true)
}

test "integer even test" {
  assert_eq!(@lib.is_even(1), false)
}

test "integer sign test" {
  assert_eq!(@lib.sign(1), 1)
}
