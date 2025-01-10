///|
/// Computes the central derivative approximation of a function at a point with
/// error estimates using a 5-point rule for the derivative and a 3-point rule
/// for the error estimation.
///
/// Parameters:
///
/// * `f` : The function to differentiate. Takes a `Double` and returns a
/// `Double`.
/// * `x` : The point at which to compute the derivative.
/// * `h` : The step size used in the numerical approximation.
///
/// Returns a tuple containing:
///
/// * The derivative approximation using a 5-point rule
/// * The absolute difference between 5-point and 3-point approximations
/// * The estimated absolute error, including both truncation and round-off
/// errors
///
/// Example:
///
/// ```moonbit
/// test "central_deriv" {
///   let f = fn(x : Double) { x * x } // f(x) = x^2, f'(x) = 2x
///   let (deriv, diff, error) = central_deriv(f, 2.0, 0.1)
///   inspect!(@double.abs(deriv - 4.0) < error, content="true")
/// }
/// ```
fn central_deriv(
  f : @internal.Func_Math,
  x : Double,
  h : Double
) -> (Double, Double, Double) {
  let fn_eval : Array[Double] = [x - h, x - h / 2, x + h / 2, x + h]
  fn_eval.map_inplace(f)
  let r3 = 0.5 * (fn_eval[3] - fn_eval[0])
  let r5 = 4.0 / 3.0 * (fn_eval[2] - fn_eval[1]) - 1.0 / 3.0 * r3
  let e3 = (@double.abs(fn_eval[3]) + @double.abs(fn_eval[0])) *
    @internal.machine_dbl_epsilon
  let e5 = 2.0 *
    (@double.abs(fn_eval[2]) + @double.abs(fn_eval[1])) *
    @internal.machine_dbl_epsilon +
    e3
  let a = @double.abs(r3 / h)
  let b = @double.abs(r5 / h) *
    (@double.abs(x) / h) *
    @internal.machine_dbl_epsilon
  let mut dy = a
  if a < b {
    dy = b
  }
  (r5 / h, @double.abs((r5 - r3) / h), @double.abs(e5 / h) + dy)
}

///|
/// Computes the central derivative approximation of a function at a point with
/// adaptive step size refinement. Uses a combination of 5-point and 3-point
/// rules to estimate both the derivative and its error, with automatic step size
/// optimization when possible.
///
/// Parameters:
///
/// * `function` : The function to differentiate. Takes a `Double` and returns a
/// `Double`.
/// * `point` : The point at which to compute the derivative.
/// * `step` : The initial step size for the numerical approximation. Will be
/// automatically refined if possible.
///
/// Returns a tuple containing:
///
/// * The best available derivative approximation
/// * The estimated absolute error of the computation
///
/// Example:
///
/// ```moonbit
/// test "deriv_central" {
///   let f = fn(x : Double) { x * x } // f(x) = x^2, f'(x) = 2x
///   let (deriv, error) = deriv_central(f, 2.0, 0.1)
///   inspect!(@double.abs(deriv - 4.0) < error, content="true")
/// }
/// ```
pub fn deriv_central(
  f : @internal.Func_Math,
  x : Double,
  h : Double
) -> (Double, Double) {
  let (r0, round, trunc) = central_deriv(f, x, h)
  let error = round + trunc
  //round < trunc && (round > 0 && trunc > 0) will quicker? need to test.
  if round < trunc && round > 0 && trunc > 0 {
    let h_opt = h * @double.pow(round / (2.0 * trunc), 1.0 / 3.0)
    let (r_opt, round_opt, trunc_opt) = central_deriv(f, x, h_opt)
    let error_opt = round_opt + trunc_opt
    if error_opt < error && @double.abs(r_opt - r0) < 4.0 * error {
      (r_opt, error_opt)
    } else {
      (r0, error)
    }
  } else {
    (r0, error)
  }
}

