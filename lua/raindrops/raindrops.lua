local raindrop_sounds = {};

raindrop_sounds[3] = "Pling";
raindrop_sounds[5] = "Plang";
raindrop_sounds[7] = "Plong";


local function is_divisible(x, y)
    return x % y == 0;
end

return function(n)
    local raindrop_sound = "";
    if is_divisible(n, 3) then
        raindrop_sound = raindrop_sound .. raindrop_sounds[3];
    end
    if is_divisible(n, 5) then
        raindrop_sound = raindrop_sound .. raindrop_sounds[5]
    end
    if is_divisible(n, 7) then
        raindrop_sound = raindrop_sound .. raindrop_sounds[7];
    end
    if raindrop_sound == "" then
        return tostring(n);
    end
    return raindrop_sound;
end