///|
/// Returns the larger of two values of the same type that implements the
/// `Compare` trait.
///
/// Parameters:
///
/// * `first` : The first value to compare.
/// * `second` : The second value to compare.
///
/// Returns the larger value between `first` and `second`.
///
/// Example:
///
/// ```moonbit
/// test "max" {
///   inspect!(max(3, 5), content="5")
///   inspect!(max("abc", "def"), content="def")
/// }
/// ```
pub fn max[T : Compare](a : T, b : T) -> T {
  if a > b {
    a
  } else {
    b
  }
}

///|
/// Returns the smaller of two values of the same type that implements the
/// `Compare` trait.
///
/// Parameters:
///
/// * `first` : The first value to compare.
/// * `second` : The second value to compare.
///
/// Returns the smaller value between `first` and `second`.
///
/// Example:
///
/// ```moonbit
/// test "min" {
///   inspect!(min(3, 5), content="3")
///   inspect!(min("abc", "def"), content="abc")
/// }
/// ```
pub fn min[T : Compare](a : T, b : T) -> T {
  if a < b {
    a
  } else {
    b
  }
}

///|
/// Computes the sum of all elements in an array of double-precision
/// floating-point numbers.
///
/// Parameters:
///
/// * `array` : An array of `Double` values to be summed up.
///
/// Returns the sum of all elements in the array. Returns 0.0 for an empty array.
///
/// Example:
///
/// ```moonbit
/// test "arr_sum_dbl" {
///   let arr = [1.5, 2.5, 3.0]
///   inspect!(arr_sum_dbl(arr), content="7.0")
/// }
/// ```
pub fn arr_sum_dbl(arr : Array[Double]) -> Double {
  let mut sum = 0.0
  for x in arr {
    sum = sum + x
  }
  sum
}

///|
/// Computes the square root of a non-negative real number using Newton's method.
/// Returns NaN for negative inputs and infinity for infinite inputs.
///
/// Parameters:
///
/// * `x` : A non-negative real number whose square root is to be calculated.
///
/// Returns the square root of the input number. For special cases:
///
/// * Returns NaN if input is negative
/// * Returns infinity if input is infinity
/// * Returns the input if input is 0 or 1
///
/// Example:
///
/// ```moonbit
/// test "sqrt" {
///   inspect!(sqrt(16.0), content="4.0")
///   inspect!(sqrt(0.0), content="0.0")
///   inspect!(sqrt(-1.0), content="nan")
/// }
/// ```
pub fn sqrt(x : Double) -> Double {
  guard x >= 0.0 else { @double.not_a_number }
  guard x != @double.infinity else { @double.infinity }
  guard x != 0.0 || x != 1.0 else { x }
  let mut guess = x / 2.0
  let mut diff = 1.0
  let epsilon = 0.0000001
  while diff > epsilon {
    let new_guess = (guess + x / guess) / 2.0
    diff = (guess - new_guess).abs()
    guess = new_guess
  }
  guess
}

///|
/// Calculates the hypotenuse length of a right triangle using the Pythagorean
/// theorem. Given two sides of a right triangle, computes sqrt(x² + y²) which
/// represents the length of the hypotenuse.
///
/// Parameters:
///
/// * `x` : The length of one side of the right triangle.
/// * `y` : The length of the other side of the right triangle.
///
/// Returns the length of the hypotenuse. Returns `NaN` if either input is `NaN`
/// or if the computation results in an overflow.
///
/// Example:
///
/// ```moonbit
/// test "hypot" {
///   inspect!(hypot(3.0, 4.0), content="5.0")
///   inspect!(hypot(5.0, 12.0), content="13.0")
/// }
/// ```
pub fn hypot(x : Double, y : Double) -> Double {
  sqrt(x * x + y * y)
}
