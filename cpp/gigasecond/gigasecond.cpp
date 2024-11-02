#include "gigasecond.h"

namespace gigasecond {

ptime advance(ptime time) {
  const int giga = 1e9;
  const seconds gigasecond = boost::posix_time::seconds(giga);
  return time + gigasecond;
}

} // namespace gigasecond
