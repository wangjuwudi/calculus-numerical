///|
let integer_2 : BigInt = 2

///|
let integer_1 : BigInt = 1

///|
let integer_0 : BigInt = 0

///|
let integer_neg_1 : BigInt = -1

///|
pub(open) trait Integer: Eq + Compare + Show {
  op_and(Self, Self) -> Self
  op_add(Self, Self) -> Self
  op_sub(Self, Self) -> Self
  op_mul(Self, Self) -> Self
  op_div(Self, Self) -> Self
  op_mod(Self, Self) -> Self
  op_neg(Self) -> Self
  to_integer(Self) -> BigInt
}

///|
pub impl Integer for Int with op_and(self, other) { self & other }

///|
pub impl Integer for Int64 with op_and(self, other) { self & other }

///|
pub impl Integer for BigInt with op_and(self, other) { self & other }

///|
pub impl Integer for Int with op_add(self, other) { self + other }

///|
pub impl Integer for Int64 with op_add(self, other) { self + other }

///|
pub impl Integer for BigInt with op_add(self, other) { self + other }

///|
pub impl Integer for Int with op_sub(self, other) { self - other }

///|
pub impl Integer for Int64 with op_sub(self, other) { self - other }

///|
pub impl Integer for BigInt with op_sub(self, other) { self - other }

///|
pub impl Integer for Int with op_mul(self, other) { self * other }

///|
pub impl Integer for Int64 with op_mul(self, other) { self * other }

///|
pub impl Integer for BigInt with op_mul(self, other) { self * other }

///|
pub impl Integer for Int with op_div(self, other) { self / other }

///|
pub impl Integer for Int64 with op_div(self, other) { self / other }

///|
pub impl Integer for BigInt with op_div(self, other) { self / other }

///|
pub impl Integer for Int with to_integer(self) { BigInt::from_int(self) }

///|
pub impl Integer for Int64 with to_integer(self) { BigInt::from_int64(self) }

///|
pub impl Integer for Int with op_mod(self, other) { self % other }

///|
pub impl Integer for Int64 with op_mod(self, other) { self % other }

///|
pub impl Integer for BigInt with op_mod(self, other) { self % other }

///|
pub impl Integer for Int with op_neg(self) { -self }

///|
pub impl Integer for Int64 with op_neg(self) { -self }

///|
pub impl Integer for BigInt with op_neg(self) { -self }

///|
pub impl Integer for BigInt with to_integer(self) { self }

///|
pub fn is_odd[T : Integer](integer_num : T) -> Bool {
  (integer_num.to_integer() & integer_1) == integer_1
}

///|
pub fn is_even[T : Integer](integer_num : T) -> Bool {
  (integer_num.to_integer() & integer_1) == integer_0
}

///|
pub fn sign[T : Integer](integer_num : T) -> BigInt {
  if integer_num.to_integer() > integer_0 {
    integer_1
  } else {
    integer_neg_1
  }
}
