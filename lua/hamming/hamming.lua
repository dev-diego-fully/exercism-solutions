local Hamming = {}

local dna = {}

function dna.nucleotide(dna_string, index)
    return string.sub(dna_string, index, index)
end

function dna.hamming_at(dna_a, dna_b, index)
    if dna.nucleotide(dna_a, index) == dna.nucleotide(dna_b, index) then
        return 0
    else
        return 1
    end
end

function dna.size(dna_string)
    return #dna_string
end

function dna.hamming(dna_a, dna_b, position, distance)
    if position > 0 then
        return dna.hamming(
            dna_a, dna_b, position - 1,
            distance + dna.hamming_at(dna_a, dna_b, position)
        )
    end
    return distance
end

function Hamming.compute(a, b)
    if dna.size(a) ~= dna.size(b) then
        return -1
    end
    return dna.hamming(a, b, dna.size(a), 0)
end

return Hamming
