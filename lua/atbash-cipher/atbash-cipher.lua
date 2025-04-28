--- characters added every n characters in atbash cipher
local separator <const> = " "
--- Interval at which the atbash separator is inserted into the
--- encrypted string.
local separator_interval <const> = 5
--- size of blocks formed by a separator and its predecessor characters.
local block_size <const> = 6
--- size of the latin alphabet
local alphabet_size <const> = 26
local lowercase_start <const> = string.byte("a")

--- Returns whether or not it is necessary to add a new separator to the list
--- of chars to continue the encryption process.
--- @param chars table Character List
--- @returns boolean
local function needs_separate(chars)
    return #chars % block_size == separator_interval
end

--- Returns whether or not the given character represents a decimal digit.
--- @param char string checked character
--- @returns boolean
local function is_digit(char)
    local min_digit <const>, max_digit <const> = 0, 9

    local digit_value = string.byte(char) - string.byte("0")
    return min_digit <= digit_value and digit_value <= max_digit
end

--- Encrypt a letter according to the atbash cipher
--- @param char string checked char
--- @returns boolean
local function encode_letter(char)
    local index <const> = string.byte(char) - lowercase_start
    local new_index <const> = alphabet_size - index

    return string.char(lowercase_start + new_index - 1)
end

--- Adds the character to the end of the character list. Adds it encrypted,
--- if it is possible to encrypt it. Automatically adds atbash separators
--- as needed.
--- @param chars table list of characters already encrypted
--- @param char string Character to be added
local function add_encoded(chars, char)
    if needs_separate(chars) then
        table.insert(chars, separator)
    end
    if is_digit(char) then
        table.insert(chars, char)
        return
    end
    local letter = string.lower(char)
    table.insert(chars, encode_letter(letter))
end

--- Returns an iterator containing only the characters of a text that are
--- kept in an atbash cipher.
--- @param text string Text that will get the characters
--- @return fun():string
local function just_encodables(text)
    return text:gmatch("%w")
end

--- Encrypt a text using the atbash cipher
--- @param plain_text string text to be encrypted
--- @return string
local function encode(plain_text)
    local chars = {}

    for char in just_encodables(plain_text) do
        add_encoded(chars, char)
    end

    return table.concat(chars, "")
end

return {
    encode = encode
}
