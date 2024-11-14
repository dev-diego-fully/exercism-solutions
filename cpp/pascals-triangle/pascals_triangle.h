#include <cstddef>
#include <vector>

#if !defined(PASCALS_TRIANGLE_H)
#define PASCALS_TRIANGLE_H

namespace pascals_triangle {

std::vector<std::vector<int>> generate_rows(int number);

} // namespace pascals_triangle

#endif // PASCALS_TRIANGLE_H