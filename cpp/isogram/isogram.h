#include <map>
#include <string>
#include <cctype>

#if !defined(ISOGRAM_H)
#define ISOGRAM_H

namespace isogram {

bool is_isogram(const std::string &input);

} // namespace isogram

#endif // ISOGRAM_H