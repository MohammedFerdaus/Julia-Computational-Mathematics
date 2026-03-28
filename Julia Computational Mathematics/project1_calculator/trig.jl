function trig()
    try
        print("Number: ")
        x = parse(Float64, strip(readline()))

        print("Units — [D] Degrees or [R] Radians: ")
        unit = uppercase(strip(readline()))

        println("\n[A] Sine  [B] Cosine  [C] Tangent")
        print("Choice: ")
        op = uppercase(strip(readline()))

        deg = (unit == "D")

        if op == "A"
            if deg
                println("sin($(x)) = $(sind(x))")
            else
                println("sin($(x)) = $(sin(x))")
            end

        elseif op == "B"
            if deg
                println("cos($(x)) = $(cosd(x))")
            else
                println("cos($(x)) = $(cos(x))")
            end

        elseif op == "C"
            if deg
                undefined = abs(x % 180) == 90
            else
                undefined = isapprox(abs(x % π), π/2, atol=1e-10)
            end

            if undefined
                println("Error: tan is undefined at this angle.")
            else
                if deg
                    println("tan($(x)) = $(tand(x))")
                else
                    println("tan($(x)) = $(tan(x))")
                end
            end

        else
            println("Error: Invalid selection.")
        end

    catch
        println("Error: Please enter valid numbers.")
    end
end