///|
pub fn pow_integer_exp(base : Double, exp : Integer) -> Double {
  match exp {
    IntegerInt(exp_int) =>
      if exp_int == 0 {
        1.0
      } else if exp_int == 1 {
        base
      } else if exp_int < 0 {
        if exp_int == @int.min_value {
          1.0 / pow_integer_exp(base, (-Int::to_int64(exp_int)).to_integer())
        } else {
          1.0 / pow_integer_exp(base, (-exp_int).to_integer())
        }
      } else if exp_int % 2 == 0 {
        let half_pow = pow_integer_exp(base, IntegerInt(exp_int / 2))
        half_pow * half_pow
      } else {
        let half_pow = pow_integer_exp(base, IntegerInt((exp_int - 1) / 2))
        half_pow * half_pow * base
      }
    IntegerInt64(exp_int64) =>
      if exp_int64 == 0 {
        1.0
      } else if exp_int64 == 1 {
        base
      } else if exp_int64 < 0 {
        if exp_int64 == @int64.min_value {
          1.0 /
          pow_integer_exp(base, (-BigInt::from_int64(exp_int64)).to_integer())
        } else {
          1.0 / pow_integer_exp(base, (-exp_int64).to_integer())
        }
      } else if exp_int64 % 2 == 0 {
        let half_pow = pow_integer_exp(base, (exp_int64 / 2).to_integer())
        half_pow * half_pow
      } else {
        let half_pow = pow_integer_exp(base, ((exp_int64 - 1) / 2).to_integer())
        half_pow * half_pow * base
      }
    Integer(exp_big_int) =>
      if exp_big_int == 0 {
        1.0
      } else if exp_big_int == 1 {
        base
      } else if exp_big_int < 0 {
        1.0 / pow_integer_exp(base, (-exp_big_int).to_integer())
      } else if exp_big_int % 2 == 0 {
        let half_pow = pow_integer_exp(base, (exp_big_int / 2).to_integer())
        half_pow * half_pow
      } else {
        let half_pow = pow_integer_exp(
          base,
          ((exp_big_int - 1) / 2).to_integer(),
        )
        half_pow * half_pow * base
      }
  }
}
