function logarithms()
    try
        print("Number (> 0): ")
        x = parse(Float64, strip(readline()))

        if x <= 0
            println("Error: Logarithms are only defined for numbers greater than 0.")
            return
        end

        println("\n[A] ln(x)  [B] log10(x)  [C] log_N(x)")
        print("Choice: ")
        op = uppercase(strip(readline()))

        if op == "A"
            println("ln($(x)) = $(log(x))")
        elseif op == "B"
            println("log10($(x)) = $(log10(x))")
        elseif op == "C"
            print("Base (> 0, not 1): ")
            base = parse(Float64, strip(readline()))
            if base <= 0 || base == 1
                println("Error: Base must be positive and cannot be 1.")
            else
                println("log_$(base)($(x)) = $(log(base, x))")
            end
        else
            println("Error: Invalid selection.")
        end

    catch
        println("Error: Please enter valid numbers.")
    end
end