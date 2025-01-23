///|
/// Performs adaptive Gauss-Kronrod quadrature integration on a given function
/// over a specified interval. The algorithm adaptively subdivides the
/// integration interval to achieve the desired accuracy, using a Gauss-Kronrod
/// quadrature rule for each subinterval.
///
/// Parameters:
///
/// * `integrand` : The function to be integrated, taking a `Double` parameter
/// and returning a `Double`.
/// * `quadrature` : The Gauss-Kronrod quadrature rule to be used for
/// integration. This function takes the integrand and interval bounds as
/// parameters and returns a tuple containing the integral approximation,
/// absolute value, absolute central difference, and estimated error.
/// * `lower_bound` : The lower bound of the integration interval.
/// * `upper_bound` : The upper bound of the integration interval.
/// * `absolute_tolerance` : The absolute error tolerance for the integration.
/// * `relative_tolerance` : The relative error tolerance for the integration.
/// * `subdivision_limit` : The maximum number of subintervals allowed for the
/// adaptive integration.
///
/// Returns a `Result` containing either:
///
/// * `Ok((integral, error, status))`: where `integral` is the approximation of
/// the definite integral, `error` is the estimated absolute error, and `status`
/// is a string indicating the integration status ("OK", "E\_ROUND",
/// "E\_SINGULARITY", or "E\_MAX\_ITER").
/// * `Err(error_message)`: where `error_message` is either "E\_FAILED" or
/// "E\_BAD\_TOL" indicating integration failure or invalid tolerance parameters
/// respectively.
///
/// Example:
///
/// ```moonbit
/// test "adap_quad_gk" {
///   // Integrate x^2 from 0 to 1
///   let f = fn(x : Double) -> Double { x * x }
///   let (result, error, status) = adap_quad_gk(
///     f, kronrod_r15, 0.0, 1.0, 1.0e-8, 1.0e-8, 1000,
///   ).unwrap()
///   inspect!(@double.round(result * 1000.0) / 1000.0, content="0.333")
///   inspect!(status, content="OK")
/// }
/// ```
pub fn adap_quad_gk(
  f : @basic.Func_Math,
  q : @basic.Quad_GK,
  a : Double,
  b : Double,
  epsabs : Double,
  epsrel : Double,
  limit : Int
) -> Result[(Double, Double, String), String] {
  let mut iteration : Int = 0
  let mut result : Double = 0
  let mut abserr : Double = 0
  let mut err_code : String = ""
  let workspace = IntegrationWorkspace::new(limit)
  if epsabs <= 0 && (epsrel < @internal.machine_dbl_epsilon || epsrel < 0.5e-28) {
    err_code = "E_BAD_TOL"
  } else {
    let (result_0, resabs_0, resasc_0, abserr_0) = q(f, a, b)
    IntegrationWorkspace::init(workspace, a, b, result_0, abserr_0)
    let mut tolerance = @basic.max(epsabs, epsrel * result_0.abs())
    let round_off = 50.0 * @internal.machine_dbl_epsilon * resabs_0
    if abserr_0 <= round_off && abserr_0 > tolerance {
      result = result_0
      abserr = abserr_0
      err_code = "E_ROUND"
    } else if (abserr_0 <= tolerance && abserr_0 != resasc_0) || abserr_0 == 0.0 {
      result = result_0
      abserr = abserr_0
      err_code = "OK"
    } else if limit == 1 {
      result = result_0
      abserr = abserr_0
      err_code = "E_MAX_ITER"
    }
    let mut area = result_0
    let mut errsum = abserr_0
    iteration = 1
    let mut error_type = 0
    let mut roundoff_type_1 = 0
    let mut roundoff_type_2 = 0
    while iteration < limit && error_type == 0 && errsum > tolerance {
      let (a_i, b_i, r_i, e_i) = IntegrationWorkspace::retrieve(workspace)
      let a_1 = a_i
      let b_1 = 0.5 * (a_i + b_i)
      let a_2 = b_1
      let b_2 = b_i
      let (area_1, _, resasc_1, error_1) = q(f, a_1, b_1)
      let (area_2, _, resasc_2, error_2) = q(f, a_2, b_2)
      let area_12 = area_1 + area_2
      let error_12 = error_1 + error_2
      errsum = errsum + (error_12 - e_i)
      area = area + (area_12 - r_i)
      if resasc_1 != error_1 && resasc_2 != error_2 {
        let delta = r_i - area_2
        if delta.abs() <= 0.00001 * area_12.abs() && error_12 >= 0.99 * e_i {
          roundoff_type_1 = roundoff_type_1 + 1
        }
        if iteration >= 10 && error_12 > e_i {
          roundoff_type_2 = roundoff_type_2 + 1
        }
      }
      tolerance = @basic.max(epsabs, epsrel * area.abs())
      if errsum > tolerance {
        if roundoff_type_1 >= 6 || roundoff_type_2 >= 20 {
          error_type = 2
        }
        if IntegrationWorkspace::subinterval_check(a_1, a_2, b_2) {
          error_type = 3
        }
      }
      IntegrationWorkspace::update(
        workspace, a_1, b_1, area_1, error_1, a_2, b_2, area_2, error_2,
      )
      iteration = iteration + 1
    }
    result = @basic.arr_sum_dbl(workspace.r_list)
    abserr = errsum
    if errsum <= tolerance {
      err_code = "OK"
    } else if error_type == 2 {
      err_code = "E_ROUND"
    } else if error_type == 3 {
      err_code = "E_SINGULARITY"
    } else if iteration == limit {
      err_code = "E_MAX_ITER"
    } else {
      err_code = "E_FAILED"
    }
  }
  if err_code == "E_FAILED" || err_code == "E_BAD_TOL" {
    Err(err_code)
  } else {
    Ok((result, abserr, err_code))
  }
}
