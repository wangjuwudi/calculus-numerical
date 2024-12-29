# Basic Computing Support<br>基本的计算支持

<br>

## Trait Integral（Integral接口）

Provides support for arbitrary-precision integer computations.

支持任意精度的整数计算。

## Exponentiation（幂运算）

Supports fast exponentiation for integers of arbitrary precision and floating-point numbers of arbitrary precision.

支持任意精度的整数指数的快速幂运算和浮点指数的快速幂运算。

<br>

# Basic Differential and Integral Functions<br>基本的微积分功能

<br>

## Differentiation（微分）

First-order derivatives, second-order derivatives, and higher-order derivatives. For example, the derivative of a function 𝑦 = 𝑓 ( 𝑥 ) y=f(x) can be approximated using finite difference methods such as forward difference, backward difference, and central difference.

包括一阶导数、二阶导数乃至高阶导数的计算。例如，可以通过有限差分法（前向差分、后向差分和中心差分）来近似计算导数。

## Integration（积分）

Indefinite integrals and definite integrals. Analytical integration can be performed using the Newton-Leibniz formula, and numerical methods like the trapezoidal rule and Simpson's rule can be used for approximate calculations

涵盖不定积分和定积分的计算。例如，使用牛顿-莱布尼茨公式进行解析积分，或者采用数值方法如梯形法则、辛普森法则等进行近似计算。

<br>

# Numerical Methods<br>数值方法

<br>

## Interpolation（插值法）

Lagrange interpolation, spline interpolation, etc., which are used to construct smooth functions for further differentiation or integration.

如拉格朗日插值、样条插值等，用于构造平滑函数以便进一步微分或积分。

## Numerical Differentiation（数值微分）

Euler's method, Runge-Kutta methods, etc., for solving ordinary differential equations (ODEs).

如欧拉法、龙格-库塔法等，用于解决常微分方程（ODEs）的初值问题。

## Numerical Integration（数值积分）

Monte Carlo methods, Gaussian quadrature, etc., for solving complex numerical integration problems.

如蒙特卡洛方法、高斯求积等，用于解决复杂数值积分问题。

<br>

# Special Functions<br>特殊函数

<br>

Gamma function, Bessel functions, error functions, etc. These functions are often encountered in advanced mathematics and physics and are crucial for solving specific calculus problems

伽玛函数、贝塞尔函数、误差函数等，这些在高等数学和物理学中经常遇到的函数，它们的实现往往是解决特定微积分问题的关键。

<br>
