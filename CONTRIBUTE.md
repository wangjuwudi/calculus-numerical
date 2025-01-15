# Contribution Conventions 贡献规范

<br>

## Content 目录

1. Code Style 代码风格 [en_US](#1-code-style)|[zh_CN](#1-代码风格)

2. Naming Conventions 命名约定 [en_US](#2-naming-conventions)|[zh_CN](#2-命名约定)

   2.1 Variable Naming 变量命名 [en_US](#21-variable-naming)|[zh_CN](#21-变量命名)

   2.2 Function Naming 函数命名 [en_US](#22-function-naming)|[zh_CN](#22-函数命名)

   2.3 Struct and Trait Naming Struct和Trait命名 [en_US](#23-struct-and-trait-naming)|[zh_CN](#23-struct-和-trait-命名)

   2.4 Constant Naming 常量命名 [en_US](#24-constant-naming)|[zh_CN](#24-常量命名)

   2.5 Result's Err Constructs Result的Err构造内容 [en_US](#25-results-err-constructs)|[zh_CN](#25-result的err构造内容)

3. Comments 注释 [en_US](#3-comments)|[zh_CN](#3-注释)

   3.1 Commenting Principles 注释原则 [en_US](#31-commenting-principles)|[zh_CN](#31-注释原则)

4. File Naming Conventions 文件规范 [en_US](#4-file-naming-conventions)|[zh_CN](#4-文件规范)

   4.1 Folder Naming 文件夹命名 [en_US](#41-folder-naming)|[zh_CN](#41-文件夹命名)

   4.2 File Division 文件划分 [en_US](#42-file-division)|[zh_CN](#42-文件划分)

   4.3 Generating .mbti Files .mbti文件的生成 [en_US](#43-generating-mbti-files)|[zh_CN](#43-mbti文件的生成)

5. Commit Guidelines 提交规范 [en_US](#5-commit-guidelines)|[zh_CN](#5-提交规范)

   5.1 Commit Messages 提交信息 [en_US](#51-commit-messages)|[zh_CN](#51-提交信息)

   5.2 Commit Frequency 提交频率 [en_US](#52-commit-frequency)|[zh_CN](#52-提交频率)

6. Code Review 代码审查 [en_US](#6-code-review)|[zh_CN](#6-代码审查)

<br>

## 1. Code Style

- Use the formatting style of the MoonBit Toolchain, and automatically format the code by running the following command:

  ```
  moon fmt
  ```

  Please ensure that the code is formatted using `moon fmt` before submitting to maintain a consistent code style.

<br>

## 2. Naming Conventions

### 2.1 Variable Naming

- Use **lowercase letters and underscores** to separate words (e.g., `my_var`).
- Variable names should be descriptive and clearly reflect their purpose.

<br>

### 2.2 Function Naming

- Use **lowercase letters and underscores** to separate words (e.g., `calc_total_price()`).
- Function names should be concise and descriptive, clearly expressing the function's behavior.

<br>

### 2.3 Struct and Trait Naming

- Use **CamelCase with an uppercase initial letter** (e.g., `MyStruct`, `MyTrait`).
- The name should intuitively reflect the function or role of the struct or trait, avoiding overly abstract or non-descriptive names.

<br>

### 2.4 Constant Naming

- **Note:** In the context of MoonBit, “variables” are usually referred to as “bindings,” and by default, they are immutable. Only with the `mut` keyword can they be made mutable. Therefore, there is no strict naming distinction between constants and “variables,” and consistency should be maintained.
- Constant names should be in **all lowercase letters with underscores** separating words (e.g., `machine_dbl_epsilon`).
- Constant names often begin with the first word as a prefix, indicating the constant's purpose or category. For example, `machine_dbl_epsilon` has `machine` indicating it is related to machine constants.
- Constant names should be concise and descriptive to make it easier for other developers to understand.

<br>

### 2.5 Result's Err Constructs

- Use **uppercase letters with underscores** separating words (e.g., `E_MAX_ITER`).
- The construct should typically start with the letter "E" to indicate it is used for Err construction.
- The construct should be concise and descriptive to help other developers understand its meaning.

<br>

## 3. Comments

### 3.1 Commenting Principles

- **Conciseness**: Comments should be brief and to the point, containing only necessary information. Avoid verbosity and unrelated content.
- **Consistency**: Use consistent terminology and style throughout the code, avoiding different ways of describing the same concept in different places.
- **Clarity**: Ensure comments are easy to understand. Avoid complex terminology or vague phrasing. Any reader should be able to quickly grasp the purpose of the comment.
- **Accuracy**: Comments must accurately reflect the functionality and purpose of the code, avoiding discrepancies with the actual code behavior.
- **Up-to-date**: As the code changes, comments should be updated accordingly to ensure they stay synchronized with the code.

We encourage developers to use the AI comment generation provided by the MoonBit LSP to improve the efficiency of writing comments. However, developers should review the AI-generated content to ensure it correctly explains the methods, structs, and traits.

<br>

## 4. File Naming Conventions

<br>

### 4.1 Folder Naming

- For major functional modules, use lowercase letter folder names (packages).

- The names should be concise, descriptive, and only use lowercase letters and underscores (_) to separate words. Avoid using numbers or special characters.

  Example:

  - For differential-related functions: `diff`
  - For derivative-related functions: `deriv`

<br>

### 4.2 File Division

- Files should be divided by function, with each file focused on a specific task. File names should be descriptive, clearly indicating the core function the file implements. It is recommended to use lowercase letters and underscores (_) in file names.

  Example:

  - `gauss_kronrod.mbt`: Implements Gaussian quadrature with Kronrod extension.
  - `adaptive_quadrature_gk.mbt`: Adaptive integration using Gaussian quadrature with Kronrod extension.

- **Note**: Avoid using overly general or vague names in file names (except where unavoidable in @internal). For instance, avoid naming files `utils.mbt`; try to relate the file name to its function or module.

<br>

### 4.3 Generating .mbti Files

- Use the MoonBit Toolchain's unified `.mbti` file generation and updates by running the following command:

  ```
  moon info
  ```

  Please ensure that `.mbti` files are generated and updated with `moon info` before submitting the code to ensure a unified file structure.

<br>

## 5. Commit Guidelines

### 5.1 Commit Messages

- Each commit should have a clear description, explaining what changes are made.

- Use the MoonBit Toolchain for code checks by running the following command:

  ```
  moon check
  ```

  Ensure the code is checked with `moon check` before submitting to ensure there are no compilation errors.

- Commit messages should be in **English** and follow the principles of **brevity and clarity**.

- Use prefixes like `fix:`, `feat:`, `refactor:` and `doc:` to categorize the commit type.

Example:

```
fix: fix bug in something
feat: add feature for something
refactor: refactor something
doc: add docs for something
```

<br>

### 5.2 Commit Frequency

- Try to keep each commit small and focused on a single feature or fix.
- Avoid committing large-scale changes at once.

<br>

## 6. Code Review

- All code submissions must go through **code review**.
- During the review, focus on code quality, style, performance, and security.
- Reviewers should provide constructive feedback to help improve the code.

<br>

----



## 1. 代码风格

- 统一采用 MoonBit Toolchain 的格式化风格，通过运行以下命令来自动格式化代码。

  ```
  moon fmt
  ```

  请确保在提交代码之前，使用 `moon fmt` 格式化代码，以保持一致的代码风格。

<br>

## 2. 命名约定

### 2.1 变量命名

- 采用 **小写字母和下划线** 分隔（例如：`my_var`）。
- 变量名应具有描述性，能够准确反映其用途。

<br>

### 2.2 函数命名

- 使用 **小写字母和下划线** 分隔（例如：`calc_total_price()`）。
- 函数名应简洁且具有描述性，能够清晰表达函数的功能。

<br>

### 2.3 Struct 和 Trait 命名

- 使用 **首字母大写的驼峰式命名**（例如：`MyStruct`、`MyTrait`）。
- 命名应直观地反映该结构体或特征的功能或角色，避免使用过于抽象或不具描述性的名称。

<br>

### 2.4 常量命名

- **注意：** 由于在 MoonBit 的语境下，“变量”通常称为“binding”，且默认是不可变的，只有添加 `mut` 关键字才能使其可变。因此，常量和“变量”之间没有严格的命名差异，保持一致性。
- 常量名采用 **全小写字母和下划线** 分隔（例如：`machine_dbl_epsilon`）。
- 常量名通常以第一个单词作为前缀，表示常量的用途或分类。例如，`machine_dbl_epsilon` 中的 `machine` 表示与机器相关的常量。
- 常量名应简洁且具有描述性，便于其他开发者理解。

<br>

### 2.5 Result的Err构造内容

- 采用 **全大写字母和下划线** 分隔（例如：`E_MAX_ITER`）。
- 构造内容通常以字符E作为前缀，表示其用于Err构造。
- 构造内容应简洁且具有描述性，便于其他开发者理解。

<br>

## 3. 注释

### 3.1 注释原则

- **简洁性**：注释应简洁明了，只包含必要的信息，避免冗长和不相关的内容。

- **一致性**：使用一致的术语和风格，避免在不同地方使用不同的方式描述相同的概念。
- **清晰性**：确保注释易于理解，避免复杂的术语或模糊的表述。应使任何阅读代码的人能够快速理解注释的意图。 
- **准确性**：注释必须准确反映代码的功能和目的，避免与代码行为不符的描述。 
- **更新性**：随着代码的变更，注释也应随时更新，确保注释与代码同步。

我们鼓励开发者采用MoonBit LSP提供的AI代码注释生成来提升注释的编写效率，但需要开发者对AI生成的内容进行审核，以确保其对方法、结构体和特征的解释是正确无误的。

<br>

## 4. 文件规范

<br>

### 4.1 文件夹命名

- 对于大的功能模块，请使用小写字母命名的文件夹（包）。
- 命名应简洁、描述性强，且仅使用小写字母和下划线（_）来分隔单词。请避免使用数字和特殊字符。

​	例如：

​		微分相关功能：`diff`

​		导数相关功能：`deriv`

<br>

### 4.2 文件划分

- 文件应该按功能划分，每个文件专注于特定的功能。文件名应具备描述性，清楚反映该文件所实现的核心功能。推荐使用小写字母和下划线（_）进行文件名的命名。

​	例如：

​		`gauss_kronrod.mbt`：实现带克龙罗德扩展的高斯求积。

​		`adaptive_quadrature_gk.mbt`：使用带克龙罗德扩展的高斯求积实现的自适应积分。

- **注意**：在文件命名中（除了在@internal中不可避免的情况），请避免使用过于通用或模糊的名称，如 `utils.mbt`，请尽量使文件名与其功能或模块相关联。

<br>

### 4.3 .mbti文件的生成

- 统一采用 MoonBit Toolchain 的.mbti文件生成和更新，通过运行以下命令来自动生成和更新.mbti文件。

  ```
  moon info
  ```

  请确保在提交代码之前，使用 `moon info` 生成和更新.mbti文件，以保证统一的文件结构。

<br>

## 5. 提交规范

### 5.1 提交信息

- 每个提交应具有清晰的描述，说明此次提交所做的变更。

- 统一采用 MoonBit Toolchain 来对代码进行检查，通过运行以下命令来自动检查。

  ```
  moon check
  ```

  请确保在提交代码之前，使用 `moon check` 检查代码，以保证代码没有编译错误。

- 提交信息应使用**英文**，并遵循**简短、精炼**的原则。

- 使用 `fix:`，`feat:`，`refactor:` 和 `doc:` 前缀来区分提交的类型

示例：

```
fix: fix bug in something
feat: add feature for something
refactor: refactor something
doc: add docs for something
```

<br>

### 5.2 提交频率

- 尽量保持每次提交都很小且聚焦于一个功能或修复。
- 不要一次性提交大规模的更改。

<br>

## 6. 代码审查

- 所有的代码提交都必须经过**代码审查**。
- 在审查过程中，关注代码质量、风格、性能和安全性。
- 审查者应提供建设性的反馈，帮助改进代码。
