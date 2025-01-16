///|
pub(all) struct MatrixDbl {
  data : Array[Double]
  col : Int
  row : Int
  mut stride : Int
}

///|
pub fn MatrixDbl::new(row : Int, col : Int) -> MatrixDbl {
  guard row > 0 && col > 0
  let stride = col
  let data : Array[Double] = []
  { data, col, row, stride }
}

///|
pub fn MatrixDbl::at(self : MatrixDbl, row : Int, col : Int) -> Double {
  guard row < self.row && col < self.col
  let index = row * self.stride + col
  guard index < self.data.length()
  self.data[index]
}

///|
pub fn MatrixDbl::filled_matrix(
  row : Int,
  col : Int,
  num : Double
) -> MatrixDbl {
  let stride = col
  let data : Array[Double] = (fn() -> Array[Double] {
    let filled_matrix = []
    for i = 0; i < row * col; i = i + 1 {
      filled_matrix.push(num)
    }
    filled_matrix
  })()
  { data, col, row, stride }
}

///|
pub fn MatrixDbl::zero_matrix(row : Int, col : Int) -> MatrixDbl {
  MatrixDbl::filled_matrix(row, col, 0.0)
}

///|
pub fn MatrixDbl::map(self : MatrixDbl, f : (Double) -> Double) -> MatrixDbl {
  let stride = self.stride
  let data = self.data.map(f)
  { data, col: self.col, row: self.row, stride }
}

///|
pub fn MatrixDbl::map_inplace(self : MatrixDbl, f : (Double) -> Double) -> Unit {
  self.data.map_inplace(f)
}

///|
pub fn MatrixDbl::scale(self : MatrixDbl, scalar : Double) -> MatrixDbl {
  self.map(fn(x) -> Double { x * scalar })
}

///|
pub fn MatrixDbl::scale_inplace(self : MatrixDbl, scalar : Double) -> Unit {
  self.map_inplace(fn(x) -> Double { x * scalar })
}

///|
pub fn MatrixDbl::add_constant(
  self : MatrixDbl,
  constant : Double
) -> MatrixDbl {
  self.map(fn(x) -> Double { x + constant })
}

///|
pub fn MatrixDbl::add_constant_inplace(
  self : MatrixDbl,
  constant : Double
) -> Unit {
  self.map_inplace(fn(x) -> Double { x + constant })
}

///|
pub fn MatrixDbl::add_diagonal(
  self : MatrixDbl,
  constant : Double
) -> MatrixDbl {
  guard self.row == self.col
  let stride = self.stride
  let data = self.data.copy()
  for i = 0; i < self.row; i = i + 1 {
    data[i * stride + i] = data[i * stride + i] + constant
  }
  { data, col: self.col, row: self.row, stride }
}

///|
pub fn MatrixDbl::add_diagonal_inplace(
  self : MatrixDbl,
  constant : Double
) -> Unit {
  guard self.row == self.col
  let stride = self.stride
  for i = 0; i < self.row; i = i + 1 {
    self.data[i * stride + i] = self.data[i * stride + i] + constant
  }
}

///|
pub fn MatrixDbl::mul_elements(
  self : MatrixDbl,
  other : MatrixDbl
) -> MatrixDbl {
  guard self.col == other.col && self.row == other.row
  let stride_self = self.stride
  let stride_other = other.stride
  let matrix_mul = MatrixDbl::new(self.row, self.col)
  for i = 0; i < self.row; i = i + 1 {
    for j = 0; j < self.col; j = j + 1 {
      matrix_mul.data.push(
        self.data[i * stride_self + j] * other.data[i * stride_other + j],
      )
    }
  }
  matrix_mul
}

///|
pub fn MatrixDbl::mul_elements_inplace(
  self : MatrixDbl,
  other : MatrixDbl
) -> Unit {
  guard self.col == other.col && self.row == other.row
  let stride_self = self.stride
  let stride_other = other.stride
  for i = 0; i < self.row; i = i + 1 {
    for j = 0; j < self.col; j = j + 1 {
      self.data[i * stride_self + j] = self.data[i * stride_self + j] *
        other.data[i * stride_other + j]
    }
  }
}

///|
pub fn MatrixDbl::div_elements(
  self : MatrixDbl,
  other : MatrixDbl
) -> MatrixDbl {
  guard self.col == other.col && self.row == other.row
  let stride_self = self.stride
  let stride_other = other.stride
  let matrix_div = MatrixDbl::new(self.row, self.col)
  for i = 0; i < self.row; i = i + 1 {
    for j = 0; j < self.col; j = j + 1 {
      matrix_div.data.push(
        self.data[i * stride_self + j] / other.data[i * stride_other + j],
      )
    }
  }
  matrix_div
}

///|
pub fn MatrixDbl::div_elements_inplace(
  self : MatrixDbl,
  other : MatrixDbl
) -> Unit {
  guard self.col == other.col && self.row == other.row
  let stride_self = self.stride
  let stride_other = other.stride
  for i = 0; i < self.row; i = i + 1 {
    for j = 0; j < self.col; j = j + 1 {
      self.data[i * stride_self + j] = self.data[i * stride_self + j] /
        other.data[i * stride_other + j]
    }
  }
}

///|
fn MatrixDbl::std_mul(self : MatrixDbl, other : MatrixDbl) -> MatrixDbl {
  let stride_self = self.stride
  let stride_other = other.stride
  let matrix_mul = MatrixDbl::new(self.row, other.col)
  for i = 0; i < self.row; i = i + 1 {
    for j = 0; j < other.col; j = j + 1 {
      let mut sum = 0.0
      for k = 0; k < self.col; k = k + 1 {
        sum = sum +
          self.data[i * stride_self + k] * other.data[k * stride_other + j]
      }
      matrix_mul.data.push(sum)
    }
  }
  matrix_mul
}

///|
pub fn op_add(self : MatrixDbl, other : MatrixDbl) -> MatrixDbl {
  guard self.col == other.col && self.row == other.row
  let stride_self = self.stride
  let stride_other = other.stride
  let matrix_add = MatrixDbl::new(self.row, self.col)
  for i = 0; i < self.row; i = i + 1 {
    for j = 0; j < self.col; j = j + 1 {
      matrix_add.data.push(
        self.data[i * stride_self + j] + other.data[i * stride_other + j],
      )
    }
  }
  matrix_add
}

///|
pub fn op_sub(self : MatrixDbl, other : MatrixDbl) -> MatrixDbl {
  guard self.col == other.col && self.row == other.row
  let stride_self = self.stride
  let stride_other = other.stride
  let matrix_sub = MatrixDbl::new(self.row, self.col)
  for i = 0; i < self.row; i = i + 1 {
    for j = 0; j < self.col; j = j + 1 {
      matrix_sub.data.push(
        self.data[i * stride_self + j] - other.data[i * stride_other + j],
      )
    }
  }
  matrix_sub
}

///|
pub fn op_mul(self : MatrixDbl, other : MatrixDbl) -> MatrixDbl {
  guard self.col == other.row
  MatrixDbl::std_mul(self, other)
}
