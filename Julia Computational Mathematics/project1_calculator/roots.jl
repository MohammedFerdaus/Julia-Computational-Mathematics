function roots()
    try
        println("\n[A] Square Root  [B] Cube Root  [C] Nth Root")
        print("Choice: ")
        op = uppercase(strip(readline()))

        if op == "A"
            print("Number (>= 0): ")
            x = parse(Float64, strip(readline()))
            if x < 0
                println("Error: Square root of a negative number is undefined.")
            else
                println("sqrt($(x)) = $(sqrt(x))")
            end

        elseif op == "B"
            print("Number: ")
            x = parse(Float64, strip(readline()))
            println("cbrt($(x)) = $(cbrt(x))")

        elseif op == "C"
            print("Number: ")
            x = parse(Float64, strip(readline()))
            print("Root (n): ")
            n = parse(Float64, strip(readline()))
            if n == 0
                println("Error: 0th root is undefined.")
            else
                println("$(x)^(1/$(n)) = $(x ^ (1/n))")
            end

        else
            println("Error: Invalid selection.")
        end

    catch
        println("Error: Please enter valid numbers.")
    end
end