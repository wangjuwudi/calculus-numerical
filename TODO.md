# Content 目录

​	to Contributors 致贡献者 [en_US](#to-contributors)|[zh_CN](#致贡献者)

​	Documentation Writing 文档编写 [en_US](#documentation-writing)|[zh_CN](#文档编写)

​	Feature Implementation 功能实现 [en_US](#feature-implementation)|[zh_CN](#功能实现)



## to Contributors

We warmly welcome developers familiar with the GNU Scientific Library (GSL) to join the project, contribute code, and share their valuable experiences. At the same time, we encourage beginners to learn and master numerical methods related to calculus by participating in development and improving documentation. In this project, we hope that both experienced developers and beginners can find contribution goals that interest them by reviewing the project's documentation, tables, and code examples.

We sincerely thank all the developers who have contributed to this project. Whether through submitting code, improving documentation, or providing valuable feedback, every effort you make helps to make this project better. Your enthusiasm and wisdom in the development process continually drive the project forward, and bring more opportunities for collaboration within the community. We appreciate your support and dedication, and we look forward to achieving more together, driving this project toward an even brighter future!

<br>

## Documentation Writing

In this project, documentation writing is not only the cornerstone of supporting the sustainable development of the project, but also a bridge that helps developers better understand and use numerical solution methods. Since this project mainly focuses on numerical solutions related to calculus, developers need to deeply understand the implementation and application of algorithms, and documentation is the effective tool for transferring this knowledge.

We recognize that improving and updating documentation is a long-term and ongoing task, requiring every member of the community to invest time and effort to continuously supplement and optimize it. Whether it is detailed algorithm explanations or tutorials and usage instructions for beginners, every small improvement will greatly enhance the accessibility and maintainability of the project.

Therefore, we sincerely invite all developers to participate, especially those who are already familiar with GSL. Their experience will provide valuable perspectives for enriching and enhancing the documentation. We also encourage beginners to contribute to writing and improving documentation, as it will not only help them better understand the project but also foster a deeper understanding of calculus and numerical computation through their contributions.

Through joint effort, we believe that the project documentation will become a driving force for the growth of every contributor in the community, helping the project progress further in the future.

<br>

## Feature Implementation

This project mainly focuses on implementing numerical solutions related to calculus, referring to the implementations in the GNU Scientific Library (GSL). Below is a table of GSL functions to be implemented, arranged by dependency (dependencies are listed first). The table covers the function's module, name, purpose, implementation difficulty, and related struct information, providing a convenient reference for developers to choose contribution goals based on their individual needs and abilities.

|                    **Module**                    |       **Function**        |                         **Purpose**                          | **Difficulty** |            **Structures Involved**             |
| :----------------------------------------------: | :-----------------------: | :----------------------------------------------------------: | :------------: | :--------------------------------------------: |
|           **Linear Algebra & Matrix**            |    `gsl_matrix_alloc`     | Allocates matrix space, commonly used in differential equations and optimization. |      Easy      |                  `gsl_matrix`                  |
|                                                  |     `gsl_matrix_set`      |                    Sets matrix elements.                     |      Easy      |                  `gsl_matrix`                  |
|                                                  |     `gsl_matrix_get`      |                    Gets matrix elements.                     |      Easy      |                  `gsl_matrix`                  |
|                                                  |  `gsl_linalg_QR_decomp`   | QR decomposition, commonly used in numerical solutions and optimization. |     Medium     |                  `gsl_matrix`                  |
|                                                  |   `gsl_linalg_QR_solve`   |       Solves linear equations using QR decomposition.        |     Medium     |           `gsl_matrix`, `gsl_vector`           |
|            **Numerical Integration**             |   `gsl_integration_qag`   | Adaptive integration method, suitable for definite integrals of general functions. |     Medium     |  `gsl_function`, `gsl_integration_workspace`   |
|                                                  |   `gsl_integration_qng`   |   Adaptive integration method with uncertainty estimation.   |     Medium     |  `gsl_function`, `gsl_integration_workspace`   |
|                                                  |  `gsl_integration_qtrap`  |             Trapezoidal method for integration.              |      Easy      |  `gsl_function`, `gsl_integration_workspace`   |
|                                                  | `gsl_integration_simpson` |              Simpson's method for integration.               |     Medium     |  `gsl_function`, `gsl_integration_workspace`   |
|                                                  |  `gsl_integration_qawo`   | Adaptive integration method for infinite intervals (e.g., integration over `[a, ∞)`). |      Hard      |  `gsl_function`, `gsl_integration_workspace`   |
|                                                  |  `gsl_integration_qagp`   | Adaptive integration method for functions with singularities over a given interval. |      Hard      |  `gsl_function`, `gsl_integration_workspace`   |
|                                                  |  `gsl_integration_cquad`  | Boundary integration method, adaptive numerical integration for a wide range of functions. |     Medium     |  `gsl_function`, `gsl_integration_workspace`   |
|                                                  |  `gsl_integration_qawc`   | Adaptive method for infinite interval integration, suitable for oscillatory functions. |      Hard      |  `gsl_function`, `gsl_integration_workspace`   |
|                                                  |  `gsl_integration_qawf`   | Adaptive integration for infinite intervals, for functions with specific oscillatory properties. |      Hard      |  `gsl_function`, `gsl_integration_workspace`   |
|                                                  |  `gsl_integration_qawf2`  | Further optimization of infinite interval integration, suitable for functions with different oscillatory behaviors. |      Hard      |  `gsl_function`, `gsl_integration_workspace`   |
|                                                  | `gsl_integration_gslquad` |     Uses GSL for adaptive multidimensional integration.      |      Hard      |  `gsl_function`, `gsl_integration_workspace`   |
| **Ordinary Differential Equation (ODE) Solvers** |  `gsl_odeiv2_step_init`   |                 Initializes step functions.                  |     Medium     |     `gsl_odeiv2_step`, `gsl_odeiv2_system`     |
|                                                  |     `gsl_odeiv2_step`     | Computes solutions to ordinary differential equations (Runge-Kutta, Euler methods, etc.). |      Hard      |     `gsl_odeiv2_step`, `gsl_odeiv2_system`     |
|                                                  |  `gsl_odeiv2_step_apply`  | Applies step functions for the core steps in ODE computation. |      Hard      |     `gsl_odeiv2_step`, `gsl_odeiv2_system`     |
|                                                  |    `gsl_odeiv2_driver`    | Drives the ODE solver, solving using different steps and methods. |      Hard      |    `gsl_odeiv2_driver`, `gsl_odeiv2_system`    |
|                                                  |    `gsl_odeiv2_system`    | Defines the system of ordinary differential equations for the solver's input. |     Medium     |              `gsl_odeiv2_system`               |
|           **Taylor Series Expansion**            |        `gsl_poly`         | Polynomial handling functions, including evaluation and derivatives. |      Easy      |                   `gsl_poly`                   |
|                                                  |      `gsl_poly_eval`      | Evaluates polynomial values (can be used to approximate Taylor series expansions). |      Easy      |                   `gsl_poly`                   |
|                                                  |     `gsl_poly_deriv`      | Computes the derivative of a polynomial (can be used for the derivative of a Taylor series). |      Easy      |                   `gsl_poly`                   |
|                                                  |     `gsl_poly_coeffs`     |              Retrieves polynomial coefficients.              |      Easy      |                   `gsl_poly`                   |
|                                                  |      `gsl_poly_fit`       | Polynomial fitting, used for constructing the fitting part of a Taylor series. |     Medium     |                   `gsl_poly`                   |
|            **Numerical Optimization**            |  `gsl_multimin_function`  | Defines multidimensional optimization functions, used for minimization algorithms. |     Medium     |            `gsl_multimin_function`             |
|                                                  |   `gsl_multimin_fminim`   | Computes the minimum value during the minimization process.  |     Medium     |             `gsl_multimin_fminim`              |
|                                                  |     `gsl_min_fminim`      | Numerical methods for minimization, suitable for least squares problems. |     Medium     | `gsl_multimin_function`, `gsl_multimin_fminim` |
|                                                  |      `gsl_multimin`       | Multidimensional optimization functions, suitable for multivariable optimization problems. |      Hard      | `gsl_multimin_function`, `gsl_multimin_fminim` |
|                                                  |  `gsl_multimin_fdfminim`  | Computes optimization problems for multidimensional functions, supporting gradient descent. |      Hard      | `gsl_multimin_function`, `gsl_multimin_fminim` |
|                                                  |   `gsl_multimin_deriv`    | Computes derivatives of multidimensional functions for optimization problems. |     Medium     |            `gsl_multimin_function`             |
|                **Interpolation**                 |       `gsl_interp`        | One-dimensional interpolation function interface, suitable for various interpolation methods (e.g., linear, spline). |     Medium     |        `gsl_interp`, `gsl_interp_accel`        |
|                                                  |      `gsl_interp2d`       |      Two-dimensional interpolation function interface.       |     Medium     |       `gsl_interp2d`, `gsl_interp_accel`       |
|              **Fourier Transform**               |     `gsl_fft_complex`     |             Fourier transform for complex data.              |     Medium     |               `gsl_fft_complex`                |
|                                                  |      `gsl_fft_real`       |               Fourier transform for real data.               |     Medium     |                 `gsl_fft_real`                 |

<br>

## 致贡献者

我们诚挚欢迎熟悉GNU Scientific Library（GSL）的开发者加入项目，贡献代码并分享宝贵经验。同时，我们也鼓励初学者通过参与开发和完善文档，学习并掌握微积分相关的数值求解方法。在本项目中，我们希望无论是经验丰富的开发者，还是正在学习的初学者，都能通过查阅项目中的文档、表格和代码示例，找到自己感兴趣的贡献目标。

我们衷心感谢所有为本项目做出贡献的开发者。无论是通过提交代码、改善文档，还是提供宝贵的反馈，你们的每一份努力都让这个项目变得更加完善。在开发过程中，大家的热情与智慧不断推动着项目的发展，也为社区带来了更多的合作机会。感谢你们的支持与奉献，我们期待与大家共同创造更多的成就，推动这个项目走向更加光明的未来！

<br>

## 文档编写

在本项目中，文档编写不仅是支持项目可持续发展的基石，也是帮助开发者更好地理解和使用数值求解方法的桥梁。由于本项目主要聚焦于微积分相关的数值求解问题，开发者需要深入理解算法的实现和应用，而文档正是提供这种知识传递的有效工具。

我们认识到，文档的完善和更新是一项长期且持续的工作，它要求社区中的每一位成员投入时间和精力，不断补充和优化。无论是详细的算法解释，还是针对初学者的教程和使用说明，每一个小小的改进都会极大地提高项目的可访问性和可维护性。

因此，我们诚挚地邀请所有开发者参与其中，特别是那些已经熟悉GSL的开发者，他们的经验将为文档的丰富和提升提供宝贵的视角。同时，我们也鼓励初学者参与文档的编写和完善，这不仅能够帮助他们更好地理解项目，也能在贡献的过程中培养他们对微积分和数值计算的深刻理解。

通过共同努力，我们相信，项目的文档会成为社区中每一位贡献者成长的动力，帮助项目在未来走得更远。

<br>

## 功能实现

本项目主要聚焦于实现微积分相关的数值求解问题，参考GNU Scientific Library（以下简称GSL）的实现。以下是按照依赖关系（被依赖优先）排列的需要实现的GSL函数表格，涵盖了函数的功能模块、函数、作用、实现难度以及涉及的结构体信息，方便开发者查阅并根据个人需求和能力选择贡献目标。

|       **功能模块**        |        **函数名**         |                           **作用**                           | **实现难度** |                **涉及的结构体**                |
| :-----------------------: | :-----------------------: | :----------------------------------------------------------: | :----------: | :--------------------------------------------: |
|    **线性代数和矩阵**     |    `gsl_matrix_alloc`     |            分配矩阵空间，常用于微分方程和优化中。            |     简单     |                  `gsl_matrix`                  |
|                           |     `gsl_matrix_set`      |                        设置矩阵元素。                        |     简单     |                  `gsl_matrix`                  |
|                           |     `gsl_matrix_get`      |                        获取矩阵元素。                        |     简单     |                  `gsl_matrix`                  |
|                           |  `gsl_linalg_QR_decomp`   |                QR分解，常用于数值求解和优化。                |     中等     |                  `gsl_matrix`                  |
|                           |   `gsl_linalg_QR_solve`   |                   使用QR分解求解线性方程。                   |     中等     |           `gsl_matrix`, `gsl_vector`           |
|       **数值积分**        |   `gsl_integration_qag`   |         自适应积分方法，适用于一般函数的定积分计算。         |     中等     |  `gsl_function`, `gsl_integration_workspace`   |
|                           |   `gsl_integration_qng`   |              自适应积分方法，提供不确定度估计。              |     中等     |  `gsl_function`, `gsl_integration_workspace`   |
|                           |  `gsl_integration_qtrap`  |                       梯形法积分实现。                       |     简单     |  `gsl_function`, `gsl_integration_workspace`   |
|                           | `gsl_integration_simpson` |                      辛普森法积分实现。                      |     中等     |  `gsl_function`, `gsl_integration_workspace`   |
|                           |  `gsl_integration_qawo`   | 自适应积分方法，适用于无穷区间积分（例如，积分区间为 `[a, ∞)`）。 |    高难度    |  `gsl_function`, `gsl_integration_workspace`   |
|                           |  `gsl_integration_qagp`   |    自适应积分方法，适用于在给定积分区间上有奇异点的函数。    |    高难度    |  `gsl_function`, `gsl_integration_workspace`   |
|                           |  `gsl_integration_cquad`  |        边界积分法，自适应数值积分，适用于广泛的函数。        |     中等     |  `gsl_function`, `gsl_integration_workspace`   |
|                           |  `gsl_integration_qawc`   |      无穷区间积分，自适应方法，适合具有振荡性质的函数。      |    高难度    |  `gsl_function`, `gsl_integration_workspace`   |
|                           |  `gsl_integration_qawf`   |     无穷区间积分，针对具有特定振荡性函数进行自适应计算。     |    高难度    |  `gsl_function`, `gsl_integration_workspace`   |
|                           |  `gsl_integration_qawf2`  |   无穷区间积分的进一步优化，适用于具有不同振荡性质的函数。   |    高难度    |  `gsl_function`, `gsl_integration_workspace`   |
|                           | `gsl_integration_gslquad` |             在多维积分中使用GSL进行自适应求解。              |    高难度    |  `gsl_function`, `gsl_integration_workspace`   |
| **常微分方程（ODE）求解** |  `gsl_odeiv2_step_init`   |                       初始化步骤函数。                       |     中等     |     `gsl_odeiv2_step`, `gsl_odeiv2_system`     |
|                           |     `gsl_odeiv2_step`     |       计算常微分方程的解（Runge-Kutta法、欧拉法等）。        |    高难度    |     `gsl_odeiv2_step`, `gsl_odeiv2_system`     |
|                           |  `gsl_odeiv2_step_apply`  |            应用步骤函数，进行ODE计算的核心步骤。             |    高难度    |     `gsl_odeiv2_step`, `gsl_odeiv2_system`     |
|                           |    `gsl_odeiv2_driver`    |         驱动ODE求解器，使用不同的步长和方法求解ODE。         |    高难度    |    `gsl_odeiv2_driver`, `gsl_odeiv2_system`    |
|                           |    `gsl_odeiv2_system`    |         定义常微分方程的系统，作为ODE求解器的输入。          |     中等     |              `gsl_odeiv2_system`               |
|     **泰勒级数展开**      |        `gsl_poly`         |               多项式处理函数，包含评估和导数。               |     简单     |                   `gsl_poly`                   |
|                           |      `gsl_poly_eval`      |        计算多项式的值（可以用来近似泰勒级数的展开）。        |     简单     |                   `gsl_poly`                   |
|                           |     `gsl_poly_deriv`      |        计算多项式的导数（可用于计算泰勒级数的导数）。        |     简单     |                   `gsl_poly`                   |
|                           |     `gsl_poly_coeffs`     |                      获取多项式的系数。                      |     简单     |                   `gsl_poly`                   |
|                           |      `gsl_poly_fit`       |           多项式拟合，用于构建泰勒级数的拟合部分。           |     中等     |                   `gsl_poly`                   |
|       **数值优化**        |  `gsl_multimin_function`  |            多维优化函数的定义，供最小化算法使用。            |     中等     |            `gsl_multimin_function`             |
|                           |   `gsl_multimin_fminim`   |                 计算最小化过程中的最小化值。                 |     中等     |             `gsl_multimin_fminim`              |
|                           |     `gsl_min_fminim`      |         最小化函数的数值方法，适用于最小二乘问题等。         |     中等     | `gsl_multimin_function`, `gsl_multimin_fminim` |
|                           |      `gsl_multimin`       |            多维优化函数，适用于多变量的优化问题。            |    高难度    | `gsl_multimin_function`, `gsl_multimin_fminim` |
|                           |  `gsl_multimin_fdfminim`  |           计算多维函数的优化问题，支持梯度下降法。           |    高难度    | `gsl_multimin_function`, `gsl_multimin_fminim` |
|                           |   `gsl_multimin_deriv`    |              计算多维函数的导数，用于优化问题。              |     中等     |            `gsl_multimin_function`             |
|         **插值**          |       `gsl_interp`        | 一维插值函数接口，适用于各种插值方法（如线性插值、样条插值）。 |     中等     |        `gsl_interp`, `gsl_interp_accel`        |
|                           |      `gsl_interp2d`       |                      二维插值函数接口。                      |     中等     |       `gsl_interp2d`, `gsl_interp_accel`       |
|      **傅里叶变换**       |     `gsl_fft_complex`     |                  对复数数据进行傅里叶变换。                  |     中等     |               `gsl_fft_complex`                |
|                           |      `gsl_fft_real`       |                  对实数数据进行傅里叶变换。                  |     中等     |                 `gsl_fft_real`                 |

<br>
