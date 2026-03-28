function bisection(f, a::Float64, b::Float64; tol=1e-6, max_iter=100)
    if f(a) * f(b) >= 0
        error("No sign change in [a, b] — root not guaranteed in this interval")
    end
    c = a
    for iter in 1:max_iter
        c = (a + b) / 2.0
        if abs(f(c)) < tol
            println("Converged in $iter iterations")
            return c
        end
        if f(c) * f(a) < 0
            b = c
        else
            a = c
        end
    end
    println("Warning: reached max iterations, returning best estimate")
    return c
end

function newton(f, df, x0::Float64; tol=1e-6, max_iter=100)
    x = x0
    for iter in 1:max_iter
        if abs(df(x)) < 1e-10
            error("Derivative is zero — Newton's method fails here")
        end
        next_x = x - f(x) / df(x)
        if abs(f(next_x)) < tol
            println("Converged in $iter iterations")
            return next_x
        end
        x = next_x
    end
    println("Warning: reached max iterations, returning best estimate")
    return x
end

function secant(f, x0::Float64, x1::Float64; tol=1e-6, max_iter=100)
    for iter in 1:max_iter
        if abs(f(x1) - f(x0)) < 1e-10
            error("Denominator is zero — secant method fails here")
        end
        next_x = x1 - f(x1) * (x1 - x0) / (f(x1) - f(x0))
        if abs(f(next_x)) < tol
            println("Converged in $iter iterations")
            return next_x
        end
        x0 = x1
        x1 = next_x
    end
    println("Warning: reached max iterations, returning best estimate")
    return x1
end