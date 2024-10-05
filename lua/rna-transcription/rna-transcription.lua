local rna_to_dna_complementation_table = {
    G = "C",
    C = "G",
    T = "A",
    A = "U"
}

return function(dna)
    return dna:gsub(".", rna_to_dna_complementation_table)
end
