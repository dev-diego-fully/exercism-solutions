/**
 * @file bank_account.h
 * @brief Thread-safe bank account implementation
 */

#if !defined(BANK_ACCOUNT_H)
#define BANK_ACCOUNT_H

#include <mutex>

namespace Bankaccount
{
    /**
     * @brief Thread-safe bank account with basic operations
     *
     * Features:
     * - Mutual exclusion for all operations
     * - State management (open/closed)
     * - Balance validation
     */
    class Bankaccount
    {
    public:
        /// @brief Get current balance (thread-safe)
        /// @throw std::runtime_error if account closed
        int balance();

        /// @brief Open account (initially closed)
        /// @throw std::runtime_error if already open
        void open();

        /// @brief Close account and reset balance
        /// @throw std::runtime_error if already closed
        void close();

        /**
         * @brief Add funds to account
         * @param value Positive amount to deposit
         * @throw std::runtime_error for invalid values/state
         */
        void deposit(int value);

        /**
         * @brief Remove funds from account
         * @param value Positive amount ≤ balance
         * @throw std::runtime_error for invalid values/state
         */
        void withdraw(int value);

    private:
        int balance_ = 0;     ///< Current account balance
        bool is_open = false; ///< Account state flag
        std::mutex mutex;     ///< Thread safety mechanism

        /**
         * @brief Validates account is in open state
         * @throw std::runtime_error if account is closed
         * @pre Requires external mutex locking before call
         * @warning Not thread-safe by itself - caller must ensure mutex is locked
         *
         * This is an internal consistency check, not a synchronization mechanism.
         * Locking must be established through public interface methods before using.
         */
        void assert_open();
    };

} // namespace Bankaccount

#endif // BANK_ACCOUNT_H