using Plots

# 2D Heat Equation
# ∂u/∂t = α * (∂²u/∂x² + ∂²u/∂y²)
function solve_heat_2D(nx::Int, ny::Int, α::Float64, dt::Float64, num_steps::Int)

end

function plot_heat_2d(u, step, filename="C:\\julia_projects\\project5_pde\\plots\\heat_2d.png")

end

# 2D Wave Equation
# ∂²u/∂t² = c² * (∂²u/∂x² + ∂²u/∂y²)
function solve_wave_2D(nx::Int, ny::Int, c::Float64, dt::Float64, num_steps::Int)

end

function plot_wave_2D(u, step, filename="C:\\julia_projects\\project5_pde\\plots\\wave_2d.png")

end

# 2D Laplace Equation
# ∂²u/∂x² + ∂²u/∂y² = 0
function solve_laplace_2d(nx::Int, ny::Int; max_iter=10000, tol=1e-6)

end

function plot_laplace_2d(u, filename="C:\\julia_projects\\project5_pde\\plots\\laplace_2d.png")

end
