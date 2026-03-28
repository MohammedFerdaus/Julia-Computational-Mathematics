function forward_diff(f, x::Float64; h=1e-5)
    return (f(x+h) - f(x)) / h
end

function central_diff(f, x::Float64; h=1e-5)
    return (f(x+h) - f(x-h)) / (2*h)
end

function second_derivative(f, x::Float64; h=1e-5)
    return (f(x+h) - 2*f(x) + f(x-h)) / h^2
end