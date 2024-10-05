local chars         = require "chars"
local list          = require "list"

local dna           = {}
local nucleotide    = {}
local dna_meta      = {}

------dna_meta---------------------------

dna_meta.properties = { "nucleotideCounts" }

function dna_meta.__index(tab, index)
    if list.includes(dna_meta.properties, index) then
        return dna[index](tab)
    else
        return dna[index]
    end
end

-------nucleotide-------------------------------------------

nucleotide.nucleotides = { "A", "C", "T", "G" }

function nucleotide.is(char)
    return list.includes(nucleotide.nucleotides, char)
end

-------dna--------------------------------------

function dna.nucleotideCounts(self)
    local counts = list.appearances(self._dna)

    for _, nuc in ipairs(nucleotide.nucleotides) do
        counts[nuc] = counts[nuc] or 0
    end

    return counts
end

function dna.count(self, nuc)
    assert(
        nucleotide.is(nuc),
        "Invalid Nucleotide"
    )
    return list.count(self._dna, nuc)
end

---------DNA--------------------------------

local DNA = {}

function DNA.new(_self, dna)
    local self = {
        _dna = chars.get(dna)
    }
    assert(
        list.every(self._dna, nucleotide.is),
        "Invalid Sequence"
    )

    return setmetatable(
        self,
        dna_meta
    )
end

return DNA
