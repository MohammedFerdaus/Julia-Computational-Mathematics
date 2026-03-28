mutable struct Memory
    value::Float64
    active::Bool
end

Memory() = Memory(0.0, false)

include("arithmetic.jl")
include("roots.jl")
include("trig.jl")
include("logarithms.jl")
include("exponentials.jl")
include("memory.jl")

function show_menu()
    println("Scientific Calculator  ")
    println("[1] Arithmetic  (+, -, *, /, ^)")
    println("[2] Roots       (sqrt, cbrt, nth)")
    println("[3] Trigonometry (sin, cos, tan)")
    println("[4] Logarithms  (ln, log10, logN)")
    println("[5] Exponentials (e^x, a^x, 10^x)")
    println("[6] Memory      (store, recall, clear)")
    println("[7] Exit")
    print("Choice: ")
end

function main()
    mem = Memory()

    while true
        show_menu()
        input = readline()

        try
            choice = parse(Int, strip(input))

            if choice == 1
                arithmetic()
            elseif choice == 2
                roots()
            elseif choice == 3
                trig()
            elseif choice == 4
                logarithms()
            elseif choice == 5
                exponentials()
            elseif choice == 6
                memory(mem)
            elseif choice == 7
                println("Goodbye!")
                break
            else
                println("Invalid choice — enter [1-7]")
            end

        catch
            println("Invalid input — enter a number [1-7]")
        end
    end
end

main()