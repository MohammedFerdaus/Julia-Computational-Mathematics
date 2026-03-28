function trapezoid(f, a::Float64, b::Float64, n::Int)
    h = (b - a) / n
    total = f(a)/2 + f(b)/2
    for i in 1:(n-1)
        total += f(a + i*h)
    end
    return h * total
end

function simpson(f, a::Float64, b::Float64, n::Int)
    if n % 2 != 0
        error("Interval steps must be even")
    end
    h = (b - a) / n
    total = f(a) + f(b)
    for i in 1:(n-1)
        if i % 2 == 0
            total += 2 * f(a + i * h)
        else
            total += 4 * f(a + i * h)
        end
    end
    return (h / 3) * total
end

function adaptive_simpson(f, a::Float64, b::Float64; tol=1e-6)
    mid = (a + b) / 2.0
    whole = simpson(f, a, b, 2)
    left  = simpson(f, a, mid, 2)
    right = simpson(f, mid, b, 2)
    if abs(left + right - whole) < tol
        return left + right
    else
        return adaptive_simpson(f, a, mid; tol=tol/2) +
        adaptive_simpson(f, mid, b; tol=tol/2)
    end
end