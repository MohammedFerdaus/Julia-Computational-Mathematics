function exponentials()
    try
        print("Exponent (x): ")
        x = parse(Float64, strip(readline()))

        println("\n[A] e^x  [B] a^x  [C] 10^x")
        print("Choice: ")
        op = uppercase(strip(readline()))

        if op == "A"
            println("e^$(x) = $(exp(x))")

        elseif op == "B"
            print("Base (a): ")
            a = parse(Float64, strip(readline()))
            if a < 0 && x != floor(x)
                println("Error: Negative base with fractional exponent is undefined.")
            else
                println("$(a)^$(x) = $(a ^ x)")
            end

        elseif op == "C"
            println("10^$(x) = $(10 ^ x)")

        else
            println("Error: Invalid selection.")
        end

    catch
        println("Error: Please enter valid numbers.")
    end
end