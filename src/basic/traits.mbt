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
  if self.is_zero() {
    integer_zero
  } else if self == 1 {
    integer_one
  } else if self <= 2147483647N && self >= -2147483648N {
    IntegerInt(self.to_int())
  } else if self <= 9223372036854775807N && self >= -9223372036854775808N {
    IntegerInt64(self.to_int64())
  } else {
    Integer(self)
  }
}
