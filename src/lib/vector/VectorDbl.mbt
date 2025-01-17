///|
pub(all) struct VectorDbl {
  data : Array[Double]
  size : Int
  mut stride : Int
}

///|
pub fn VectorDbl::new(size : Int, stride~ : Int = 1) -> VectorDbl {
  let data = []
  { data, size, stride }
}

///|
pub fn VectorDbl::at(self : VectorDbl, index : Int) -> Double {
  guard index < self.size && index >= 0
  self.data[index * self.stride]
}

///|
pub fn VectorDbl::filled_vector(size : Int, num : Double) -> VectorDbl {
  let data = (fn() -> Array[Double] {
    let filled_vector = []
    for i = 0; i < size; i = i + 1 {
      filled_vector.push(num)
    }
    filled_vector
  })()
  { data, size, stride: 1 }
}

///|
pub fn VectorDbl::zero_vector(size : Int) -> VectorDbl {
  VectorDbl::filled_vector(size, 0.0)
}

///|
pub fn VectorDbl::map(self : VectorDbl, f : (Double) -> Double) -> VectorDbl {
  let data = self.data.map(f)
  { data, size: self.size, stride: self.stride }
}

///|
pub fn VectorDbl::map_inplace(self : VectorDbl, f : (Double) -> Double) -> Unit {
  self.data.map_inplace(f)
}

///|
pub fn VectorDbl::scale(self : VectorDbl, scalar : Double) -> VectorDbl {
  self.map(fn(x) -> Double { x * scalar })
}

///|
pub fn VectorDbl::scale_inplace(self : VectorDbl, scalar : Double) -> Unit {
  self.map_inplace(fn(x) -> Double { x * scalar })
}

///|
pub fn VectorDbl::add_constant(
  self : VectorDbl,
  constant : Double
) -> VectorDbl {
  self.map(fn(x) -> Double { x + constant })
}

///|
pub fn VectorDbl::add_constant_inplace(
  self : VectorDbl,
  constant : Double
) -> Unit {
  self.map_inplace(fn(x) -> Double { x + constant })
}

///|
pub fn VectorDbl::ax_plus_by(
  self : VectorDbl,
  x : VectorDbl,
  a : Double,
  b : Double
) -> VectorDbl {
  let n = self.size
  guard n == x.size
  let stride_self = self.stride
  let stride_x = x.stride
  let vector_ax_plus_by = VectorDbl::new(n)
  for i = 0; i < n; i = i + 1 {
    vector_ax_plus_by.data.push(
      a * self.data[i * stride_self] + b * x.data[i * stride_x],
    )
  }
  vector_ax_plus_by
}

///|
pub fn VectorDbl::ax_plus_by_inplace(
  self : VectorDbl,
  x : VectorDbl,
  a : Double,
  b : Double
) -> Unit {
  let n = self.size
  guard n == x.size
  let stride_self = self.stride
  let stride_x = x.stride
  for i = 0; i < n; i = i + 1 {
    self.data[i * stride_self] = a * self.data[i * stride_self] +
      b * x.data[i * stride_x]
  }
}

///|
pub fn VectorDbl::sum(self : VectorDbl) -> Double {
  @internal.arr_sum_dbl(self.data)
}

///|
pub fn VectorDbl::add_inplace(self : VectorDbl, other : VectorDbl) -> Unit {
  let n = self.size
  guard n == other.size
  let stride_self = self.stride
  let stride_other = other.stride
  for i = 0; i < n; i = i + 1 {
    self.data[i * stride_self] = self.data[i * stride_self] +
      other.data[i * stride_other]
  }
}

///|
pub fn VectorDbl::sub_inplace(self : VectorDbl, other : VectorDbl) -> Unit {
  let n = self.size
  guard n == other.size
  let stride_self = self.stride
  let stride_other = other.stride
  for i = 0; i < n; i = i + 1 {
    self.data[i * stride_self] = self.data[i * stride_self] -
      other.data[i * stride_other]
  }
}

///|
pub fn VectorDbl::mul_inplace(self : VectorDbl, other : VectorDbl) -> Unit {
  let n = self.size
  guard n == other.size
  let stride_self = self.stride
  let stride_other = other.stride
  for i = 0; i < n; i = i + 1 {
    self.data[i * stride_self] = self.data[i * stride_self] *
      other.data[i * stride_other]
  }
}

///|
pub fn VectorDbl::div_inplace(self : VectorDbl, other : VectorDbl) -> Unit {
  let n = self.size
  guard n == other.size
  let stride_self = self.stride
  let stride_other = other.stride
  for i = 0; i < n; i = i + 1 {
    self.data[i * stride_self] = self.data[i * stride_self] /
      other.data[i * stride_other]
  }
}

///|
pub fn op_add(self : VectorDbl, other : VectorDbl) -> VectorDbl {
  let n = self.size
  guard n == other.size
  let stride_self = self.stride
  let stride_other = other.stride
  let vector_add = VectorDbl::new(n)
  for i = 0; i < n; i = i + 1 {
    vector_add.data.push(
      self.data[i * stride_self] + other.data[i * stride_other],
    )
  }
  vector_add
}

///|
pub fn op_sub(self : VectorDbl, other : VectorDbl) -> VectorDbl {
  let n = self.size
  guard n == other.size
  let stride_self = self.stride
  let stride_other = other.stride
  let vector_sub = VectorDbl::new(n)
  for i = 0; i < n; i = i + 1 {
    vector_sub.data.push(
      self.data[i * stride_self] - other.data[i * stride_other],
    )
  }
  vector_sub
}

///|
pub fn op_mul(self : VectorDbl, other : VectorDbl) -> VectorDbl {
  let n = self.size
  guard n == other.size
  let stride_self = self.stride
  let stride_other = other.stride
  let vector_mul = VectorDbl::new(n)
  for i = 0; i < n; i = i + 1 {
    vector_mul.data.push(
      self.data[i * stride_self] * other.data[i * stride_other],
    )
  }
  vector_mul
}

///|
pub fn op_div(self : VectorDbl, other : VectorDbl) -> VectorDbl {
  let n = self.size
  guard n == other.size
  let stride_self = self.stride
  let stride_other = other.stride
  let vector_div = VectorDbl::new(n)
  for i = 0; i < n; i = i + 1 {
    vector_div.data.push(
      self.data[i * stride_self] / other.data[i * stride_other],
    )
  }
  vector_div
}
