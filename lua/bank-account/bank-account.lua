---@class BankAccount
---@field _balance number
---@field _closed boolean
local BankAccount = {}

local ERROR_CLOSED <const> = "error: closed"
local ERROR_NEGATIVE_DEPOSIT <const> = "error: negative deposit"
local ERROR_NEGATIVE_WITHDRAW <const> = "error: negative withdraw"
local ERROR_OVERDRAWN <const> = "error: invalid overdrawn"

---Open a new account. Your balance starts at zero.
---@return BankAccount
function BankAccount.new()
    local account = {
        _balance = 0,
        _closed = false
    }
    return setmetatable(account, BankAccount)
end

---Gets the current account balance. The operation fails (raising an error)
---if the account is closed.
---@return number
function BankAccount:balance()
    assert(not self._closed, ERROR_CLOSED)

    return self._balance
end

---Deposits the given amount into the current account. The operation fails
---(raising an error) if the amount is negative or if the account is closed.
---@param value number
function BankAccount:deposit(value)
    assert(not self._closed, ERROR_CLOSED)
    assert(value > 0, ERROR_NEGATIVE_DEPOSIT)

    self._balance = self._balance + value
end

---Withdraws the given amount from the account. The operation fails
---(raising an error) if the amount withdrawn is negative, or greater
---than the current account balance, or if the account is already closed.
---@param value number
function BankAccount:withdraw(value)
    assert(not self._closed, ERROR_CLOSED)
    assert(value > 0, ERROR_NEGATIVE_WITHDRAW)
    assert(value < self._balance, ERROR_OVERDRAWN)

    self._balance = self._balance - value
end

---Closes the current account. After that, it will no longer be possible
---to perform operations on it. The operation will fail (raising an error)
---if the account is already closed.
function BankAccount:close()
    assert(not self._closed, ERROR_CLOSED)
    self._closed = true
end

BankAccount.__index = BankAccount

return BankAccount
