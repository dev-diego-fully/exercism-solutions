// Package account provides a simple, thread-safe bank account implementation.
package account

import "sync"

// Account represents a bank account.
// It stores the current balance, the account's status, and a mutex for concurrent access.
type Account struct {
	balance       int64
	hasBeenClosed bool
	accountLock   sync.Mutex
}

// Open creates a new account with an initial deposit.
// It returns nil if the initial amount is negative.
func Open(amount int64) *Account {
	if amount < 0 {
		return nil
	}
	account := Account{
		balance:       amount,
		hasBeenClosed: false,
		accountLock:   sync.Mutex{},
	}

	return &account
}

// Balance returns the current balance of the account and a boolean indicating success.
// If the account is closed, it returns a balance of 0 and false.
func (a *Account) Balance() (int64, bool) {
	a.lock()

	balance, success := int64(0), false

	if !a.hasBeenClosed {
		balance, success = a.balance, true
	}

	a.unlock()

	return balance, success
}

// Deposit adds or withdraws money from the account.
// It returns the new balance and a boolean indicating success.
// A deposit is only successful if the account is open and the resulting balance is not negative.
func (a *Account) Deposit(amount int64) (int64, bool) {
	a.lock()

	balance, success := int64(0), false

	if !a.hasBeenClosed && amount >= -a.balance {
		a.balance += amount
		balance, success = a.balance, true
	}

	a.unlock()

	return balance, success
}

// Close closes the account and returns the final balance and a boolean indicating success.
// If the account is already closed, it returns the balance of 0 and false.
func (a *Account) Close() (int64, bool) {
	a.lock()

	balance, success := a.balance, false

	if !a.hasBeenClosed {
		success = true
		a.hasBeenClosed, a.balance = true, 0
	}

	a.unlock()

	return balance, success
}

// lock is a private helper method to acquire the account's mutex lock.
func (a *Account) lock() {
	a.accountLock.Lock()
}

// unlock is a private helper method to release the account's mutex lock.
func (a *Account) unlock() {
	a.accountLock.Unlock()
}
