///|
pub fn adap_quad_gk(
  f : @internal.Func_Math,
  q : @internal.Quad_GK,
  a : Double,
  b : Double,
  epsabs : Double,
  epsrel : Double,
  limit : Int
) -> Result[(Double, Double), String] {
  let mut iteration : Int = 0
  let mut result : Double = 0
  let mut abserr : Double = 0
  guard epsabs > 0 ||
    (epsrel >= 50.0 * @internal.machine_dbl_epsilon && epsrel >= 0.5e-28) else {
    Err("E_BAD_TOL")
  }
  let (result_0, abserr_0, resabs_0, resasc_0) = q(f, a, b)
  let mut tolerance = @internal.max(epsabs, epsrel * @double.abs(result_0))
  let round_off = 50.0 * @internal.machine_dbl_epsilon * resabs_0
  guard abserr_0 > round_off || abserr_0 <= tolerance else { Err("E_ROUND") }
  guard (abserr_0 <= tolerance && abserr_0 != resasc_0) ||
    abserr_0 == 0.0 ||
    limit != 1 else {
    Err("E_MAX_ITER")
  }
  let workspace = new(limit)
  init(workspace, a, b, result_0, abserr_0)
  let mut area = result_0
  let mut errsum = abserr_0
  iteration = 1
  let mut error_type = 0
  let mut roundoff_type_1 = 0
  let mut roundoff_type_2 = 0
  while iteration < limit && error_type == 0 && errsum > tolerance {
    let (a_i, b_i, r_i, e_i) = retrieve(workspace)
    let a_1 = a_i
    let b_1 = 0.5 * (a_i + b_i)
    let a_2 = b_1
    let b_2 = b_i
    let (area_1, error_1, _, resasc_1) = q(f, a_1, b_1)
    let (area_2, error_2, _, resasc_2) = q(f, a_2, b_2)
    let area_12 = area_1 + area_2
    let error_12 = error_1 + error_2
    errsum = errsum + (error_12 - e_i)
    area = area + (area_12 - r_i)
    if resasc_1 != error_1 && resasc_2 != error_2 {
      let delta = r_i - area_2
      if @double.abs(delta) <= 1.0e-5 * @double.abs(area_12) &&
        error_12 >= 0.99 * e_i {
        roundoff_type_1 = roundoff_type_1 + 1
      }
      if iteration >= 10 && error_12 > e_i {
        roundoff_type_2 = roundoff_type_2 + 1
      }
    }
    tolerance = @internal.max(epsabs, epsrel * @double.abs(area))
    if errsum > tolerance {
      if roundoff_type_1 >= 6 || roundoff_type_2 >= 20 {
        error_type = 2
      }
      if subinterval_check(a_1, a_2, b_2) {
        error_type = 3
      }
    }
    update(workspace, a_1, b_1, area_1, error_1, a_2, b_2, area_2, error_2)
    iteration = iteration + 1
  }
  result = @internal.arr_sum_dbl(workspace.r_list)
  abserr = errsum
  if errsum <= tolerance {
    Ok((result, abserr))
  } else if error_type == 2 {
    Err("E_ROUND")
  } else if error_type == 3 {
    Err("E_SINGULARITY")
  } else if iteration == limit {
    Err("E_MAX_ITER")
  } else {
    Err("E_FAILED")
  }
}