///|
/// Computes the forward derivative approximation of a function at a point with
/// error estimates using a 4-point rule for the derivative and a 2-point rule
/// for the error estimation.
///
/// Uses an optimized combination of sampling points at h/4, h/2, 3h/4, and h
/// distances from the evaluation point to achieve higher accuracy compared to
/// simple forward difference methods.
///
/// Parameters:
///
/// * `function` : The function to differentiate. Takes a `Double` and returns a
/// `Double`.
/// * `point` : The point at which to compute the derivative.
/// * `step` : The step size used in the numerical approximation.
///
/// Returns a tuple containing:
///
/// * The derivative approximation using a 4-point rule
/// * The absolute difference between 4-point and 2-point approximations
/// * The estimated absolute error, including both truncation and round-off
/// errors
///
/// Example:
///
/// ```moonbit
/// test "forward_deriv" {
///   let f = fn(x : Double) { x * x } // f(x) = x^2, f'(x) = 2x
///   let (deriv, diff, error) = forward_deriv(f, 2.0, 0.1)
///   inspect!(@double.abs(deriv - 4.0) < error, content="true")
/// }
/// ```
fn forward_deriv(
  f : @internal.Func_Math,
  x : Double,
  h : Double
) -> (Double, Double, Double) {
  let fn_eval = [x + h / 4.0, x + h / 2.0, x + 3.0 / 4.0 * h, x + h]
  fn_eval.map_inplace(f)
  let r2 = 2.0 * (fn_eval[3] - fn_eval[1])
  let r4 = 22.0 / 3.0 * (fn_eval[3] - fn_eval[2]) -
    62.0 / 3.0 * (fn_eval[2] - fn_eval[1]) +
    52.0 / 3.0 * (fn_eval[1] - fn_eval[0])
  let e4 = 2.0 *
    (20.0 + 2.0 / 3.0) *
    (
      @double.abs(fn_eval[3]) +
      @double.abs(fn_eval[2]) +
      @double.abs(fn_eval[1]) +
      @double.abs(fn_eval[0])
    ) *
    @internal.machine_dbl_epsilon
  let a = @double.abs(r2 / h)
  let b = @double.abs(r4 / h) *
    @double.abs(x / h) *
    @internal.machine_dbl_epsilon
  let mut dy = a
  if a < b {
    dy = b
  }
  (r4 / h, @double.abs((r4 - r2) / h), @double.abs(e4 / h) + dy)
}

///|
/// Computes the forward derivative approximation of a function at a point with
/// adaptive step size refinement. Uses a combination of 4-point and 2-point
/// rules to estimate both the derivative and its error, with automatic step size
/// optimization when possible.
///
/// Parameters:
///
/// * `function` : A function that takes a `Double` and returns a `Double`. The
/// function to be differentiated.
/// * `point` : The point at which to compute the derivative.
/// * `step` : The initial step size for the numerical approximation. Will be
/// automatically refined if possible.
///
/// Returns a tuple containing:
///
/// * The best available derivative approximation
/// * The estimated absolute error of the computation
///
/// Example:
///
/// ```moonbit
/// test "deriv_forward" {
///   let f = fn(x : Double) { x * x } // f(x) = x^2, f'(x) = 2x
///   let (deriv, error) = deriv_forward(f, 2.0, 0.1)
///   inspect!(@double.abs(deriv - 4.0) < error, content="true")
/// }
/// ```
pub fn deriv_forward(
  f : @internal.Func_Math,
  x : Double,
  h : Double
) -> (Double, Double) {
  let (r0, round, trunc) = forward_deriv(f, x, h)
  let error = round + trunc
  if round < trunc && round > 0 && trunc > 0 {
    let h_opt = h * @double.pow(round / trunc, 1.0 / 2.0)
    let (r_opt, round_opt, trunc_opt) = central_deriv(f, x, h_opt)
    let error_opt = round_opt + trunc_opt
    if error_opt < error && @double.abs(r_opt - r0) < 4.0 * error {
      (r_opt, error_opt)
    } else {
      (r0, error)
    }
  } else {
    (r0, error)
  }
}

///|
/// Computes the backward derivative approximation of a function at a point with
/// adaptive step size refinement. Uses the forward derivative implementation
/// with a negated step size to compute the backward derivative.
///
/// Parameters:
///
/// * `function` : A function that takes a `Double` and returns a `Double`. The
/// function to be differentiated.
/// * `point` : The point at which to compute the derivative.
/// * `step` : The initial step size for the numerical approximation. Will be
/// automatically refined if possible.
///
/// Returns a tuple containing:
///
/// * The best available derivative approximation
/// * The estimated absolute error of the computation
///
/// Example:
///
/// ```moonbit
/// test "deriv_backward" {
///   let f = fn(x : Double) { x * x } // f(x) = x^2, f'(x) = 2x
///   let (deriv, error) = deriv_backward(f, 2.0, 0.1)
///   inspect!(@double.abs(deriv - 4.0) < error, content="true")
/// }
/// ```
pub fn deriv_backward(
  f : @internal.Func_Math,
  x : Double,
  h : Double
) -> (Double, Double) {
  deriv_forward(f, x, -h)
}
