///|
/// Defines a conversion interface for numeric types that can be converted to
/// arbitrary-precision integers. Requires the implementing type to also
/// implement `Eq`, `Compare`, and `Show` traits.
///
/// Parameters:
///
/// * `Self` : The type implementing this trait. Must be a type that can be
/// converted to an `Integer`.
///
/// Returns an `Integer` value that represents the same number as the original
/// value.
///
/// Example:
///
/// ```moonbit
/// test "Integral/conversion" {
///   let x : Int = 42
///   let y : Int64 = 9223372036854775807L
///   inspect!(Integral::to_integer(x), content="IntegerInt(42)")
///   inspect!(Integral::to_integer(y), content="IntegerInt64(9223372036854775807)")
/// }
/// ```
pub(open) trait Integral: Eq + Compare + Show {
  to_integer(Self) -> Integer
}

///|
/// Implements the `Integral` trait for 32-bit signed integers by converting them
/// to the most efficient `Integer` representation.
///
/// Parameters:
///
/// * `self` : A 32-bit signed integer value to be converted.
///
/// Returns an `Integer` variant that wraps the input value in `IntegerInt`
/// constructor.
///
/// Example:
///
/// ```moonbit
/// test "Integral::to_integer/int" {
///   let x : Int = 42
///   inspect!(Integral::to_integer(x), content="IntegerInt(42)")
/// }
/// ```
pub impl Integral for Int with to_integer(self) { IntegerInt(self) }

///|
/// Implements the `Integral` trait for 64-bit signed integers by converting them
/// to the most efficient `Integer` representation. Automatically selects between
/// 32-bit and 64-bit integer representations based on the value's magnitude.
///
/// Parameters:
///
/// * `value` : A 64-bit signed integer to be converted. Will be stored as a
/// 32-bit integer if it fits within the 32-bit range, otherwise stored as a
/// 64-bit integer.
///
/// Returns an `Integer` variant that wraps the input value in either
/// `IntegerInt` or `IntegerInt64` constructor depending on the value's
/// magnitude.
///
/// Example:
///
/// ```moonbit
/// test "Integral::to_integer/int64" {
///   let small : Int64 = 42L
///   let large : Int64 = 9223372036854775807L
///   inspect!(Integral::to_integer(small), content="IntegerInt(42)")
///   inspect!(
///     Integral::to_integer(large),
///     content="IntegerInt64(9223372036854775807)",
///   )
/// }
/// ```
pub impl Integral for Int64 with to_integer(self) {
  if self >= @int.min_value.to_int64() && self <= @int.max_value.to_int64() {
    IntegerInt(self.to_int())
  } else {
    IntegerInt64(self)
  }
}

///|
/// Implements the `Integral` trait for arbitrary-precision integers by
/// converting them to the most efficient `Integer` representation. Automatically
/// selects between 32-bit integers, 64-bit integers, and arbitrary-precision
/// integers based on the value's magnitude. Special cases for zero and one are
/// optimized to use predefined constants.
///
/// Parameters:
///
/// * `value` : An arbitrary-precision integer to be converted. Will be stored
/// using the smallest possible integer representation that can hold the value.
///
/// Returns an `Integer` variant that wraps the input value in the most efficient
/// constructor:
///
/// * `integer_zero` for zero
/// * `integer_one` for one
/// * `IntegerInt` for values within 32-bit range (-2^31 to 2^31-1)
/// * `IntegerInt64` for values within 64-bit range (-2^63 to 2^63-1)
/// * `Integer` for larger values
///
/// Example:
///
/// ```moonbit
/// test "Integral::to_integer/bigint" {
///   let small = 42N
///   let medium = 2147483648N
///   let large = 9223372036854775808N
///   inspect!(Integral::to_integer(small), content="IntegerInt(42)")
///   inspect!(Integral::to_integer(medium), content="IntegerInt64(2147483648)")
///   inspect!(Integral::to_integer(large), content="Integer(9223372036854775808)")
/// }
/// ```
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
