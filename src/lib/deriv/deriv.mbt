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
///   inspect!((deriv - 4.0).abs() < error, content="true")
/// }
/// ```
fn central_deriv(
  f : @internal.Func_Math,
  x : Double,
  h : Double
) -> (Double, Double, Double) {
  let fm1 = f(x - h)
  let fp1 = f(x + h)
  let fmh = f(x - 0.5 * h)
  let fph = f(x + 0.5 * h)
  let r3 = 0.5 * (fp1 - fm1)
  let r5 = 4.0 / 3.0 * (fph - fmh) - 1.0 / 3.0 * r3
  let e3 = (fp1.abs() + fm1.abs()) * @internal.machine_dbl_epsilon
  let e5 = 2.0 * (fph.abs() + fmh.abs()) * @internal.machine_dbl_epsilon + e3
  let dy = @internal.max((r3 / h).abs(), (r5 / h).abs()) *
    (x.abs() / h) *
    @internal.machine_dbl_epsilon
  (r5 / h, ((r5 - r3) / h).abs(), (e5 / h).abs() + dy)
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
///   inspect!((deriv - 4.0).abs() < error, content="true")
/// }
/// ```
pub fn deriv_central(
  f : @internal.Func_Math,
  x : Double,
  h : Double
) -> (Double, Double) {
  let (r_0, round, trunc) = central_deriv(f, x, h)
  let mut error = round + trunc
  let mut r = r_0
  if round < trunc && round > 0 && trunc > 0 {
    let h_opt = h * (round / (2.0 * trunc)).pow(1.0 / 3.0)
    let (r_opt, round_opt, trunc_opt) = central_deriv(f, x, h_opt)
    let error_opt = round_opt + trunc_opt
    if error_opt < error && (r_opt - r_0).abs() < 4.0 * error {
      r = r_opt
      error = error_opt
    }
  }
  (r, error)
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
///   inspect!((deriv - 4.0).abs() < error, content="true")
/// }
/// ```
fn forward_deriv(
  f : @internal.Func_Math,
  x : Double,
  h : Double
) -> (Double, Double, Double) {
  let fn_eval = [x + h * 0.25, x + h * 0.5, x + h * 0.75, x + h]
  fn_eval.map_inplace(f)
  let r2 = 2.0 * (fn_eval[3] - fn_eval[1])
  let r4 = 22.0 / 3.0 * (fn_eval[3] - fn_eval[2]) -
    62.0 / 3.0 * (fn_eval[2] - fn_eval[1]) +
    52.0 / 3.0 * (fn_eval[1] - fn_eval[0])
  let abs_eval = fn_eval.map(@double.abs)
  let e4 = 2.0 *
    20.67 *
    @internal.arr_sum_dbl(abs_eval) *
    @internal.machine_dbl_epsilon
  let dy = @internal.max((r2 / h).abs(), (r4 / h).abs()) *
    (x / h).abs() *
    @internal.machine_dbl_epsilon
  (r4 / h, ((r4 - r2) / h).abs(), (e4 / h).abs() + dy)
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
///   inspect!((deriv - 4.0).abs() < error, content="true")
/// }
/// ```
pub fn deriv_forward(
  f : @internal.Func_Math,
  x : Double,
  h : Double
) -> (Double, Double) {
  let (r_0, round, trunc) = forward_deriv(f, x, h)
  let mut r = r_0
  let mut error = round + trunc
  if round < trunc && round > 0 && trunc > 0 {
    let h_opt = h * @internal.sqrt(round / trunc)
    let (r_opt, round_opt, trunc_opt) = forward_deriv(f, x, h_opt)
    let error_opt = round_opt + trunc_opt
    if error_opt < error && (r_opt - r_0).abs() < 4.0 * error {
      r = r_opt
      error = error_opt
    }
  }
  (r, error)
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
///   inspect!((deriv - 4.0).abs() < error, content="true")
/// }
/// ```
pub fn deriv_backward(
  f : @internal.Func_Math,
  x : Double,
  h : Double
) -> (Double, Double) {
  deriv_forward(f, x, -h)
}
