using Plots

# 2D Heat Equation
# ∂u/∂t = α * (∂²u/∂x² + ∂²u/∂y²)
function solve_heat_2D(nx::Int, ny::Int, α::Float64, dt::Float64, num_steps::Int)
    x = range(0, stop=1, length=nx)
    y = range(0, stop=1, length=ny)
    dx = 1.0 / (nx - 1)
    dy = 1.0 / (ny - 1)
    rx = α * dt / dx^2
    ry = α * dt / dy^2
    if rx + ry > 0.5
        println("Warning: scheme may be unstable (rx + ry = $(rx + ry))")
    end
    u = zeros(nx, ny)
    for i in 1:nx
        for j in 1:ny
            u[i,j] = exp(-((x[i]-0.5)^2 + (y[j]-0.5)^2) / 0.01)
        end
    end
    u[1, :]   .= 0.0
    u[end, :] .= 0.0
    u[:, 1]   .= 0.0
    u[:, end] .= 0.0
    snapshots = [copy(u)]
    times = [0.0]
    save_every = max(1, div(num_steps, 4))
    for n in 1:num_steps
        u_new = copy(u)
        for i in 2:nx-1
            for j in 2:ny-1
                u_new[i,j] = u[i,j] +
                    rx * (u[i+1,j] - 2u[i,j] + u[i-1,j]) +
                    ry * (u[i,j+1] - 2u[i,j] + u[i,j-1])
            end
        end
        u_new[1, :]   .= 0.0
        u_new[end, :] .= 0.0
        u_new[:, 1]   .= 0.0
        u_new[:, end] .= 0.0
        u = u_new
        if n % save_every == 0
            push!(snapshots, copy(u))
            push!(times, n * dt)
        end
    end
    return collect(x), collect(y), snapshots, times
end

function plot_heat_2D(x, y, snapshots, times, filename="C:\\julia_projects\\project5_pde\\plots\\heat_2d.png")
    n = min(4, length(snapshots))
    plots = []
    for i in 1:n
        p = heatmap(x, y, snapshots[i]',
            title="t = $(round(times[i], digits=3))",
            xlabel="x", ylabel="y",
            color=:hot, clims=(0, 1))
        push!(plots, p)
    end
    final = plot(plots..., layout=(2,2), size=(900, 800))
    savefig(final, filename)
    println("Saved to $filename")
end

# 2D Wave Equation
# ∂²u/∂t² = c² * (∂²u/∂x² + ∂²u/∂y²)
function solve_wave_2D(nx::Int, ny::Int, c::Float64, dt::Float64, num_steps::Int)
    x = range(0, stop=1, length=nx)
    y = range(0, stop=1, length=ny)
    dx = 1.0 / (nx - 1)
    dy = 1.0 / (ny - 1)
    r2 = (c * dt)^2 * (1/dx^2 + 1/dy^2)
    if r2 > 1
        println("Warning: scheme may be unstable (r² = $r2 > 1)")
    end
    u_prev = zeros(nx, ny)
    u = zeros(nx, ny)
    u_next = zeros(nx, ny)
    for i in 1:nx
        for j in 1:ny
            u[i,j] = exp(-50 * ((x[i]-0.5)^2 + (y[j]-0.5)^2))
        end
    end
    u_prev .= u
    snapshots = [copy(u)]
    times = [0.0]
    save_every = max(1, div(num_steps, 4))
    for n in 1:num_steps
        for i in 2:nx-1
            for j in 2:ny-1
                u_next[i,j] = 2u[i,j] - u_prev[i,j] +
                    (c*dt)^2 * (
                        (u[i+1,j] - 2u[i,j] + u[i-1,j]) / dx^2 +
                        (u[i,j+1] - 2u[i,j] + u[i,j-1]) / dy^2
                    )
            end
        end
        u_next[1, :]   .= 0.0
        u_next[end, :] .= 0.0
        u_next[:, 1]   .= 0.0
        u_next[:, end] .= 0.0
        u_prev .= u
        u .= u_next
        if n % save_every == 0
            push!(snapshots, copy(u))
            push!(times, n * dt)
        end
    end

    return collect(x), collect(y), snapshots, times
end

function plot_wave_2D(x, y, snapshots, times, filename="C:\\julia_projects\\project5_pde\\plots\\wave_2d.png")
    n = min(4, length(snapshots))
    plots = []
    for i in 1:n
        p = heatmap(x, y, snapshots[i]',
            title="t = $(round(times[i], digits=3))",
            xlabel="x", ylabel="y",
            color=:RdBu, clims=(-1, 1))
        push!(plots, p)
    end
    final = plot(plots..., layout=(2,2), size=(900, 800))
    savefig(final, filename)
    println("Saved to $filename")
end


# 2D Laplace Equation
# ∂²u/∂x² + ∂²u/∂y² = 0
function solve_laplace_2D(nx::Int, ny::Int; max_iter=10000, tol=1e-6)
    x = range(0, stop=1, length=nx)
    y = range(0, stop=1, length=ny)
    u = zeros(nx, ny)
    for i in 1:nx
        u[i, 1] = 0.0
        u[i, end] = sin(pi * x[i])
    end
    for j in 1:ny
        u[1, j] = 0.0
        u[end, j] = 0.0
    end
    for iter in 1:max_iter
        u_new = copy(u)
        for i in 2:nx-1
            for j in 2:ny-1
                u_new[i, j] = 0.25 * (
                    u[i+1, j] + u[i-1, j] +
                    u[i, j+1] + u[i, j-1]
                )
            end
        end
        for i in 1:nx
            u_new[i, 1] = 0.0
            u_new[i, end] = sin(pi * x[i])
        end
        for j in 1:ny
            u_new[1, j] = 0.0
            u_new[end, j] = 0.0
        end
        diff = maximum(abs.(u_new .- u))
        if diff < tol
            println("Converged in $iter iterations")
            return x, y, u_new
        end
        u = u_new
    end
    println("Reached max iterations")
    return x, y, u
end

function plot_laplace_2D(x, y, u, filename="C:\\julia_projects\\project5_pde\\plots\\laplace_2d.png")
    p1 = heatmap(x, y, u',
        title="2D Laplace — Heatmap",
        xlabel="x", ylabel="y",
        color=:hot)
    p2 = contour(x, y, u',
        title="2D Laplace — Contours",
        xlabel="x", ylabel="y",
        color=:viridis, fill=true)
    final = plot(p1, p2, layout=(1,2), size=(1000, 400))
    savefig(final, filename)
    println("Saved to $filename")
end
