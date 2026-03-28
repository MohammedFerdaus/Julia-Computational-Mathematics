using Plots

# 1D Heat Equation
# ∂u/∂t = α * (∂²u/∂x²)
function solve_heat_1D(nx::Int, α::Float64, dt::Float64, num_steps::Int)
    dx = 1.0 / (nx - 1)
    x = collect(range(0, 1, length=nx))
    r = α * dt / dx^2
    if r > 0.5
        println("Warning: scheme may be unstable (r = $r > 0.5)")
    end
    u = sin.(π .* x)
    u[1] = 0.0
    u[end] = 0.0
    snapshots = [copy(u)]
    times = [0.0]
    save_every = max(1, div(num_steps, 5))
    for step in 1:num_steps
        u_new = copy(u)

        for i in 2:(nx-1)
            u_new[i] = u[i] + r * (u[i+1] - 2u[i] + u[i-1])
        end
        u_new[1] = 0.0
        u_new[end] = 0.0
        u = u_new
        if step % save_every == 0
            push!(snapshots, copy(u))
            push!(times, step * dt)
        end
    end
    return x, snapshots, times
end

function plot_heat_1D(x, snapshots, times, filename="C:\\julia_projects\\project5_pde\\plots\\heat_1d.png")
    plt = plot()
    for i in 1:length(snapshots)
        plot!(plt, x, snapshots[i],
            label="t = $(round(times[i], digits=3))")
    end
    title!(plt, "1D Heat Equation")
    xlabel!(plt, "Position (x)")
    ylabel!(plt, "Temperature u(x)")
    savefig(plt, filename)
    println("Saved to $filename")
end


# 1D Wave Equation
# ∂²u/∂t² = c² * (∂²u/∂x²)
function solve_wave_1D(nx::Int, c::Float64, dt::Float64, num_steps::Int)
    dx = 1 / (nx - 1)
    x = collect(range(0, 1, length=nx))
    r = c * dt / dx
    if r > 1
        println("Warning: scheme unstable (r = $r > 1)")
    end
    u_prev = sin.(π .* x)
    u_curr = copy(u_prev)
    u_prev[1] = u_prev[end] = 0
    u_curr[1] = u_curr[end] = 0
    snapshots = [copy(u_curr)]
    times = [0.0]
    save_every = max(1, div(num_steps, 5))
    for step in 1:num_steps
        u_next = copy(u_curr)
        for i in 2:(nx-1)
            u_next[i] = 2u_curr[i] - u_prev[i] +
                        r^2 * (u_curr[i+1] - 2u_curr[i] + u_curr[i-1])
        end
        u_next[1] = 0
        u_next[end] = 0
        u_prev = u_curr
        u_curr = u_next
        if step % save_every == 0
            push!(snapshots, copy(u_curr))
            push!(times, step * dt)
        end
    end
    return x, snapshots, times
end

function plot_wave_1D(x, snapshots, time, filename="C:\\julia_projects\\project5_pde\\plots\\wave_1d.png")

end

# 1D Laplace Equation
# ∂²u/∂x² = 0
function solve_laplace_1D(nx::Int, ua::Float64, ub::Float64)
    x = range(0, stop=1, length=nx)
    u = zeros(nx)
    u[1] = ua
    u[end] = ub
    for i in 2:nx-1
        u[i] = ua + (ub - ua) * x[i]
    end
    return collect(x), u
end

function plot_laplace_1D(x, u, filename="C:\\julia_projects\\project5_pde\\plots\\laplace_1d.png")
    plot(x, u,
        title="1D Laplace Equation",
        xlabel="Position (x)",
        ylabel="u(x)",
        linewidth=2,
        label="Solution",
        color=:blue)

    scatter!([x[1], x[end]], [u[1], u[end]],
        color=:red,
        markersize=8,
        label="Boundary points")

    savefig(filename)
    println("Saved to $filename")
end