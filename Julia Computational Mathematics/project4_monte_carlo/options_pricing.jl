using SpecialFunctions

function black_scholes_mc(S0::Float64, K::Float64, T::Float64,
                          r::Float64, sigma::Float64,
                          num_paths::Int; is_call=true)
    payoffs = Float64[]
    for i in 1:num_paths
        Z = randn()
        S_T = S0 * exp((r - sigma^2/2)*T + sigma*sqrt(T)*Z)
        if is_call
            payoff = max(S_T - K, 0.0)
        else
            payoff = max(K - S_T, 0.0)
        end
        push!(payoffs, payoff)
    end
    price = exp(-r*T) * sum(payoffs)/num_paths
    return price
end

function black_scholes_analytical(S0::Float64, K::Float64, T::Float64,
                                   r::Float64, sigma::Float64; is_call=true)
    d1 = (log(S0/K) + (r + sigma^2/2)*T) / (sigma*sqrt(T))
    d2 = d1 - sigma*sqrt(T)
    N(x) = 0.5 * erfc(-x/sqrt(2))
    if is_call
        return S0 * N(d1) - K * exp(-r*T) * N(d2)
    else
        return K * exp(-r*T) * N(-d2) - S0 * N(-d1)
    end
end