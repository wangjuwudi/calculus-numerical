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
