/**
 * @file robot_name.h
 * @brief Robot name generator with unique name guarantees
 */
#if !defined(ROBOT_NAME_H)
#define ROBOT_NAME_H

#include <string>
#include <set>
#include <random>

namespace robot_name
{
    /**
     * @brief Robot with unique AA### formatted name
     *
     * Generates names in pattern: 2 uppercase letters + 3 digits
     */
    class robot
    {
    public:
        /// @brief Creates robot with unique random name
        robot();

        /// @brief Gets current robot name
        std::string name() const;

        /// @brief Resets robot with new unique name
        void reset();

    private:
        /// @brief Pool of all used names
        static std::set<std::string> reserved_names;

        /// @brief Generates new random name following AA### pattern
        static std::string generate_robot_name();

        std::string robot_name; ///< Current robot identifier

        /// @brief Initializes/resets name with collision checking
        void setup_first_settings();
    };

} // namespace robot_name

#endif // ROBOT_NAME_H