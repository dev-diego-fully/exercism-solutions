/**
 * @file robot_name.cpp
 * @brief Implementation of robot name generation mechanics
 */
#include "robot_name.h"

namespace robot_name
{

    // Helpers prototypes
    /// @brief Generates random A-Z character
    char random_letter();
    /// @brief Generates random 0-9 character
    char random_digit();
    /// @brief Random number in [start, end) range
    int random_range(int start, int end);

    robot::robot()
    {
        this->setup_first_settings();
    }

    std::string robot::name() const
    {
        return this->robot_name;
    }

    void robot::reset()
    {
        this->setup_first_settings();
    }

    void robot::setup_first_settings()
    {
        std::string new_name;

        do
        {
            new_name = robot::generate_robot_name();
        } while (robot::reserved_names.count(new_name) > 0);

        robot::reserved_names.insert(new_name);
        this->robot_name = new_name;
    }

    std::set<std::string> robot::reserved_names;

    std::string robot::generate_robot_name()
    {
        const char letter1 = random_letter();
        const char letter2 = random_letter();
        const char digit1 = random_digit();
        const char digit2 = random_digit();
        const char digit3 = random_digit();

        std::string name{letter1, letter2, digit1, digit2, digit3};

        return name;
    }

    char random_letter()
    {
        const char first_letter = 'A';
        const int alphabet_size = 26;

        return first_letter + random_range(0, alphabet_size);
    }

    char random_digit()
    {
        const char first_digit = '0';
        const int digits_base = 10;

        return first_digit + random_range(0, digits_base);
    }

    int random_range(int start, int end)
    {
        static std::random_device rand_device;
        static std::mt19937 generator(rand_device());
        std::uniform_int_distribution distributor(start, end - 1);

        return distributor(generator);
    }

} // namespace robot_name
