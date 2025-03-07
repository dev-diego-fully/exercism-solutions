#include "bank_account.h"

namespace Bankaccount
{

    void Bankaccount::open()
    {
        const std::lock_guard<std::mutex> lock(this->mutex);

        if (this->is_open)
        {
            throw std::runtime_error("the account is already open");
        }
        this->is_open = true;
    }

    void Bankaccount::close()
    {
        const std::lock_guard<std::mutex> lock(this->mutex);
        this->assert_open();

        this->is_open = false;
        this->balance_ = 0;
    }

    void Bankaccount::deposit(int value)
    {
        const std::lock_guard<std::mutex> lock(this->mutex);
        this->assert_open();

        if (value < 0)
        {
            throw std::runtime_error("can't deposit negative values");
        }

        this->balance_ += value;
    }

    void Bankaccount::withdraw(int value)
    {
        const std::lock_guard<std::mutex> lock(this->mutex);
        this->assert_open();

        if (value < 0)
        {
            throw std::runtime_error("can't withdraw negative values");
        }

        if (value > this->balance_)
        {
            throw std::runtime_error("withdrawal cannot exceed the balance");
        }

        this->balance_ -= value;
    }

    int Bankaccount::balance()
    {
        this->assert_open();
        const std::lock_guard<std::mutex> lock(this->mutex);

        return this->balance_;
    }

    void Bankaccount::assert_open()
    {
        if (!this->is_open)
        {
            throw std::runtime_error("can't operate a closed account");
        }
    }

}