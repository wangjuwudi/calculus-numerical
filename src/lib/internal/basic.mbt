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
