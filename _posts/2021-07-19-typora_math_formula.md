---
layout: post
title: Typora数学模块
date: 2021-07-19
categories: 
tags: 
---
Typora数学模块




### 1. 打开Typora数学模块

- 点击“段落”—>“公式块”
- 快捷键Ctrl+Shift+m
- “$$”+回车



### 2.常用公式的代码

**上/下标**

| 算式   | Markdown |
| ------ | -------- |
| $x^2$ | x^2      |
| $y_1$ | y_1      |

**分式**

| 算式              | Markdown    |
| ----------------- | ----------- |
| $1/2$      | 1/2         |
| $\frac{1}{2}$ | \frac{1}{2} |

**省略号**

| 省略号   | Markdown |
| -------- | -------- |
| $\cdots$ | \cdots   |

**开根号**

| 算式       | Markdown |
| ---------- | -------- |
| $\sqrt{2}$ | \sqrt{2} |

**矢量**

| 算式      | Markdown |
| --------- | -------- |
| $\vec{a}$ | \vec{a}  |

**积分**

| 算式                | Markdown          |
| ------------------- | ----------------- |
| $\int{x}dx$         | \int{x}dx         |
| $\int_{1}^{2}{x}dx$ | \int_{1}^{2}{x}dx |

**极限**

| 算式                         | Markdown                   |
| ---------------------------- | -------------------------- |
| $\lim{a+b}$                  | \lim{a+b}                  |
| $\lim_{n\rightarrow+\infty}$ | \lim_{n\rightarrow+\infty} |

**累加**

| 算式                    | Markdown              |
| ----------------------- | --------------------- |
| $\sum{a}$               | \sum{a}               |
| $\sum_{n=1}^{100}{a_n}$ | \sum_{n=1}^{100}{a_n} |

**累乘**

| 算式                    | Markdown              |
| ----------------------- | --------------------- |
| $\prod{x}$              | \prod{x}              |
| $\prod_{n=1}^{99}{x_n}$ | \prod_{n=1}^{99}{x_n} |

**希腊字母**

| 大写       | Markdown | 小写          | Markdown    |
| ---------- | -------- | ------------- | ----------- |
| $A$        | A        | $\alpha$      | \alpha      |
| $B$        | B        | $\beta$       | \beta       |
| $\Gamma$   | \Gamma   | $\gamma$      | \gamma      |
| $\Delta$   | \Delta   | $\delta$      | \delta      |
| $E$        | E        | $\epsilon$    | \epsilon    |
|            |          | $\varepsilon$ | \varepsilon |
| $Z$        | Z        | $\zeta$       | \zeta       |
| $H$        | H        | $\eta$        | \eta        |
| $\Theta$   | \Theta   | $\theta$      | \theta      |
| $I$        | I        | $\iota$       | \iota       |
| $K$        | K        | $\kappa$      | \kappa      |
| $\Lambda$  | \Lambda  | $\lambda$     | \lambda     |
| $M$        | M        | $\mu$         | \mu         |
| $\nu$      | N        | $\nu$         | \nu         |
| $\Xi$      | \Xi      | $\xi$         | \xi         |
| $O$        | O        | $\omicron$    | \omicron    |
| $\Pi$      | \Pi      | $\pi$         | \pi         |
| $P$        | P        | $\rho$        | \rho        |
| $\Sigma$   | \Sigma   | $\sigma$      | \sigma      |
| $T$        | T        | $\tau$        | \tau        |
| $\Upsilon$ | \Upsilon | $\upsilon$    | \upsilon    |
| $\Phi$     | \Phi     | $\phi$        | \phi        |
|            |          | $\varphi$     | \varphi     |
| $X$        | X        | $\chi$        | \chi        |
| $\Psi$     | \Psi     | $\psi$        | \psi        |
| $\Omega$   | \Omega   | $\omega$      | \omega      |

**三角函数**

| 三角函数 | Markdown |
| -------- | -------- |
| $\sin$   | \sin     |

**对数函数**

| 算式      | Markdown |
| --------- | -------- |
| $\ln2$    | \ln2     |
| $\log_28$ | \log_28  |
| $\lg10$   | \lg10    |

**关系运算符**

| 运算符   | Markdown |
| -------- | -------- |
| $\pm$    | \pm      |
| $\times$ | \times   |
| $\cdot$  | \cdot    |
| $\div$   | \div     |
| $\neq$   | \neq     |
| $\equiv$ | \equiv   |
| $\leq$   | \leq     |
| $\geq$   | \geq     |

**其它特殊字符**

| 符号          | Markdown   |
| ------------- | ---------- |
| $\forall$  | \forall    |
| $\infty$   | \infty     |
| $\emptyset$ | \emptyset  |
| $\exists$ | \exists    |
| $\nabla$    | \nabla     |
| $bot$      | \bot       |
| $\angle$     | \angle     |
| $\because$  | \because   |
| $\therefore$ | \therefore |
| 空格 $\quad$ |   \quad |

**花括号**
$$
c(u)=\begin{cases} \sqrt\frac{1}{N}，u=0\\ \sqrt\frac{2}{N}， u\neq0\end{cases} 
$$

```
c(u) = \begin{cases} 
    \sqrt\frac{1}{N}，u=0\\ 
    \sqrt\frac{2}{N}，u\neq0
\end{cases} 
```

**矩阵**

$$
a = \left[
\matrix{
  \alpha_1 & test1\\
  \alpha_2 & test2\\
  \alpha_3 & test3  
}
\right]
$$



```
$$
a = \left[
\matrix{
  \alpha_1 & test1\\
  \alpha_2 & test2\\
  \alpha_3 & test3 
}
\right]
$$
```

