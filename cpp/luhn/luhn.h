#if !defined(LUHN_H)
#define LUHN_H

#include <string>
#include <cctype>

namespace luhn {

bool valid(const std::string number);

}  // namespace luhn

#endif // LUHN_H