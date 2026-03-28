include("estimation.jl")
include("random_walk.jl")
include("options_pricing.jl")
include("Markov.jl")

using Random
using Statistics

estimate_pi(10000000)
println("True π = ", Float64(π))

estimate_triangle(100000)

estimate_rhombus(100000)

plot_estimations(5000)

walk = RandomWalk(2)
simulate!(walk, 1000)
println("Distance from origin after 1000 steps: ", distance_from_origin(walk))
println("Expected ~√1000 = ", sqrt(1000))

reset!(walk)
println("After reset, position: ", walk.position)

distances = run_multiple_walks(2, 1000, 100)
println("Mean distance over 100 walks: ", sum(distances)/length(distances))
println("Expected ~√1000 = ", sqrt(1000))

step = randn(2)
println("Before normalize: ", step, " length: ", sqrt(sum(step .^ 2)))
step = step / sqrt(sum(step .^ 2))
println("After normalize:  ", step, " length: ", sqrt(sum(step .^ 2)))

walk_1d = RandomWalk(1)
simulate!(walk_1d, 1000)
plot_1d_walk(walk_1d)

walk_2d = RandomWalk(2)
simulate!(walk_2d, 5000)
plot_2d_walk(walk_2d)

plot_distance_comparison(1000, 20)

mc_price   = black_scholes_mc(100.0, 105.0, 1.0, 0.05, 0.2, 100000)
analytical = black_scholes_analytical(100.0, 105.0, 1.0, 0.05, 0.2)

println("MC price:         ", mc_price)
println("Analytical price: ", analytical)
println("Error:            ", abs(mc_price - analytical))

# weather transition matrix
# define these first
weather = [0.7 0.2 0.1;
           0.3 0.4 0.3;
           0.2 0.3 0.5]

state_names = ["Sunny", "Cloudy", "Rainy"]

# then use them
states = simulate_markov(weather, 1, 100)
dist = steady_state(weather)

println("State sequence: ", states)
println("Steady state: ", dist)
println("Should sum to 1.0: ", sum(dist))

plot_markov_chain(states, state_names)
plot_steady_state(dist, state_names)