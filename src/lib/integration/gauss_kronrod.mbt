///|
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
