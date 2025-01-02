///|
/// Performs adaptive Gauss-Kronrod quadrature integration on a given function
/// over a specified interval.
///
/// Parameters:
///
/// * `order` : The order of the Gauss-Kronrod quadrature rule. This determines
/// the number of evaluation points used.
/// * `abscissas` : Array of Gauss-Kronrod nodes (evaluation points).
/// * `gauss_weights` : Array of weights for the Gauss quadrature rule.
/// * `kronrod_weights` : Array of weights for the Kronrod quadrature rule.
/// * `integrand` : The function to be integrated. Takes a single Double
/// parameter and returns a Double.
/// * `lower_bound` : The lower bound of the integration interval.
/// * `upper_bound` : The upper bound of the integration interval.
///
/// Returns a tuple containing:
///
/// * The approximation of the integral using Kronrod quadrature
/// * The absolute value of the integral approximation
/// * The absolute central difference approximation
/// * The estimated error of the integration
///
/// Example:
///
/// ```
/// test "gauss_kronrod" {
///   // Integrate x^2 from 0 to 1
///   let f = fn(x : Double) -> Double { x * x }
///   let xgk = [0.0, 0.5773502691896257, 1.0]
///   let wg = [0.8888888888888888, 0.5555555555555556]
///   let wgk = [0.6521451548625461, 0.3478548451374538, 0.2469135802469136]
///   let (result, _, _, error) = gauss_kronrod(3, xgk, wg, wgk, f, 0.0, 1.0)
///   inspect!(@double.round(result * 1000.0) / 1000.0, content="0.333")
/// }
/// ```
fn gauss_kronrod(
  n : Int,
  xgk : Array[Double],
  wg : Array[Double],
  wgk : Array[Double],
  f : (Double) -> Double,
  a : Double,
  b : Double
) -> (Double, Double, Double, Double) {
  let center = 0.5 * (a + b)
  let half_length = 0.5 * (b - a)
  let abs_half_length = @double.abs(half_length)
  let f_center = f(center)
  let mut result_gauss : Double = 0
  let mut result_kronrod = f_center * wgk[n - 1]
  let mut result_abs = @double.abs(result_kronrod)
  let mut result_asc : Double = 0
  let fv1 : Array[Double] = []
  let fv2 : Array[Double] = []
  let mut is_odd : Bool = false
  if n % 2 == 0 {
    result_gauss = f_center * wg[n / 2 - 1]
  }
  for i = 0; i < n + 1; i = i + 1 {
    let abscissa = half_length * xgk[i]
    let f_eval = [center - abscissa, center + abscissa]
    f_eval.map_inplace(f)
    fv1.push(f_eval[0])
    fv2.push(f_eval[1])
    if is_odd {
      let f_sum = f_eval[0] + f_eval[1]
      result_gauss = result_gauss + wg[(i - 1) / 2] * f_sum
      result_kronrod = result_kronrod + wgk[i] * f_sum
      result_abs = result_abs +
        wgk[i] * (@double.abs(f_eval[0]) + @double.abs(f_eval[1]))
    } else {
      result_kronrod = result_kronrod + wgk[i] * (f_eval[0] + f_eval[1])
      result_abs = result_abs +
        wgk[i] * (@double.abs(f_eval[0]) + @double.abs(f_eval[1]))
    }
    is_odd = not(is_odd)
  }
  let mean = result_kronrod * 0.5
  result_asc = wgk[n - 1] * @double.abs(f_center - mean)
  for j = 0; j < n - 1; j = j + 1 {
    result_asc = result_asc +
      wgk[j] * (@double.abs(fv1[j] - mean) + @double.abs(fv2[j] - mean))
  }
  let err = (result_kronrod - result_gauss) * half_length
  result_kronrod = result_kronrod * half_length
  result_abs = result_abs * abs_half_length
  result_asc = result_asc * abs_half_length
  (
    result_kronrod,
    result_abs,
    result_asc,
    @internal.rescale_error(err, result_abs, result_asc),
  )
}

///|
pub fn kronrod_r15(
  f : (Double) -> Double,
  a : Double,
  b : Double
) -> (Double, Double, Double, Double) {
  gauss_kronrod(8, xgk_r15, wg_r15, wgk_r15, f, a, b)
}

///|
pub fn kronrod_r21(
  f : (Double) -> Double,
  a : Double,
  b : Double
) -> (Double, Double, Double, Double) {
  gauss_kronrod(11, xgk_r21, wg_r21, wgk_r21, f, a, b)
}

///|
pub fn kronrod_r31(
  f : (Double) -> Double,
  a : Double,
  b : Double
) -> (Double, Double, Double, Double) {
  gauss_kronrod(16, xgk_r31, wg_r31, wgk_r31, f, a, b)
}

///|
pub fn kronrod_r41(
  f : (Double) -> Double,
  a : Double,
  b : Double
) -> (Double, Double, Double, Double) {
  gauss_kronrod(21, xgk_r41, wg_r41, wgk_r41, f, a, b)
}

///|
pub fn kronrod_r51(
  f : (Double) -> Double,
  a : Double,
  b : Double
) -> (Double, Double, Double, Double) {
  gauss_kronrod(26, xgk_r51, wg_r51, wgk_r51, f, a, b)
}

///|
pub fn kronrod_r61(
  f : (Double) -> Double,
  a : Double,
  b : Double
) -> (Double, Double, Double, Double) {
  gauss_kronrod(31, xgk_r61, wg_r61, wgk_r61, f, a, b)
}
