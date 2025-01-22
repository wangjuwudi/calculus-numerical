///|
pub fn max[T : Compare](a : T, b : T) -> T {
  if a > b {
    a
  } else {
    b
  }
}

///|
pub fn min[T : Compare](a : T, b : T) -> T {
  if a < b {
    a
  } else {
    b
  }
}

///|
pub fn arr_sum_dbl(arr : Array[Double]) -> Double {
  let mut sum = 0.0
  for x in arr {
    sum = sum + x
  }
  sum
}

///|
pub fn sqrt(x : Double) -> Double {
  guard x >= 0.0 else { @double.not_a_number }
  guard x != @double.infinity else { @double.infinity }
  guard x != 0.0 && x != 1.0 else { x }
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
pub fn hypot(x : Double, y : Double) -> Double {
  sqrt(x * x + y * y)
}
