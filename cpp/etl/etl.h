#include <cctype>
#include <map>
#include <vector>

#if !defined(ETL_H)
#define ETL_H

namespace etl {

std::map<char, int> transform(const std::map<int, std::vector<char>> &old);

} // namespace etl

#endif // ETL_H