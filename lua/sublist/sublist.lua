--- A module for comparing lists and determining their relationship.
local lists <const> = {}

--- An enumeration of the possible relationships between two lists.
--- @enum relation
local relation <const> = {
    equal = "equal",
    sublist = "sublist",
    superlist = "superlist",
    unequal = "unequal"
}

--- Determines the relationship between two lists.
--- The function checks for equality, and if not equal, checks if one list is a sublist or superlist of the other.
--- If none of these conditions are met, the lists are considered unequal.
--- @generic T
--- @param list1 T[] The first list.
--- @param list2 T[] The second list.
--- @return relation -- The relationship between the two lists.
function lists.relation(list1, list2)
    local l1_sub_l2 = lists.is_sublist(list1, list2)
    local l2_sub_l1 = lists.is_sublist(list2, list1)

    if l1_sub_l2 and l2_sub_l1 then
        return relation.equal
    elseif l1_sub_l2 then
        return relation.sublist
    elseif l2_sub_l1 then
        return relation.superlist
    else
        return relation.unequal
    end
end

--- Checks if one list is a sublist of another.
--- An empty list is always considered a sublist of any other list.
--- @generic T
--- @param sub T[] The potential sublist.
--- @param super T[] The potential superlist.
--- @return boolean -- True if `sub` is a sublist of `super`, false otherwise.
function lists.is_sublist(sub, super)
    if #sub == 0 then
        return true
    end
    if #sub > #super then
        return false
    end
    for slice in lists.slices(super, #sub) do
        if lists.equals(sub, slice) then
            return true
        end
    end
    return false
end

--- A factory function that creates an iterator to yield all contiguous slices of a given size from a list.
--- @generic T
--- @param list T[] The list to slice.
--- @param size integer The desired size of each slice.
--- @return fun(): T[] | nil -- An iterator function that yields the next slice or `nil` when done.
function lists.slices(list, size)
    local current = 0
    local limit = 1 + #list - size

    return function(_, _)
        current = current + 1
        if current <= limit then
            return lists.slice(list, current, size)
        end
    end
end

--- Checks if two lists are equal by comparing their elements one by one.
--- This is a shallow comparison.
--- @generic T
--- @param l1 T[] The first list.
--- @param l2 T[] The second list.
--- @return boolean -- True if the lists have the same elements in the same order, false otherwise.
function lists.equals(l1, l2)
    for i = 1, #l1, 1 do
        if l1[i] ~= l2[i] then
            return false
        end
    end
    return true
end

--- Creates a new list containing a slice of a given list.
--- @generic T
--- @param list T[] The list to slice.
--- @param start integer The starting index of the slice (1-based).
--- @param size integer The size of the slice.
--- @return table -- A new table containing the sliced elements.
function lists.slice(list, start, size)
    return { table.unpack(list, start, start + size) }
end

return lists.relation