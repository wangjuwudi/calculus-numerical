///|
/// Represents arbitrary-precision integers using a nested structure of different
/// integer types. Uses the most efficient representation based on the value's
/// magnitude, automatically selecting between 32-bit integers (`Int`), 64-bit
/// integers (`Int64`), and arbitrary-precision integers (`BigInt`).
///
/// Each variant represents a different size of integer:
///
/// * `IntegerInt`: For values that fit in a 32-bit signed integer (-2^31 to
/// 2^31-1)
/// * `IntegerInt64`: For values that fit in a 64-bit signed integer (-2^63 to
/// 2^63-1)
/// * `Integer`: For values that require arbitrary precision
///
/// Example:
///
/// ```moonbit
/// test "Integer/construction" {
///   let small = IntegerInt(42)
///   let large = IntegerInt64(9223372036854775807L)
///   let huge = Integer(9223372036854775808N)
///   inspect!(small, content="IntegerInt(42)")
///   inspect!(large, content="IntegerInt64(9223372036854775807)")
///   inspect!(huge, content="Integer(9223372036854775808)")
/// }
/// ```
pub(all) enum Integer {
  IntegerInt(Int)
  IntegerInt64(Int64)
  Integer(BigInt)
} //derive(Eq, Compare, Show)

///|
pub let integer_zero : Integer = IntegerInt(0)

///|
pub let integer_one : Integer = IntegerInt(1)
