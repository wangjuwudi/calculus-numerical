# CALCULUS-NUMERICAL

Author: KCN-judu

License: MIT

![STATE](https://img.shields.io/badge/STATE-ACTIVE-119F22?style=for-the-badge#pic_left)

# Content（目录）

- __Introduction（简介）__[en_US](#introduction)|[zh_CN](#简介)
- __Project Progress（项目进度）__[en_US](#project-progress)|[zh_CN](#项目进度)

<br>

# Introduction

This is a calculus numerical solution library written using [__MoonBit__](https://www.moonbitlang.com), aiming to fill the gap in scientific computing applications in the MoonBit ecosystem.

This project provides basic numerical solutions for calculus, and multiple optional numerical solution methods for the integral part. On this basis, we will also provide support for complex number related calculations such as Fourier transform.

__*Starting from the first official beta release, the completeness of the English and Chinese documents will be guaranteed. Japanese documents may be added in subsequent version updates.*__

<br>

# Project Progress

- __[LATEST]__ 25.01.13: adaptive quadrature using __Gauss quadrature & Kronrod extension__.
- 25.01.12: basic functions such as `min[T:Compare](T, T) -> T`  and `max[T:Compare](T, T) -> T`. 
- 25.01.11: type alias for long func signature, such as `Func_Math` and `Quad_GK`.
- 25.01.02: quadrature using __Gauss quadrature & Kronrod extension__.
- 24.12.30: derivative and differential using __forward, backward and central diff__.
- 24.12.29: `Integer` type accept all kinds of integer, quick pow function `pow_integer_exp()` for `Integer` exp.

<br>

# 简介

这是一个使用[__MoonBit__](https://www.moonbitlang.cn)编写的微积分数值求解库，旨在填补MoonBit生态在科学计算领域的空白。

本项目将会提供基本的微积分数值求解方法，在积分部分会提供多种可选的数值求解方法。在此基础上，我们还会对如傅里叶变换等复数相关的计算提供支持。

__*从第一个测试版本正式发布开始，会保证英文和中文文档的完整性。在后续的版本更新中可能会加入日语文档。*__

<br>

# 项目进度

- __[LATEST]__ 25.01.13: 使用 __高斯求积和克龙罗德扩展__ 的自适应积分.
- 25.01.12: 诸如 `min[T:Compare](T, T) -> T` 和 `max[T:Compare](T, T) -> T` 的基本方法. 
- 25.01.11: 对于较长的函数签名提供别名，诸如 `Func_Math` 和 `Quad_GK`.
- 25.01.02: 使用 __高斯求积和克龙罗德扩展__ 的积分求值.
- 24.12.30: 使用 __前向差分、后向差分和中心差分__ 实现的数值导数和数值微分.
- 24.12.29: 能接受任意整数类型的`Integer`类型,  针对`Integer`类型指数的快速幂方法`pow_integer_exp()`.

<br>