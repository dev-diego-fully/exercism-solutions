--- A factory function that creates an iterator to generate slices (substrings) of a given string.
--- This function performs validation checks before returning the iterator.
---
--- It will throw an error if:
--- - The `length` is less than or equal to zero.
--- - The input string `s` is empty.
--- - The `length` is greater than the length of the string.
---
--- @param s string The input string to slice.
--- @param length integer The desired length of each slice.
--- @return (fun(): string) -- An iterator function that yields the next slice.
return function(s, length)
    assert(s:len() > 0, "series cannot be empty")
    assert(length ~= 0, "slice length cannot be zero")
    assert(length > 0, "slice length cannot be negative")
    assert(length <= s:len(), "slice length cannot be greater than series length")

    local i = 0
    local limit = 1 + (s:len() - length)
    local slice_padding = length - 1

    --- The iterator function that generates and returns the next slice of the string.
    --- It returns `nil` when there are no more slices to be generated.
    --- @return string|nil -- The next slice or `nil` if the iteration is complete.
    local function next(_, _)
        i = i + 1
        if i <= limit then
            return s:sub(i, slice_padding + i)
        else
            return nil
        end
    end

    return next
end
