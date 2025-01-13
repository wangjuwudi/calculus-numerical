///|
pub struct IntegrationWorkspace {
  limit : Int
  mut size : Int
  mut i : Int
  mut maximum_level : Int
  a_list : Array[Double]
  b_list : Array[Double]
  r_list : Array[Double]
  e_list : Array[Double]
  order : Array[Int]
  level : Array[Int]
}

///|
pub fn alloc_workspace(limit : Int) -> IntegrationWorkspace {
  {
    limit,
    size: 0,
    i: 0,
    maximum_level: 0,
    a_list: [],
    b_list: [],
    r_list: [],
    e_list: [],
    order: [],
    level: [],
  }
}

///|
pub fn init_workspace(
  workspace : IntegrationWorkspace,
  a : Double,
  b : Double,
  result : Double,
  error : Double
) -> Unit {
  workspace.size = 1
  workspace.i = 0
  workspace.maximum_level = 0
  workspace.a_list.push(a)
  workspace.b_list.push(b)
  workspace.r_list.push(result)
  workspace.e_list.push(error)
  workspace.order.push(0)
  workspace.level.push(0)
}

///|
fn qpsrt(workspace : IntegrationWorkspace) -> Unit {
  let last = workspace.size - 1
  let i_maxerr = workspace.order[0]
  if last < 2 {
    workspace.order[0] = 0
    workspace.order[1] = 1
    workspace.i = workspace.order[0]
  }
  let errmax = workspace.e_list[i_maxerr]
  let mut top = 0
  if last < workspace.limit / 2 + 2 {
    top = last
  } else {
    top = workspace.limit - last + 1
  }
  let mut i = 1
  let mut k = top - 1
  while i < top && errmax < workspace.e_list[workspace.order[i]] {
    workspace.order[i - 1] = workspace.order[i]
    i = i + 1
  }
  workspace.order[i - 1] = i_maxerr
  let errmin = workspace.e_list[last]
  while k > i - 2 && errmin >= workspace.e_list[workspace.order[k]] {
    workspace.order[k + 1] = workspace.order[k]
    k = k - 1
  }
  workspace.order[k + 1] = last
  workspace.i = workspace.order[0]
}

///|
pub fn update_workspace(
  workspace : IntegrationWorkspace,
  a_1 : Double,
  b_1 : Double,
  area_1 : Double,
  error_1 : Double,
  a_2 : Double,
  b_2 : Double,
  area_2 : Double,
  error_2 : Double
) -> Unit {
  let i_max = workspace.i
  let new_level = workspace.level[i_max] + 1
  if error_2 > error_1 {
    workspace.a_list[i_max] = a_2
    workspace.r_list[i_max] = area_2
    workspace.e_list[i_max] = error_2
    workspace.level[i_max] = new_level
    workspace.a_list.push(a_1)
    workspace.b_list.push(b_1)
    workspace.r_list.push(area_1)
    workspace.e_list.push(error_1)
    workspace.level.push(new_level)
  } else {
    workspace.b_list[i_max] = b_1
    workspace.r_list[i_max] = area_1
    workspace.e_list[i_max] = error_1
    workspace.level[i_max] = new_level
    workspace.a_list.push(a_2)
    workspace.b_list.push(b_2)
    workspace.r_list.push(area_2)
    workspace.e_list.push(error_2)
    workspace.level.push(new_level)
  }
  workspace.size = workspace.size + 1
  if new_level > workspace.maximum_level {
    workspace.maximum_level = new_level
  }
  qpsrt(workspace)
}

///|
pub fn retrieve(
  workspace : IntegrationWorkspace
) -> (Double, Double, Double, Double) {
  (
    workspace.a_list[workspace.i],
    workspace.b_list[workspace.i],
    workspace.r_list[workspace.i],
    workspace.e_list[workspace.i],
  )
}

///|
pub fn subinterval_check(a_1 : Double, a_2 : Double, b_2 : Double) -> Bool {
  let tmp = (1.0 + 100.0 * @internal.machine_dbl_epsilon) *
    (@double.abs(a_2) + 1000.0 * @internal.machine_dbl_min)
  @double.abs(a_1) <= tmp && @double.abs(b_2) <= tmp
}
