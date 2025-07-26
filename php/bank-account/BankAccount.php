<?php

declare(strict_types=1);

/**
 * BankAccount
 *
 * This class simulates a simple bank account, managing its state (open/closed)
 * and performing basic operations like deposits, withdrawals, and balance inquiries.
 * It includes validation to ensure operations are performed on an open account
 * and with valid amounts.
 */
class BankAccount
{
    /**
     * @var int The current balance of the bank account.
     */
    private int $balance;

    /**
     * @var bool Indicates whether the bank account is currently open.
     */
    private bool $isOpen;

    /**
     * Constructs a new BankAccount instance.
     *
     * Upon instantiation, the account is initialized as closed with a zero balance.
     */
    public function __construct()
    {
        $this->isOpen = false;
        $this->balance = 0;
    }

    /**
     * Opens the bank account.
     *
     * If the account is already open, an exception is thrown.
     * When opened, the balance is reset to zero.
     *
     * @throws Exception If the account is already open.
     */
    public function open()
    {
        $this->ensureIsClose();

        $this->isOpen = true;
        $this->balance = 0;
    }

    /**
     * Closes the bank account.
     *
     * If the account is not open, an exception is thrown.
     * When closed, the balance is reset to zero.
     *
     * @throws Exception If the account is not open.
     */
    public function close()
    {
        $this->ensureIsOpen();

        $this->isOpen = false;
        $this->balance = 0;
    }

    /**
     * Retrieves the current balance of the account.
     *
     * @return int The current balance.
     * @throws Exception If the account is not open.
     */
    public function balance(): int
    {
        $this->ensureIsOpen();

        return $this->balance;
    }

    /**
     * Deposits a specified amount into the account.
     *
     * The account must be open, and the amount must be a positive integer.
     *
     * @param int $amt The amount to deposit.
     * @throws Exception If the account is not open.
     * @throws InvalidArgumentException If the amount is not positive.
     */
    public function deposit(int $amt)
    {
        $this->ensureIsOpen();
        $this->ensureIsPositiveAmount($amt);

        $this->balance += $amt;
    }

    /**
     * Withdraws a specified amount from the account.
     *
     * The account must be open, the amount must be positive, and there must be sufficient funds.
     *
     * @param int $amt The amount to withdraw.
     * @throws Exception If the account is not open.
     * @throws InvalidArgumentException If the amount is not positive or if the balance is insufficient.
     */
    public function withdraw(int $amt)
    {
        $this->ensureIsOpen();
        $this->ensureIsPositiveAmount($amt);
        $this->ensureHasSufficientBalance($amt);

        $this->balance -= $amt;
    }

    /**
     * Ensures that the account is currently open.
     *
     * @throws Exception If the account is not open.
     */
    private function ensureIsOpen()
    {
        if (!$this->isOpen) {
            throw new Exception('account not open');
        }
    }

    /**
     * Ensures that the account is currently closed.
     *
     * @throws Exception If the account is already open.
     */
    private function ensureIsClose()
    {
        if ($this->isOpen) {
            throw new Exception('account already open');
        }
    }

    /**
     * Ensures that the provided amount is a positive integer.
     *
     * @param int $amt The amount to validate.
     * @throws InvalidArgumentException If the amount is less than 0.
     */
    private function ensureIsPositiveAmount(int $amt)
    {
        if ($amt < 0) {
            throw new InvalidArgumentException('amount must be greater than 0');
        }
    }

    /**
     * Ensures that the account has sufficient balance for a withdrawal.
     *
     * @param int $amt The amount intended for withdrawal.
     * @throws InvalidArgumentException If the amount to withdraw exceeds the current balance.
     */
    private function ensureHasSufficientBalance(int $amt)
    {
        if ($amt > $this->balance) {
            throw new InvalidArgumentException('amount must be less than balance');
        }
    }
}