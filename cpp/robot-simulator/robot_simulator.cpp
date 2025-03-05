/**
 * @file robot_simulator.cpp
 * @brief Implementation of robot movement mechanics
 */

#include "robot_simulator.h"

namespace robot_simulator
{
    Robot::Robot()
    {
        this->set_direction(DEFAULT_INITIAL_DIRECTION);
        this->set_position(DEFAULT_INITIAL_POSITION);
    }

    Robot::Robot(const std::pair<int, int> &initial_position, Bearing initial_direction)
    {
        this->set_direction(initial_direction);
        this->set_position(initial_position);
    }

    Robot::Robot(const std::pair<int, int> &initial_position)
    {
        this->set_position(initial_position);
        this->set_direction(DEFAULT_INITIAL_DIRECTION);
    }

    Robot::Robot(Bearing initial_direction)
    {
        this->set_direction(initial_direction);
        this->set_position(DEFAULT_INITIAL_POSITION);
    }

    std::pair<int, int> Robot::get_position() const
    {
        return {this->x, this->y};
    }

    Bearing Robot::get_bearing() const
    {
        return this->facing_direction;
    }

    /**
     * @brief Rotates bearing clockwise using fixed sequence:
     * NORTH → EAST → SOUTH → WEST → NORTH
     */
    void Robot::turn_right()
    {
        switch (this->facing_direction)
        {
        case Bearing::NORTH:
            this->facing_direction = Bearing::EAST;
            break;

        case Bearing::EAST:
            this->facing_direction = Bearing::SOUTH;
            break;

        case Bearing::SOUTH:
            this->facing_direction = Bearing::WEST;
            break;

        case Bearing::WEST:
            this->facing_direction = Bearing::NORTH;
            break;

        default:
            throw std::domain_error("");
        }
    }

    /**
     * @brief Rotates bearing counter-clockwise using fixed sequence:
     * NORTH → WEST → SOUTH → EAST → NORTH
     */
    void Robot::turn_left()
    {
        switch (this->facing_direction)
        {
        case Bearing::NORTH:
            this->facing_direction = Bearing::WEST;
            break;

        case Bearing::EAST:
            this->facing_direction = Bearing::NORTH;
            break;

        case Bearing::SOUTH:
            this->facing_direction = Bearing::EAST;
            break;

        case Bearing::WEST:
            this->facing_direction = Bearing::SOUTH;
            break;

        default:
            throw std::domain_error("facing unknown position");
        }
    }

    /**
     * @brief Moves in current facing direction:
     * - NORTH: y++
     * - EAST:  x++
     * - SOUTH: y--
     * - WEST:  x--
     */
    void Robot::advance()
    {
        switch (this->facing_direction)
        {
        case Bearing::NORTH:
            this->y++;
            break;

        case Bearing::EAST:
            this->x++;
            break;

        case Bearing::SOUTH:
            this->y--;
            break;

        case Bearing::WEST:
            this->x--;
            break;

        default:
            throw std::domain_error("facing unknown position");
        }
    }

    /// @details Processes commands sequentially, stops on first error
    void Robot::execute_sequence(const std::string &sequence)
    {
        for (auto command : sequence)
        {
            this->execute_command(command);
        }
    }

    /**
     * @brief Internal command router
     * @param command Single character command (case-sensitive)
     * @throw std::domain_error if command not in {L, R, A}
     */
    void Robot::execute_command(char command)
    {
        switch (command)
        {
        case 'L':
            this->turn_left();
            break;

        case 'R':
            this->turn_right();
            break;

        case 'A':
            this->advance();
            break;

        default:
            throw std::domain_error("unknown command");
        }
    }

    /// @internal Directly sets orientation without validation
    void Robot::set_direction(Bearing directions)
    {
        this->facing_direction = directions;
    }

    /// @internal Directly sets coordinates without boundary checks
    void Robot::set_position(const std::pair<int, int> &position)
    {
        this->x = position.first;
        this->y = position.second;
    }

} // namespace robot_simulator
