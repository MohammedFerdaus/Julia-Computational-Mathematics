function euler(f, t0::Float64, y0::Float64, t_end::Float64, h::Float64)
    t = t0
    y = y0
    t_vals = [t0]
    y_vals = [y0]
    while t < t_end
        y = y + h * f(t, y)
        t = t + h
        push!(t_vals, t)
        push!(y_vals, y)
    end
    return t_vals, y_vals
end

function rk4(f, t0::Float64, y0::Float64, t_end::Float64, h::Float64)
    t = t0
    y = y0
    t_vals = [t0]
    y_vals = [y0]
    while t < t_end - h/2
        k1 = f(t, y)
        k2 = f(t + h/2, y + h/2 * k1)
        k3 = f(t + h/2, y + h/2 * k2)
        k4 = f(t + h,   y + h * k3)
        y = y + (h/6.0) * (k1 + 2*k2 + 2*k3 + k4)
        t = t + h
        push!(y_vals, y)
        push!(t_vals, t)
    end
    return t_vals, y_vals
end

function fdm(f, a::Float64, b::Float64, ya::Float64, yb::Float64, n::Int)
    h = (b - a) / n
    x = [a + i*h for i in 0:n]
    y = zeros(Float64, n+1)
    y[1] = ya
    y[n+1] = yb
    for i in 2:n
        y[i] = ya + (yb - ya) * (x[i] - a) / (b - a)
    end
    return x, y
end