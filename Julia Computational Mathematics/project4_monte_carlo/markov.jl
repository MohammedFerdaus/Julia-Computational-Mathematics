# Markov Chain Simulation

function simulate_markov(transition_matrix::Array{Float64,2}, start_state::Int, num_steps::Int)
    states = [start_state]
    current_state = start_state

    for step in 1:num_steps
        probs = transition_matrix[current_state, :]
        r = rand()
        cumulative_sum = 0.0
        next_state = current_state

        for i in 1:length(probs)
            cumulative_sum += probs[i]
            if r <= cumulative_sum
                next_state = i
                break
            end
        end

        push!(states, next_state)
        current_state = next_state
    end

    return states
end

function steady_state(transition_matrix::Array{Float64,2}; num_steps::Int=100000)
    num_states = size(transition_matrix, 1)
    counter = zeros(Int, num_states)
    states = simulate_markov(transition_matrix, 1, num_steps)
    for state in states
        counter[state] += 1
    end
    distribution = counter ./ num_steps
    return distribution
end

function plot_markov_chain(states::Vector{Int}, state_names::Vector{String},
                           filename::String="C:\\julia_projects\\project4_monte_carlo\\plots\\markov_chain.png")
    plot(1:length(states), states,
        linetype=:steppost,
        title="Markov Chain State Sequence",
        xlabel="Step",
        ylabel="State",
        yticks=(1:length(state_names), state_names),
        legend=false,
        linewidth=2)
    savefig(filename)
    println("Saved to $filename")
end

function plot_steady_state(distribution::Vector{Float64}, state_names::Vector{String},
                           filename::String="C:\\julia_projects\\project4_monte_carlo\\plots\\markov_steady.png")
    bar(state_names, distribution,
        title="Steady State Distribution",
        xlabel="State",
        ylabel="Probability",
        ylims=(0, 1),
        legend=false,
        color=:steelblue)
    savefig(filename)
    println("Saved to $filename")
end