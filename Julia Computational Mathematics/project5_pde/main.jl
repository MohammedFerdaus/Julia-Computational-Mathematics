include("equations_1D.jl")
include("equations_2D.jl")

println("1D Equations Tests:")

# 1D heat tests
# stable run
x, snapshots, times = solve_heat_1D(50, 0.1, 0.001, 500)
plot_heat_1D(x, snapshots, times)

# unstable run
x2, snapshots2, times2 = solve_heat_1D(50, 0.1, 0.1, 100)
plot_heat_1D(x2, snapshots2, times2, "C:\\julia_projects\\project5_pde\\plots\\heat_1d_unstable.png")

# 1D wave tests
x, snapshots, times = solve_wave_1D(100, 1.0, 0.005, 1000)
plot_wave_1D(x, snapshots, times)

# 1D laplace tests
x, u = solve_laplace_1D(100, 0.0, 1.0)
plot_laplace_1D(x, u)

println("2D Equations Tests:")

# 2D heat tests
x, y, snapshots, times = solve_heat_2D(50, 50, 0.1, 0.001, 500)
plot_heat_2D(x, y, snapshots, times)

# 2D wave tests
x, y, snapshots, times = solve_wave_2D(50, 50, 1.0, 0.005, 400)
plot_wave_2D(x, y, snapshots, times)

# 2D laplace tests
x, y, u = solve_laplace_2D(50, 50)
plot_laplace_2D(x, y, u)
