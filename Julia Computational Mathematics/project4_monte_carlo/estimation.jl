using Random
using Plots

function estimate_pi(num_samples::Int)
    inside = 0

    for i in 1:num_samples
        x = 2 * rand() - 1
        y = 2 * rand() - 1

        if x^2 + y^2 <= 1.0
            inside += 1
        end
    end

    pi_estimate = 4 * inside / num_samples
    println("Samples: $num_samples  →  π ≈ $pi_estimate")
    return pi_estimate
end

function estimate_triangle(num_samples::Int)
    inside = 0
    for i in 1:num_samples
        x = 2 * rand() - 1
        y = 2 * rand() - 1
        if y >= -1 && y <= 2x + 1 && y <= -2x + 1
            inside += 1
        end
    end
    area_estimate = 4 * inside / num_samples
    println("Samples: $num_samples  →  Triangle area ≈ $area_estimate")
    return area_estimate
end


function estimate_rhombus(num_samples::Int)
    inside = 0
    for i in 1:num_samples
        x = 2 * rand() - 1
        y = 2 * rand() - 1
        if abs(x) + abs(y) <= 1
            inside += 1
        end
    end
    area_estimate = 4 * inside / num_samples
    println("Samples: $num_samples  →  Rhombus area ≈ $area_estimate")
    return area_estimate
end

function plot_estimations(num_samples::Int=5000)
    xs = [2 * rand() - 1 for _ in 1:num_samples]
    ys = [2 * rand() - 1 for _ in 1:num_samples]

    circle_colors = [x^2 + y^2 <= 1 ? :green : :red for (x, y) in zip(xs, ys)]
    p1 = scatter(xs, ys, color = circle_colors, markersize = 1,
                 markerstrokewidth = 0, title="Circle",
                 legend = false, aspect_ratio=:equal)
    theta = range(0, 2π, length=100)
    plot!(p1, cos.(theta), sin.(theta),
          color=:black, linewidth=2)

    triangle_colors = [y >= -1 && y <= 2x+1 && y <= -2x+1 ? :green : :red for (x,y) in zip(xs,ys)]
    p3 = scatter(xs, ys,
        color=triangle_colors, markersize=1, markerstrokewidth=0,
        title="Triangle", legend=false, aspect_ratio=:equal)
    plot!(p3, [-1,1,0,-1], [-1,-1,1,-1], color=:black, linewidth=2)

    rhombus_colors = [abs(x) + abs(y) <= 1 ? :green : :red for (x,y) in zip(xs,ys)]
    p2 = scatter(xs, ys,
        color=rhombus_colors, markersize=1, markerstrokewidth=0,
        title="Rhombus", legend=false, aspect_ratio=:equal)
    plot!(p2, [0,1,0,-1,0], [1,0,-1,0,1], color=:black, linewidth=2)

    final = plot(p1, p2, p3, layout = (1,3), size = (1200, 400),
                 plot_title="Monte Carlo Area Estimation (n=$num_samples)")
    savefig(final, "C:\\julia_projects\\project4_monte_carlo\\plots\\estimations.png")
    println("Saved to plots/estimations.png")
end