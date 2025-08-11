--- A module for computing the Hamming distance between two DNA strands.
local Hamming = {}

--- A sub-module with helper functions for DNA string manipulation.
local dna = {}

--- Computes the Hamming distance between two DNA strands.
--- The Hamming distance is the number of positions at which the corresponding nucleotides are different.
--- @param a string The first DNA strand.
--- @param b string The second DNA strand.
--- @return number The Hamming distance between the two strands.
--- @error "strands must be of equal length" if the input strings have different lengths.
function Hamming.compute(a, b)
    if dna.size(a) ~= dna.size(b) then
        error("strands must be of equal length")
    end
    return dna.hamming(a, b, dna.size(a), 0)
end

--- Returns the nucleotide at a specific index in a DNA strand.
--- @param dna_string string The DNA strand.
--- @param index number The index of the nucleotide.
--- @return string The single nucleotide character.
function dna.nucleotide(dna_string, index)
    return string.sub(dna_string, index, index)
end

--- Calculates the Hamming distance at a single position.
--- @param dna_a string The first DNA strand.
--- @param dna_b string The second DNA strand.
--- @param index number The position to compare.
--- @return number 0 if nucleotides are the same, 1 otherwise.
function dna.hamming_at(dna_a, dna_b, index)
    if dna.nucleotide(dna_a, index) == dna.nucleotide(dna_b, index) then
        return 0
    else
        return 1
    end
end

--- Returns the length of a DNA strand.
--- @param dna_string string The DNA strand.
--- @return number The length of the strand.
function dna.size(dna_string)
    return #dna_string
end

--- Recursively calculates the Hamming distance between two strands.
--- This is an internal helper function.
--- @param dna_a string The first DNA strand.
--- @param dna_b string The second DNA strand.
--- @param position number The current position to compare.
--- @param distance number The accumulated distance.
--- @return number The final Hamming distance.
function dna.hamming(dna_a, dna_b, position, distance)
    if position > 0 then
        return dna.hamming(
            dna_a, dna_b, position - 1,
            distance + dna.hamming_at(dna_a, dna_b, position)
        )
    end
    return distance
end

return Hamming