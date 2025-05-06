---Class represents a basic D&D character, with a name,
---abilities and hitpoints.
---@class Character
---@field name string
---@field strength integer
---@field dexterity integer
---@field constitution integer
---@field intelligence integer
---@field wisdom integer
---@field charisma integer
---@field hitpoints integer
local Character = {}

local d6


---Base hitpoint value. This is the amount of health a character will have
---if their constitution modifier is 0.
local BASE_HITPOINT <const> = 10
---Default score value, considered average and in which the modifier assumes
---the value 0
local BASE_SCORE <const> = 10
---Factor by which a score is divided to calculate the modifier
local SCORE_FACTOR <const> = 2

---Returns the character's ability score, as of the date rolled.
---Calculates this score using "r4kh3"
---@param scores table<integer> a roll of (at least) 4 dice
---@return integer
local function ability(scores)
    local scores_copy = { table.unpack(scores) }
    table.sort(scores_copy, function(a, b) return a > b end)

    local h1, h2, h3 = table.unpack(scores_copy, 1, 3)

    return h1 + h2 + h3
end

---Returns the result of rolling 4 dice. Returns the dice individually,
---without adding them or performing any other operation.
---@return table<integer>
local function roll_dice()
    local dices = {}

    for _, _ in ipairs({ 1, 2, 3, 4 }) do
        table.insert(dices, d6())
    end

    return dices
end

---Returns the modifier value for the given ability score. Uses the formula
---(score - 10) / 2
---@param input integer Ability Value Score
---@return integer
local function modifier(input)
    return math.floor((input - BASE_SCORE) / SCORE_FACTOR)
end

---Returns a new object of type "Character", representing a D&D character
---@param name string
---@return Character
function Character:new(name)
    ---@type Character
    local char = {
        name = name,
        strength = ability(roll_dice()),
        dexterity = ability(roll_dice()),
        constitution = ability(roll_dice()),
        intelligence = ability(roll_dice()),
        wisdom = ability(roll_dice()),
        charisma = ability(roll_dice()),
        hitpoints = 0,
        new = nil
    }

    char.hitpoints = BASE_HITPOINT + modifier(char.constitution)

    return char
end

---Returns a random value obtained by rolling 1d6.
---@return integer
function d6()
    return math.random(1, 6)
end

return {
    Character = Character,
    ability = ability,
    roll_dice = roll_dice,
    modifier = modifier
}
