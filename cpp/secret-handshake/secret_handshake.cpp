#include "secret_handshake.h"

namespace secret_handshake {

using action_and_code = std::pair<std::string, int>;

bool should_do_action(action_and_code action, int code) {
  return (action.second & code);
}

std::vector<std::string> commands(int code) {
  const std::vector<action_and_code> normal_commands{
      {"wink", 1}, {"double blink", 2}, {"close your eyes", 4}, {"jump", 8}};
  const action_and_code reverse_order = {"reverse handshake commands order", 16};
  std::vector<std::string> commands;

  for (action_and_code action : normal_commands) {
    if (should_do_action(action, code)) {
      commands.push_back(action.first);
    }
  }

  if (should_do_action(reverse_order, code)) {
    std::reverse(commands.begin(), commands.end());
  }
  return commands;
}

} // namespace secret_handshake
