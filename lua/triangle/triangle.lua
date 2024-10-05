local triangle = {}
local triangle_kinds = {
    isoceles = "isosceles",
    scalene = "scalene",
    equilateral = "equilateral"
}


local function satisfy_inequality(a, b, c)
    return a + b >= c
end

local function satisfy_inequalities(a, b, c)
    return (
        satisfy_inequality(a, b, c) and
        satisfy_inequality(a, c, b) and
        satisfy_inequality(b, c, a)
    )
end

local function all_positive(...)
    return math.min(...) > 0
end

local function is_triangle(a, b, c)
    return all_positive(a, b, c) and satisfy_inequalities(a, b, c)
end

local function appearance(...)
    local values = {}
    for _, v in ipairs({ ... }) do
        values[v] = (values[v] or 0) + 1
    end
    return values
end

function triangle.kind(a, b, c)
    if not is_triangle(a, b, c) then error("Input Error") end

    local equals = appearance(a, b, c)

    if equals[a] == 3 then
        return triangle_kinds.equilateral
    elseif equals[a] == 1 and equals[b] == 1 then
        return triangle_kinds.scalene
    else
        return triangle_kinds.isoceles
    end
end

return triangle
