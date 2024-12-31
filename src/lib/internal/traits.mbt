///|
pub(open) trait Integral: Eq + Compare + Show {
  to_integer(Self) -> Integer
}

///|
pub impl Integral for Int with to_integer(self) { IntegerInt(self) }

///|
pub impl Integral for Int64 with to_integer(self) {
  if self >= @int.min_value.to_int64() && self <= @int.max_value.to_int64() {
    IntegerInt(self.to_int())
  } else {
    IntegerInt64(self)
  }
}

///|
pub impl Integral for BigInt with to_integer(self) {
  if self == 0 {
    integer_zero
  } else if self == 1 {
    integer_one
  } else {
    Integer(self)
  }
}
