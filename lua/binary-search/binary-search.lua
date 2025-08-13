--- A local helper function that performs a recursive binary search on an array.
--- @generic T
--- @param array T[] The array to search within.
--- @param target T The value to search for.
--- @param bot integer The lower bound of the search range.
--- @param top integer The upper bound of the search range.
--- @return integer -- The 1-based index of the target if found, otherwise -1.
local function binary_search(array, target, bot, top)
    if bot > top then
        return -1
    end

    local middle = math.floor((bot + top) / 2)
    local current = array[middle]

    if current == target then
        return middle
    elseif current < target then
        return binary_search(array, target, middle + 1, top)
    else
        return binary_search(array, target, bot, middle - 1)
    end
end


--- A function that performs a binary search on a sorted array.
--- It returns the 1-based index of the target value. The array must be sorted for this to work.
--- @generic T The type of elements in the array.
--- @param array T[] The sorted array to search within.
--- @param target T The value to search for.
--- @return integer -- The 1-based index of the target if found, otherwise -1.
return function(array, target)
    return binary_search(array, target, 1, #array)
end
