//! Module iters contains all the iterators (structs) necessary to execute
//! the algorithms for lazy execution of list operations, as requested by
//! the exercise.
mod appender;
mod concater;
mod filtering;
mod mapper;
mod reversed;

pub(crate) use appender::Appended;
pub(crate) use concater::Concated;
pub(crate) use filtering::Filtered;
pub(crate) use mapper::Mapper;
pub(crate) use reversed::Reversed;
