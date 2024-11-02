#include "boost/date_time/posix_time/posix_time.hpp"
#if !defined(GIGASECOND_H)
#define GIGASECOND_H

using boost::posix_time::ptime;
using boost::posix_time::seconds;

namespace gigasecond {

ptime advance(ptime time);

} // namespace gigasecond

#endif // GIGASECOND_H