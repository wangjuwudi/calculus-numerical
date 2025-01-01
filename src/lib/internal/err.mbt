pub fn rescale_error(
  err:Double,
  result_abs: Double,
  result_asc: Double
) -> Double{
  let mut err_ = @double.abs(err)
  if result_asc != 0 && err_ != 0 {
    let scale = @double.pow((200.0 * err_ /result_asc), 1.5)
    if scale < 1{
      err_ = result_asc * scale
    }
    else {
      err_ = result_asc
    }
  }
  
  if result_abs > machine_dbl_min / (50.0 * machine_dbl_epsilon){
    let min_err = 50.0 * machine_dbl_epsilon * result_abs
    
    if min_err > err_{
      err_ = min_err
    }
  }
  err_
}