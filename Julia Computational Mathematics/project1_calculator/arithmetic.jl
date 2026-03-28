function arithmetic()
    try
        print("First number: ")
        a = parse(Float64, strip(readline()))

        print("Second number: ")
        b = parse(Float64, strip(readline()))

        println("\n[A] Addition")
        println("[B] Subtraction")
        println("[C] Multiplication")
        println("[D] Division")
        println("[E] Exponentiation")
        print("Operation: ")
        op = uppercase(strip(readline()))

        if op == "A"
            println("Result: $(a + b)")
        elseif op == "B"
            println("Result: $(a - b)")
        elseif op == "C"
            println("Result: $(a * b)")
        elseif op == "D"
            if b == 0
                println("Error: Division by zero is undefined.")
            else
                println("Result: $(a / b)")
            end
        elseif op == "E"
            println("Result: $(a ^ b)")
        else
            println("Error: Invalid operation.")
        end

    catch
        println("Error: Please enter valid numbers.")
    end
end