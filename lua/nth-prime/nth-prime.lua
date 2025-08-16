local nth, estimate, mark_multiples

--- The first prime number.
local FIRST_PRIME <const> = 2

--- Finds the `n`th prime number.
--- The function uses an optimized Sieve of Eratosthenes algorithm that stops as soon as the `n`th prime is found.
--- It first estimates an upper limit for the search to avoid sieving an unnecessarily large range.
---
--- It will throw an error if `n` is less than 1.
---
--- @param n integer The position of the prime number to find (e.g., n=1 for the first prime, n=2 for the second).
--- @return integer -- The `n`th prime number.
function nth(n)
    assert(n >= 1, "count cannot be negative")

    if n == 1 then
        return FIRST_PRIME
    end


    local top_limit <const> = estimate(n)
    local sieve = {}
    local count = 1

    mark_multiples(sieve, FIRST_PRIME, top_limit)

    for i = FIRST_PRIME + 1, top_limit, 2 do
        if not sieve[i] then
            count = count + 1
            if count == n then
                return i
            end
            mark_multiples(sieve, i, top_limit)
        end
    end

    error("logic fail")
end

--- Estimates a safe upper bound to search for the `n`th prime.
--- The estimate is based on the Prime Number Theorem. This prevents the sieve from running
--- on an excessively large range, improving performance.
--- @param n integer The position of the prime number.
--- @return integer -- An estimated upper limit for the sieve.
function estimate(n)
    if n < 6 then
        return 2 * (n + 1) + 1
    else
        local ln_n = math.log(n)
        local ln_ln_n = math.log(ln_n)

        return n * (ln_n + ln_ln_n)
    end
end

--- Marks all multiples of a given value as composite in a sieve table.
--- This is a key step in the Sieve of Eratosthenes algorithm.
--- @param marks boolean[] The table used to mark composite numbers.
--- @param value integer The prime number whose multiples are to be marked.
--- @param up_limit integer The upper bound for the marking process.
function mark_multiples(marks, value, up_limit)
    for i = value ^ 2, up_limit, value do
        marks[i] = true
    end
end

return nth