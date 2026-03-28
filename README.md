# Julia Computational Mathematics

A collection of computational mathematics projects built to develop applied Julia skills across numerical methods, simulation, linear algebra, and differential equations. Each subfolder is a standalone project covering a different area of computational mathematics and scientific programming.

---

## Repository Structure

```
julia-scientific-computing/
├── project1_calculator/
│   ├── main.jl
│   ├── arithmetic.jl
│   ├── roots.jl
│   ├── trig.jl
│   ├── logarithms.jl
│   ├── exponentials.jl
│   └── memory.jl
├── project2_matrix/
│   ├── main.jl
│   └── matrix.jl
├── project3_numerical/
│   ├── main.jl
│   ├── rootfinding.jl
│   ├── integration.jl
│   ├── differentiation.jl
│   └── differentials.jl
├── project4_monte_carlo/
│   ├── main.jl
│   ├── estimation.jl
│   ├── random_walk.jl
│   ├── option_pricing.jl
│   ├── markov.jl
│   └── plots/
└── project5_pde/
    ├── main.jl
    ├── equations_1d.jl
    ├── equations_2d.jl
    └── plots/
```

---

## Projects

### Project 1 — Scientific Calculator

A modular, menu-driven scientific calculator split across six focused files. Covers arithmetic, roots (square, cube, nth), trigonometry (sin, cos, tan in degrees or radians), logarithms (natural, base 10, any base), exponentials, and a persistent memory system using a mutable struct. Full input validation and error handling on every operation.

**Key Julia concepts:** mutable structs, multi-file projects with `include()`, try/catch error handling, string interpolation, Julia's built-in math functions.

---

### Project 2 — Matrix Library

A linear algebra library built from scratch without using Julia's `LinearAlgebra` stdlib. Implements a custom `Mat` struct with operator overloading for `+`, `-`, and `*` using multiple dispatch. Includes static factory functions (identity, zeros, ones), transpose, and three bonus algorithms: determinant via cofactor expansion, matrix inverse via Gaussian elimination with partial pivoting, and a linear system solver for Ax=b.

**Key Julia concepts:** mutable structs, multiple dispatch, operator overloading via `Base.:+`, recursive algorithms, Gaussian elimination.

---

### Project 3 — Numerical Methods Library

A comprehensive numerical methods library across four files. Covers root finding (bisection, Newton's method, secant method), numerical integration (trapezoidal rule, Simpson's rule, adaptive Simpson), numerical differentiation (forward difference, central difference, second derivative), and ODE solvers (Euler's method, RK4, basic FDM). All methods tested against known analytical solutions with convergence tracking.

**Key Julia concepts:** first-class functions, keyword arguments, anonymous functions, broadcasting, recursive functions.

---

### Project 4 — Monte Carlo Simulator

A Monte Carlo simulation suite with five components. Estimates π and areas of geometric shapes (circle, rhombus, triangle) with visual scatter plots. Simulates 1D and 2D random walks with path visualization and multi-walk distance comparison plots. Prices European call and put options using geometric Brownian motion and compares results to the analytical Black-Scholes formula. Models discrete Markov chains with transition matrices, steady-state distribution computation, and bar chart visualization.

**Key Julia concepts:** `Random` stdlib, `Plots.jl`, `SpecialFunctions.jl`, `Statistics` stdlib, mutable structs with `!` convention, animated plots.

---

### Project 5 — PDE Solver

A partial differential equation solver covering all three classical PDEs in both 1D and 2D. Implements explicit finite difference schemes for the 1D and 2D heat equations (with CFL stability analysis and instability demonstration), 1D and 2D wave equations (three-level time stepping), and 1D and 2D Laplace equations (Jacobi iteration to convergence). All 2D solutions visualized as heatmaps with time snapshots; 1D solutions plotted as multi-snapshot overlays.

**Key Julia concepts:** 2D array operations, broadcasting with `.=`, nested loops, convergence criteria, `heatmap` and `contour` plots, stability analysis.

---

## Stack

| Area | Libraries |
|---|---|
| Visualization | Plots.jl (GR backend) |
| Special Functions | SpecialFunctions.jl |
| Statistics | Statistics (stdlib) |
| Random | Random (stdlib) |
| Core | Julia 1.12.5 standard library |

---

## How to Run

**Requirements:** Julia 1.12.5, VS Code with Julia extension

**Install dependencies:**
```julia
using Pkg
Pkg.add("Plots")
Pkg.add("SpecialFunctions")
```

**Run any project:**
```
julia project1_calculator/main.jl
julia project2_matrix/main.jl
julia project3_numerical/main.jl
julia project4_monte_carlo/main.jl
julia project5_pde/main.jl
```

---

## Notes

All projects were written and tested in Julia 1.12.5 on Windows 10 with VS Code and the Julia extension. Written entirely from scratch with no starter code — each project was built incrementally, function by function, with full understanding of the underlying mathematics before implementation. This repository represents a scientific computing foundation series built with a long-term focus on computational materials discovery using SciML and physics-informed neural networks.
