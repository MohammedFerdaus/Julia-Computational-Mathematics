include("matrix.jl")

A = Mat([1 2; 3 4])
B = Mat([5 6; 7 8])
println("A + B:")
print_Mat(A + B)

println("A - B:")
print_Mat(A - B)

println("A * B:")
print_Mat(A * B)

println("A * 2.0:")
print_Mat(A * 2.0)

println("A * 2:")
print_Mat(A * 2)

println("Get A[1,1]: ", get_element(A, 1, 1))
set_element!(A, 1, 1, 99.0)
println("After set A[1,1] to 99:")
print_Mat(A)

println("Testing out of bounds:")
try
    get_element(A, 5, 1)
catch e
    println("Caught: ", e)
end

A = Mat([3.0 2.0; 1.0 4.0])
println("det(A) = ", determinant_mat(A))  # should be 10.0

B = Mat([2.0 1.0 0.0; 1.0 3.0 1.0; 0.0 1.0 2.0])
println("det(B) = ", determinant_mat(B))  # should be 6.0

C = Mat([1.0 2.0 3.0; 4.0 5.0 6.0; 7.0 8.0 9.0])
println("det(C) = ", determinant_mat(C))  # should be 0.0

B = Mat([2.0 1.0 0.0; 1.0 3.0 1.0; 0.0 1.0 2.0])

println("Submatrix removing row 1, col 1:")
print_Mat(submat(B, 1, 1))

println("Submatrix removing row 1, col 2:")
print_Mat(submat(B, 1, 2))

println("Submatrix removing row 1, col 3:")
print_Mat(submat(B, 1, 3))

I3 = identity_mat(3)
println("det(I) = ", determinant_mat(I3))

A = Mat([2.0 1.0; 5.0 3.0])
println("A:")
print_Mat(A)
println("A inverse:")
Ainv = inverse_mat(A)
print_Mat(Ainv)

println("A * A⁻¹ (should be identity):")
print_Mat(A * Ainv)

println("Testing singular matrix:")
try
    S = Mat([1.0 2.0 3.0; 4.0 5.0 6.0; 7.0 8.0 9.0])
    inverse_mat(S)
catch e
    println(e)
end

A = Mat([2.0 1.0; 1.0 3.0])
b = Mat(reshape([5.0, 10.0], 2, 1))
println("Solution x:")
print_Mat(solve_mat(A, b))