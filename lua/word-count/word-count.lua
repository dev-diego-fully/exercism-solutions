local function no_enter_apostrofes(word)
    return word:gsub("^'+", ""):gsub("'+$", "")
end

local function inc(tab, key)
    tab[key] = (tab[key] or 0) + 1
end

local function word_count(s)
    local counts = {}
    local word_catcher = "[%w']+"

    for word in s:lower():gmatch(word_catcher) do
        inc(counts, no_enter_apostrofes(word))
    end

    return counts
end

return { word_count = word_count }
