using Plots
using Statistics

# Random Walk Simulation
mutable struct RandomWalk
    dims::Int
    position::Vector{Float64}
    path::Vector{Vector{Float64}}
end

RandomWalk(dims::Int) = RandomWalk(dims, zeros(Float64, dims), [zeros(Float64, dims)])

# Simulate the walk
function simulate!(walk::RandomWalk, num_steps::Int)
    for i in 1:num_steps
        step = randn(walk.dims)
        step = step / sqrt(sum(step .^ 2))
        walk.position = walk.position + step
        push!(walk.path, copy(walk.position))
    end
end

# Distance from origin
function distance_from_origin(walk::RandomWalk)
    distance = sqrt(sum(walk.position .^ 2))
end

# Reset walk back to origin
function reset!(walk::RandomWalk)
    walk.position = zeros(Float64, walk.dims)
    walk.path = [zeros(Float64, walk.dims)]
end

# Run multiple walks and return final distances
function run_multiple_walks(dims::Int, num_steps::Int, num_walks::Int)
    distances = Float64[]
    for i in 1:num_walks
        walk = RandomWalk(dims)
        simulate!(walk, num_steps)
        push!(distances, distance_from_origin(walk))
    end
    return distances
end

# Plot a 1D random walk — position vs time
function plot_1d_walk(walk::RandomWalk, filename::String="C:\\julia_projects\\project4_monte_carlo\\plots\\walk_1d.png")
    y_vals = [step[1] for step in walk.path]
    x_vals = 1:length(y_vals)

    plot(x_vals, y_vals,
        title = "1D Random Walk",
        xlabel = "Step",
        ylabel = "Position",
        label = "Walk",
        linewidth = 1)

    hline!([0.0], color=:red, linestyle=:dash, label="Origin")
    savefig(filename)
    println("Saved to $filename")
end

# Plot a 2D random walk — x vs y path
function plot_2d_walk(walk::RandomWalk, filename::String="C:\\julia_projects\\project4_monte_carlo\\plots\\walk_2d.png")
    x_vals = [step[1] for step in walk.path]
    y_vals = [step[2] for step in walk.path]

    plot(x_vals, y_vals,
        title = "2D Random Walk",
        xlabel = "X",
        ylabel = "Y",
        label = "Path",
        linewidth = 0.5,
        alpha = 0.7)

    scatter!([x_vals[1]], [y_vals[1]], color=:green, label="Start", markersize=6)
    scatter!([x_vals[end]], [y_vals[end]], color=:red, label="End", markersize=6)

    savefig(filename)
    println("Saved to $filename")
end

# Plot distance from origin over time for multiple walks
function plot_distance_comparison(num_steps::Int, num_walks::Int, filename::String="C:\\julia_projects\\project4_monte_carlo\\plots\\walk_distances.png")
    p = plot(title="Random Walk Distances from Origin",
             xlabel="Step", ylabel="Distance",
             legend=false, alpha=0.4)

    for i in 1:num_walks
        walk = RandomWalk(2)
        simulate!(walk, num_steps)
        distances = [sqrt(sum(pos .^ 2)) for pos in walk.path]
        plot!(p, 1:length(distances), distances,
              alpha=0.3, color=:blue)
    end

    plot!(p, 1:num_steps, sqrt.(1:num_steps),
          color=:red, linewidth=2, label="sqrtn theoratical")

    savefig(filename)
    println("Saved to $filename")
end