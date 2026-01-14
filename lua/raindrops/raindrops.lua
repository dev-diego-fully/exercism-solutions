local raindrop_sound, is_divisible, raindrop_sounds;

--- Returns the sound of raindrops based on the divisibility of the passed number.
--- If the number is not divisible by any of the predefined numbers, the original
--- number will be returned as a string.
--- @param n integer
--- @return string
function raindrop_sound(n)
    local sound = "";
    if is_divisible(n, 3) then
        sound = sound .. raindrop_sounds[3];
    end
    if is_divisible(n, 5) then
        sound = sound .. raindrop_sounds[5]
    end
    if is_divisible(n, 7) then
        sound = sound .. raindrop_sounds[7];
    end
    if sound == "" then
        return tostring(n);
    end
    return sound;
end

--- Returns whether the first argument is divisible by the second.
--- @param x integer
--- @param y integer
--- @return boolean
function is_divisible(x, y)
    return x % y == 0;
end

raindrop_sounds = {
    [3] = "Pling",
    [5] = "Plang",
    [7] = "Plong"
};

return raindrop_sound
