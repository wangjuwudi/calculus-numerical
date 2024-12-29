test "integer odd test" {
  assert_eq!(@math.is_odd(1), true)
}

test "integer even test" {
  assert_eq!(@math.is_even(1), false)
}

test "integer sign test" {
  assert_eq!(@math.sign(1), 1)
}
