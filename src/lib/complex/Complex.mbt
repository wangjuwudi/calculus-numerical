///|
pub(all) struct Complex {
  mut re : Double
  mut im : Double
}

//init

///|
pub fn Complex::new(re : Double, im : Double) -> Complex {
  Complex::{ re, im }
}

//oper

///|
pub fn Complex::set(self : Complex, re : Double, im : Double) -> Unit {
  self.re = re
  self.im = im
}

///|
pub fn Complex::set_re(self : Complex, re : Double) -> Unit {
  self.re = re
}

///|
pub fn Complex::set_im(self : Complex, im : Double) -> Unit {
  self.im = im
}

///|
pub fn Complex::native_pack(
  re : Double,
  im : Double,
  arr : Array[Double],
  offset : Int
) -> Unit {
  arr[2 * offset] = re
  arr[2 * offset + 1] = im
}

///|
pub fn Complex::pack(self : Complex, arr : Array[Double], offset : Int) -> Unit {
  Complex::native_pack(self.re, self.im, arr, offset)
}

//math

///|
pub fn Complex::polar(r : Double, theta : Double) -> Complex {
  Complex::new(r * @math.cos(theta), r * @math.sin(theta))
}

///|
pub fn Complex::arg(self : Complex) -> Double {
  guard self.re != 0.0 || self.im != 0.0
  @math.atan2(self.im, self.re)
}

///|
pub fn Complex::abs(self : Complex) -> Double {
  @internal.hypot(self.re, self.im)
}

///|
pub fn Complex::abs_sqr(self : Complex) -> Double {
  self.re * self.re + self.im * self.im
}

//prop

///|
pub impl Eq for Complex with op_equal(self : Complex, other : Complex) -> Bool {
  self.re == other.re && self.im == other.im
}
