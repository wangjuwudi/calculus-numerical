///|
pub(all) enum Integer {
  IntegerInt(Int)
  IntegerInt64(Int64)
  Integer(BigInt)
} //derive(Eq, Compare, Show)

///|
pub let integer_zero : Integer = IntegerInt(0)

///|
pub let integer_one : Integer = IntegerInt(1)

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
