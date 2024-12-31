///|
/// Computes the numerical derivative of a function at a given point using
/// backward difference method with adaptive step size.
///
/// Reference:
/// GNU Scientific Library @diff/diff.c
///
/// Parameters:
///
/// * `function` : A function that takes a `Double` and returns a `Double`. The
/// function to be differentiated.
/// * `point` : The point at which to compute the derivative.
///
/// Returns a tuple containing:
///
/// * The estimated derivative value using backward difference approximation
/// * The estimated absolute error of the computation
///
/// Example:
///
/// ```
/// test "diff_backward" {
///   let f = fn(x : Double) { x * x } // f(x) = x^2, f'(x) = 2x
///   let (derivative, error) = diff_backward(f, 2.0)
///   inspect!(@double.abs(derivative - 4.0) < error, content="true")
/// }
/// ```
pub fn diff_backward(f : (Double) -> Double, x : Double) -> (Double, Double) {
  let a : Array[Double] = [-2, -1, 0]
  a.map_inplace(fn(n) { n * @internal.machine_dbl_epsilon + x })
  let d = a.map(f)
  for k = 1; k < 4; k = k + 1 {
    for i = 0; i < 3 - k; i = i + 1 {
      d[i] = (d[i + 1] - d[i]) / (a[i + k] - a[i])
    }
  }
  let mut a2 = @double.abs(d[0] + d[1] + d[2])
  let c = 100.0 * @internal.machine_sqrt_dbl_epsilon
  if a2 < c {
    a2 = c
  }
  let mut h = (@internal.machine_sqrt_dbl_epsilon / (2.0 * a2)).sqrt()
  if h > c {
    h = c
  }
  ((f(x) - f(x - h)) / h, @double.abs(10.0 * a2 * h))
}

///|
/// Computes the numerical derivative of a function at a given point using
/// forward difference method with adaptive step size.
/// 
/// Reference:
/// GNU Scientific Library @diff/diff.c
/// 
/// Parameters:
///
/// * `function` : A function that takes a `Double` and returns a `Double`. The
/// function to be differentiated.
/// * `point` : The point at which to compute the derivative.
///
/// Returns a tuple containing:
///
/// * The estimated derivative value
/// * The estimated absolute error of the computation
///
/// Example:
///
/// ```
/// test "diff_forward" {
///   let f = fn(x : Double) { x * x } // f(x) = x^2, f'(x) = 2x
///   let (derivative, error) = diff_forward(f, 2.0)
///   inspect!(@double.abs(derivative - 4.0) < error, content="true")
/// }
/// ```
pub fn diff_forward(f : (Double) -> Double, x : Double) -> (Double, Double) {
  let a : Array[Double] = [0, 1, 2]
  a.map_inplace(fn(n) { n * @internal.machine_dbl_epsilon + x })
  let d = a.map(fn(n) { f(n) })
  for k = 1; k < 4; k = k + 1 {
    for i = 0; i < 3 - k; i = i + 1 {
      d[i] = (d[i + 1] - d[i]) / (a[i + k] - a[i])
    }
  }
  let mut a2 = @double.abs(d[0] + d[1] + d[2])
  let c = 100.0 * @internal.machine_sqrt_dbl_epsilon
  if a2 < c {
    a2 = c
  }
  let mut h = (@internal.machine_sqrt_dbl_epsilon / (2.0 * a2)).sqrt()
  if h > c {
    h = c
  }
  ((f(x + h) - f(x)) / h, @double.abs(10.0 * a2 * h))
}

///|
/// Computes the numerical derivative of a function at a given point using
/// central difference method with adaptive step size.
///
/// This method provides a more accurate approximation compared to forward or
/// backward difference methods by using points on both sides of the evaluation
/// point. The step size is automatically adjusted based on the function's
/// behavior to balance between truncation and round-off errors.
///
/// Reference:
/// GNU Scientific Library @diff/diff.c
///
/// Parameters:
///
/// * `function` : A function that takes a `Double` and returns a `Double`. The
/// function to be differentiated.
/// * `point` : The point at which to compute the derivative.
///
/// Returns a tuple containing:
///
/// * The estimated derivative value using central difference approximation
/// * The estimated absolute error of the computation
///
/// Example:
///
/// ```
/// test "diff_central" {
///   let f = fn(x : Double) { x * x } // f(x) = x^2, f'(x) = 2x
///   let (derivative, error) = diff_central(f, 2.0)
///   inspect!(@double.abs(derivative - 4.0) < error, content="true")
/// }
/// ```
pub fn diff_central(f : (Double) -> Double, x : Double) -> (Double, Double) {
  let a : Array[Double] = [-2, -1, 0, 1]
  a.map_inplace(fn(n) { n * @internal.machine_dbl_epsilon + x })
  let d = a.map(fn(n) { f(n) })
  for k = 1; k < 5; k = k + 1 {
    for i = 0; i < 4 - k; i = i + 1 {
      d[i] = (d[i + 1] - d[i]) / (a[i + k] - a[i])
    }
  }
  let mut a3 = @double.abs(d[0] + d[1] + d[2] + d[3])
  let c = 100.0 * @internal.machine_sqrt_dbl_epsilon
  if a3 < c {
    a3 = c
  }
  let mut h = @double.pow(@internal.machine_sqrt_dbl_epsilon / (2.0 * a3), 1.0 / 3.0)
  if h > c {
    h = c
  }
  ((f(x + h) - f(x - h)) / (2.0 * h), @double.abs(100.0 * a3 * h * h))
}
