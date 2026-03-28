function memory(mem::Memory)
    try
        println("\n[A] Store  [B] Recall  [C] Clear")
        print("Choice: ")
        op = uppercase(strip(readline()))

        if op == "A"
            print("Value to store: ")
            mem.value    = parse(Float64, strip(readline()))
            mem.active   = true
            println("Stored $(mem.value) in memory.")

        elseif op == "B"
            if mem.active
                println("Memory: $(mem.value)")
            else
                println("Memory is empty.")
            end

        elseif op == "C"
            mem.value  = 0.0
            mem.active = false
            println("Memory cleared.")

        else
            println("Error: Invalid selection.")
        end

    catch
        println("Error: Please enter a valid number.")
    end
end