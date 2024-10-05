local rna = {}

rna.nucleotide = { regex = "[AUCG]" }

rna.codon = {}

rna.codon.regex = string.rep(rna.nucleotide.regex, 3)
rna.codon.to_protein_table = {}
do
    local function save_translation(codons, protein)
        for _, codon in ipairs(codons) do
            rna.codon.to_protein_table[codon] = protein
        end
    end
    save_translation({ "AUG" }, "Methionine")
    save_translation({ "UUU", "UUC" }, "Phenylalanine")
    save_translation({ "UUA", "UUG" }, "Leucine")
    save_translation({ "UCU", "UCC", "UCA", "UCG" }, "Serine")
    save_translation({ "UAU", "UAC" }, "Tyrosine")
    save_translation({ "UGU", "UGC" }, "Cysteine")
    save_translation({ "UGG" }, "Tryptophan")
    save_translation({ "UAA", "UAG", "UGA" }, "STOP")
end


function rna.codon.valid(str)
    return str:match("^" .. rna.codon.regex .. "$") ~= nil
end

function rna.codon.translate(str)
    assert(rna.codon.valid(str), "Invalid rna codon")
    return rna.codon.to_protein_table[str]
end

rna.strand = {}

function rna.strand.translate(str)
    local proteins = {}

    for _, codon in ipairs(rna.strand.split(str)) do
        local translation = rna.codon.translate(codon)
        if translation == "STOP" then
            return proteins
        else
            table.insert(proteins, translation)
        end
    end

    return proteins
end

function rna.strand.split(str)
    local codons = {}

    for codon in str:gmatch("...") do
        table.insert(codons, codon)
    end

    return codons
end

return { codon = rna.codon.translate, rna_strand = rna.strand.translate }
