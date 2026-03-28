mutable struct Mat
    rows::Int
    cols::Int
    data::Array{Float64, 2}
end

function Mat(rows::Int, cols::Int)
    if rows <= 0 || cols <= 0
        error("Rows and columns must be greater than 0")
    end
    data = zeros(Float64, rows, cols)
    return Mat(rows, cols, data)
end

function Mat(data::Matrix{<:Real})
    return Mat(size(data, 1), size(data, 2), Float64.(data))
end

function get_element(m::Mat, i::Int, j::Int)
    if i < 1 || i > m.rows
        error("Error: row position out of bounds")
    elseif j < 1 || j > m.cols
        error("Error: column position out of bounds")
    else
        return m.data[i, j]
    end
end

function set_element!(m::Mat, i::Int, j::Int, value::Float64)
    if i < 1 || i > m.rows
        error("Error: row position out of bounds")
    elseif j < 1 || j > m.cols
        error("Error: column position out of bounds")
    else
        m.data[i, j] = value
    end
end

function print_Mat(m::Mat)
    for i in 1:m.rows
        for j in 1:m.cols
            print(m.data[i, j], "\t")
        end
        println()
    end
end

function Base.:+(a::Mat, b::Mat)
    if a.rows != b.rows || a.cols != b.cols
        error("Mat dimensions must match for addition")
    end
    result = Mat(a.rows, a.cols)
    for i in 1:a.rows
        for j in 1:a.cols
            result.data[i, j] = a.data[i, j] + b.data[i, j]
        end
    end
    return result
end

function Base.:-(a::Mat, b::Mat)
    if a.rows != b.rows || a.cols != b.cols
        error("Mat dimensions must match for subtraction")
    end
    result = Mat(a.rows, a.cols)
    for i in 1:a.rows
        for j in 1:a.cols
            result.data[i, j] = a.data[i, j] - b.data[i, j]
        end
    end
    return result
end

function Base.:*(a::Mat, scalar::Real)
    result = Mat(a.rows, a.cols)
    for i in 1:a.rows
        for j in 1:a.cols
            result.data[i, j] = scalar * a.data[i, j]
        end
    end
    return result
end

function Base.:*(a::Mat, b::Mat)
    if a.cols != b.rows
        error("Invalid dimensions for Mat multiplication")
    end
    result = Mat(a.rows, b.cols)
    for i in 1:a.rows
        for j in 1:b.cols
            for k in 1:a.cols
                result.data[i, j] += a.data[i, k] * b.data[k, j]
            end
        end
    end
    return result
end

function transpose_mat(m::Mat)
    result = Mat(m.cols, m.rows)
    for i in 1:m.rows
        for j in 1:m.cols
            result.data[j, i] = m.data[i, j]
        end
    end
    return result
end

function identity_mat(n::Int)
    result = zeros_mat(n, n)
    for i in 1:n
        result.data[i, i] = 1
    end
    return result
end

function zeros_mat(rows::Int, cols::Int)
    return Mat(rows, cols, zeros(Float64, rows, cols))
end

function ones_mat(rows::Int, cols::Int)
    return Mat(rows, cols, ones(Float64, rows, cols))
end

function submat(m::Mat, skip_row::Int, skip_col::Int)
    result = Mat(m.rows - 1, m.cols - 1)

    r_new = 1
    for r in 1:m.rows
        if r == skip_row
            continue
        end

        c_new = 1
        for c in 1:m.cols
            if c == skip_col
                continue
            end

            result.data[r_new, c_new] = m.data[r, c]
            c_new += 1
        end

        r_new += 1
    end

    return result
end

function determinant_mat(m::Mat)
    if m.rows != m.cols
        error("Determinant only defined for square matrices")

    elseif m.rows == 1
        return m.data[1, 1]

    elseif m.rows == 2
        return m.data[1, 1] * m.data[2, 2] -
               m.data[1, 2] * m.data[2, 1]
    
    else
        result = 0
        for j in 1:m.cols
            sign = (-1)^(1+j)
            sub = submat(m, 1, j)
            result += sign * m.data[1, j] * determinant_mat(sub)
        end
        return result
    end
end

function inverse_mat(m::Mat)
    if m.rows != m.cols
        error("Inverse only defined for square matrices")
    end
    
    if determinant_mat(m) == 0
        error("Matrix is not invertible — determinant is 0")
    end
    
    n = m.rows
    aug = Mat(n, 2n)

    for i in 1:n
        for j in 1:n
            aug.data[i, j] = m.data[i, j]
        end
    end

    for i in 1:n
        aug.data[i, i + n] = 1
    end

    for i in 1:n
        max_row = i
        for k in i+1:n
            if abs(aug.data[k, i]) > abs(aug.data[max_row, i])
                max_row = k
            end
        end

        if max_row != i
            for j in 1:2n
                temp = aug.data[i, j]
                aug.data[i, j] = aug.data[max_row, j]
                aug.data[max_row, j] = temp
            end
        end

        pivot = aug.data[i, i]
        if pivot == 0
            error("Matrix is singular during elimination")
        end

        for j in 1:2n
            aug.data[i, j] /= pivot
        end

        for k in 1:n
            if k != i
                factor = aug.data[k, i]
                for j in 1:2n
                    aug.data[k, j] -= factor * aug.data[i, j]
                end
            end
        end
    end

    result = Mat(n, n)
    for i in 1:n
        for j in 1:n
            result.data[i, j] = aug.data[i, j + n]
        end
    end

    return result
end

function solve_mat(A::Mat, b::Mat)
    if A.rows != A.cols
        error("Matrix A must be square")
    end
    if b.rows != A.rows || b.cols != 1
        error("Vector b must have same number of rows as A and 1 column")
    end
    if determinant_mat(A) == 0
        error("Matrix is not invertible — system has no unique solution")
    end

    n = A.rows
    aug = Mat(n, n + 1)

    for i in 1:n
        for j in 1:n
            aug.data[i, j] = A.data[i, j]
        end
        aug.data[i, n + 1] = b.data[i, 1]
    end

    for i in 1:n
        max_row = i
        for k in i+1:n
            if abs(aug.data[k, i]) > abs(aug.data[max_row, i])
                max_row = k
            end
        end

        if max_row != i
            for j in 1:n+1
                temp = aug.data[i, j]
                aug.data[i, j] = aug.data[max_row, j]
                aug.data[max_row, j] = temp
            end
        end

        pivot = aug.data[i, i]
        for j in 1:n+1
            aug.data[i, j] /= pivot
        end

        for k in 1:n
            if k != i
                factor = aug.data[k, i]
                for j in 1:n+1
                    aug.data[k, j] -= factor * aug.data[i, j]
                end
            end
        end
    end

    result = Mat(n, 1)
    for i in 1:n
        result.data[i, 1] = aug.data[i, n + 1]
    end

    return result
end