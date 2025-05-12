local SCORES_TABLE

---Returns the score of the word in the scrabble game.
---@param word? string
---@return integer
local function score(word)
    if word == nil then
        return 0
    end

    local result = 0

    for current in word:gmatch("[a-zA-Z]") do
        local letter = current:upper()
        local letter_score = SCORES_TABLE[letter] or 0

        result = result + letter_score
    end

    return result
end

---Creates a new score table from a list of score-letter key-value pairs
---@param scores_pairs {[1]:integer, [2]:string[]}[]
---@return table<string, integer>
local function ScoreTable(scores_pairs)
    local score_table = {}

    for _, scores_pair in pairs(scores_pairs) do
        local score, letters = table.unpack(scores_pair)

        for _, letter in ipairs(letters) do
            score_table[letter] = score
        end
    end

    return score_table
end


SCORES_TABLE = ScoreTable({
    { 1,  { "A", "E", "I", "O", "U", "L", "N", "R", "S", "T" } },
    { 2,  { "D", "G" } },
    { 3,  { "B", "C", "M", "P" } },
    { 4,  { "F", "H", "V", "W", "Y" } },
    { 5,  { "K" } },
    { 8,  { "J", "X" } },
    { 10, { "Q", "Z" } }
})

return { score = score }
