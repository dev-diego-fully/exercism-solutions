/**
 * @file robot_simulator.h
 * @brief Robot movement simulation with directional control
 */

#if !defined(ROBOT_SIMULATOR_H)
#define ROBOT_SIMULATOR_H

#include <utility>
#include <stdexcept>

namespace robot_simulator
{
    /**
     * @brief Compass directions for robot orientation
     */
    enum class Bearing
    {
        NORTH, ///< Positive Y direction
        EAST,  ///< Positive X direction
        SOUTH, ///< Negative Y direction
        WEST,  ///< Negative X direction
    };

    /// Default starting coordinates (0, 0)
    const std::pair<int, int> DEFAULT_INITIAL_POSITION{0, 0};
    /// Default initial facing direction (North)
    const Bearing DEFAULT_INITIAL_DIRECTION{Bearing::NORTH};

    /**
     * @brief Simulates robot movement in 2D grid space
     *
     * Maintains position and orientation state with movement commands
     */
    class Robot
    {
    public:
        /// @brief Construct robot with default position/direction
        Robot();

        /// @brief Construct robot with custom direction
        /// @param initial_direction Starting orientation
        Robot(Bearing initial_direction);

        /// @brief Construct robot with custom position
        /// @param initial_position Starting (x,y) coordinates
        Robot(const std::pair<int, int> &initial_position);

        /// @brief Full custom constructor
        /// @param initial_position Starting coordinates
        /// @param initial_direction Starting orientation
        Robot(const std::pair<int, int> &initial_position, Bearing initial_direction);

        /// @brief Get current coordinates
        std::pair<int, int> get_position() const;

        /// @brief Get current facing direction
        Bearing get_bearing() const;

        /// @brief Rotate 90 degrees clockwise
        void turn_right();

        /// @brief Rotate 90 degrees counter-clockwise
        void turn_left();

        /// @brief Move one unit in facing direction
        void advance();

        /**
         * @brief Execute sequence of commands
         * @param sequence String containing commands (L=left, R=right, A=advance)
         * @throw std::domain_error For invalid commands
         */
        void execute_sequence(const std::string &sequence);

    private:
        int x, y;                 ///< Current position coordinates
        Bearing facing_direction; ///< Current orientation

        /// @brief Internal direction setter
        void set_direction(Bearing direction);

        /// @brief Internal position setter
        void set_position(const std::pair<int, int> &position);

        /// @brief Process single command character
        void execute_command(char command);
    };

} // namespace robot_simulator

#endif // ROBOT_SIMULATOR_H