# CALCULUS-NUMERICAL

Author: KCN-judu

License: MIT

![STATE](https://img.shields.io/badge/STATE-ACTIVE-119F22?style=for-the-badge#pic_left)

# Content（目录）

- __Introduction（简介）__[en_US](#introduction)|[zh_CN](#introduction-zh)
- __Project Progress（项目进度）__[en_US](#project-progress)|[zh_CN](#project-progress-zh)
- __How to Contribute（如何参与贡献）__[en_US](#how-to-contribute)|[zh_CN](#how-to-contribute-zh)

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

# How to Contribute

We are excited to welcome contributions from the community, external developers, and individual enthusiasts! Whether you’re looking to fix a bug, add a new feature, or improve the documentation, your involvement is highly appreciated. To help you get started, here are a few simple steps:

First, please take a look at the `TODO.md` file or the current list of issues to pick a task that interests you. We recommend selecting something you’re passionate about or familiar with, as it’ll make the process more enjoyable and easier to dive into.

Next, fork the project and create a new branch in your personal repository. This allows you to work on your changes without affecting the main project.

While coding, please follow the guidelines and coding conventions outlined in the `CONTRIBUTE.md` file. If your changes involve adding new features or fixing bugs, be sure to thoroughly test your code to ensure everything runs smoothly.

Once you’re done, submit a pull request (PR) with a clear description of your changes. This helps us understand what you’ve worked on and speeds up the review process.

Your PR will be reviewed, and we might suggest improvements or fixes. Don’t worry—this is just to make sure the code quality is top-notch. Once your PR is approved, we’ll merge your contributions into the main branch.

Thank you once again for your time and effort! Every contribution makes a big difference in improving this project. We look forward to seeing your amazing work!

<br>

# 简介{#introduction-zh}

这是一个使用[__MoonBit__](https://www.moonbitlang.cn)编写的微积分数值求解库，旨在填补MoonBit生态在科学计算领域的空白。

本项目将会提供基本的微积分数值求解方法，在积分部分会提供多种可选的数值求解方法。在此基础上，我们还会对如傅里叶变换等复数相关的计算提供支持。

__*从第一个测试版本正式发布开始，会保证英文和中文文档的完整性。在后续的版本更新中可能会加入日语文档。*__

<br>

# 项目进度{#project-progress-zh}

- __[LATEST]__ 25.01.13: 使用 __高斯求积和克龙罗德扩展__ 的自适应积分.
- 25.01.12: 诸如 `min[T:Compare](T, T) -> T` 和 `max[T:Compare](T, T) -> T` 的基本方法. 
- 25.01.11: 对于较长的函数签名提供别名，诸如 `Func_Math` 和 `Quad_GK`.
- 25.01.02: 使用 __高斯求积和克龙罗德扩展__ 的积分求值.
- 24.12.30: 使用 __前向差分、后向差分和中心差分__ 实现的数值导数和数值微分.
- 24.12.29: 能接受任意整数类型的`Integer`类型,  针对`Integer`类型指数的快速幂方法`pow_integer_exp()`.

<br>

# 如何参与贡献{#how-to-contribute-zh}

我们非常欢迎社区、外部开发者以及个人爱好者的贡献！无论你是想解决某个bug、增加新功能，还是改进文档，都非常欢迎你的参与。为了帮助你顺利贡献，以下是一些简单的步骤：

首先，请从`TODO.md`文件或者当前的`issue`列表中挑选一个你感兴趣的任务。我们建议选择自己有兴趣或熟悉的内容，这样你会更容易上手，也能享受其中的过程。

接着，Fork我们的项目，并在你的个人仓库中创建一个新的分支。这样，你就可以在自己的分支上开始进行开发工作，而不会影响到主项目的进展。

在编码过程中，请尽量遵循`CONTRIBUTE.md`中提供的代码风格和规范。如果你的修改涉及到新功能或修复bug，请确保进行充分的测试，确保一切正常运行。

完成后，请提交你的PR，并在提交时提供一个清晰的描述，帮助我们了解你所做的更改。这样有助于更快地进行代码审查和合并。

我们会对你的PR进行审查，并可能会提出一些改进意见。没关系，这只是为了确保代码质量。待审查通过后，我们会将你的贡献合并到主分支中。

再次感谢你的参与和贡献！每一份努力都能让这个项目变得更好。我们期待看到你的精彩代码！