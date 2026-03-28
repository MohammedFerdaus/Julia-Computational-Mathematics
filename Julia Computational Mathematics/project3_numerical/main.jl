include("rootfinding.jl")
include("integration.jl")
include("differentiation.jl")
include("differentials.jl")

# Test Functions
f1(x) = x^2 - 4 # roots at x = ±2
f1_prime(x) = 2x # derivative of f1
f2(x) = sin(x) # root at x = π
f3(x) = exp(x) - 2 # root at x = ln(2) ≈ 0.693
f4(x) = x^2 # integral 0→1 = 0.333, derivative at x=3 is 6.0
ode1(t, y) = -y # dy/dt = -y, true solution e^(-t)
ode2(t, y) = y # dy/dt = y,  true solution e^t
fdm1(x) = 0.0 # y'' = 0, solution is straight line

# Root Finding Tests
println("Bisection x²-4 on [0,3]:     ", bisection(f1, 0.0, 3.0))
println("Newton x²-4 from x=1.0:   ", newton(f1, f1_prime, 1.0))
println("Secant x²-4 from [0,3]:   ", secant(f1, 0.0, 3.0))

println("\nBisection sin(x) on [2,4]:   ", bisection(f2, 2.0, 4.0))
println("Newton sin(x) from x=2.0: ", newton(f2, cos, 2.0))
println("Secant sin(x) on [2,4]:   ", secant(f2, 2.0, 4.0))

println("\nBisection  e^x-2 on [0,2]:    ", bisection(f3, 0.0, 2.0))
println("True       ln(2):              ", log(2))

# Integration Tests
println("Trapezoid ∫x² from 0→1:      ", trapezoid(f4, 0.0, 1.0, 1000))
println("Simpson ∫x² from 0→1:      ", simpson(f4, 0.0, 1.0, 1000))
println("Adaptive ∫x² from 0→1:      ", adaptive_simpson(f4, 0.0, 1.0))
println("True value 1/3:                ", 1/3)

println("\nTrapezoid ∫sin(x) from 0→π:  ", trapezoid(f2, 0.0, Float64(π), 1000))
println("Adaptive ∫sin(x) from 0→π:  ", adaptive_simpson(f2, 0.0, Float64(π)))
println("True value 2.0:                ", 2.0)

# Differentiation Tests
println("Forward f'(3) for x²:       ", forward_diff(f4, 3.0))
println("Central f'(3) for x²:       ", central_diff(f4, 3.0))
println("Second f''(3) for x²:      ", second_derivative(f4, 3.0))
println("True value f'(3) = 6.0, f''= 2.0")

# Differentials Tests
t_euler, y_euler = euler(ode1, 0.0, 1.0, 1.0, 0.1)
t_rk4,   y_rk4   = rk4(ode1, 0.0, 1.0, 1.0, 0.1)

println("Euler y(1) for dy/dt=-y:  ", y_euler[end])
println("RK4 y(1) for dy/dt=-y:  ", y_rk4[end])
println("True value e^(-1):             ", exp(-1.0))

x_fdm, y_fdm = fdm(fdm1, 0.0, 1.0, 0.0, 1.0, 10)
println("\nFDM solution y''=0, y(0)=0, y(1)=1:")
for i in 1:length(x_fdm)
    println("  x = $(round(x_fdm[i], digits=2))   y = $(round(y_fdm[i], digits=4))")
end