/**
 * @file clock.h
 * @brief Date-independent clock handling time operations in 24h format.
 */

#if !defined(CLOCK_H)
#define CLOCK_H

#include <string>
#include <sstream>
#include <iomanip>

namespace date_independent
{
    /**
     * @brief Represents time-of-day without date information.
     *
     * Supports time arithmetic, comparisons, and string formatting.
     */
    class clock
    {
    public:
        /**
         * @brief Create a clock at specified time.
         * @param hours Hour value (0-23)
         * @param minutes Minute value (0-59)
         */
        static clock at(int hours, int minutes);

        /**
         * @brief Add minutes to current time.
         * @param minutes Minutes to add
         * @return New clock instance with added time
         */
        clock plus(int minutes) const;

        /// @brief Equality comparison
        bool operator==(const clock &other) const;

        /// @brief Inequality comparison
        bool operator!=(const clock &other) const;

        /// @brief Convert to HH:MM formatted string
        operator std::string() const;

    private:
        int total_minutes;
        /**
         * @brief Construct from total minutes
         * @param minutes Total minutes since midnight
         */
        clock(int minutes);

        /// @brief Get hour component (0-23)
        int hours() const;

        /// @brief Get minute component (0-59)
        int minutes() const;
    };

} // namespace date_independent

#endif // CLOCK_H