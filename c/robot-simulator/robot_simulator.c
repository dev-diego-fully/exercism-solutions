#include "robot_simulator.h"

void exec_command(robot_status_t *robot, const char command);
void rotate_right(robot_status_t *robot);
void rotate_left(robot_status_t *robot);
void advance(robot_status_t *robot);

robot_status_t robot_create(robot_direction_t direction, int x, int y) {
  return (robot_status_t){.direction = direction,
                          .position = (robot_position_t){.x = x, .y = y}};
}

void robot_move(robot_status_t *robot, const char *commands) {
  for (size_t i = 0; i < strlen(commands); i++) {
    exec_command(robot, commands[i]);
  }
}

void exec_command(robot_status_t *robot, const char command) {
  switch (command) {
  case 'R':
    rotate_right(robot);
    break;
  case 'L':
    rotate_left(robot);
    break;
  case 'A':
    advance(robot);
    break;
  }
}

void rotate_right(robot_status_t *robot) {
  switch (robot->direction) {
  case DIRECTION_NORTH:
    robot->direction = DIRECTION_EAST;
    break;
  case DIRECTION_EAST:
    robot->direction = DIRECTION_SOUTH;
    break;
  case DIRECTION_SOUTH:
    robot->direction = DIRECTION_WEST;
    break;
  case DIRECTION_WEST:
    robot->direction = DIRECTION_NORTH;
    break;
  default:
    break;
  }
}

void rotate_left(robot_status_t *robot) {
  switch (robot->direction) {
  case DIRECTION_NORTH:
    robot->direction = DIRECTION_WEST;
    break;
  case DIRECTION_EAST:
    robot->direction = DIRECTION_NORTH;
    break;
  case DIRECTION_SOUTH:
    robot->direction = DIRECTION_EAST;
    break;
  case DIRECTION_WEST:
    robot->direction = DIRECTION_SOUTH;
    break;
  default:
    break;
  }
}

void advance(robot_status_t *robot) {
  switch (robot->direction) {
  case DIRECTION_NORTH:
    robot->position.y++;
    break;
  case DIRECTION_EAST:
    robot->position.x++;
    break;
  case DIRECTION_SOUTH:
    robot->position.y--;
    break;
  case DIRECTION_WEST:
    robot->position.x--;
    break;
  default:
    break;
  }
}