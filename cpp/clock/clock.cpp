/**
 * @file clock.cpp
 * @brief Implementation of date-independent clock operations.
 */
#include "clock.h"

namespace date_independent
{
    const int MINUTES_IN_DAY = 1440;
    const int MINUTES_IN_HOUR = 60;

    clock::clock(int total_minutes)
    {
        const int real_minutes = total_minutes % MINUTES_IN_DAY;

        this->total_minutes = real_minutes >= 0 ? real_minutes : MINUTES_IN_DAY + real_minutes;
    }

    clock clock::at(int hours, int minutes)
    {
        return clock(hours * MINUTES_IN_HOUR + minutes);
    }

    clock clock::plus(int minutes) const
    {
        return clock(this->total_minutes + minutes);
    }

    bool clock::operator==(const clock &other) const
    {
        return this->total_minutes == other.total_minutes;
    }

    bool clock::operator!=(const clock &other) const
    {
        return this->total_minutes != other.total_minutes;
    }

    clock::operator std::string() const
    {
        std::ostringstream representation;

        representation << std::setw(2) << std::setfill('0') << this->hours() << ":";
        representation << std::setw(2) << std::setfill('0') << this->minutes();

        return representation.str();
    }

    int clock::hours() const
    {
        return this->total_minutes / MINUTES_IN_HOUR;
    }

    int clock::minutes() const
    {
        return this->total_minutes % MINUTES_IN_HOUR;
    }

} // namespace date_independent
