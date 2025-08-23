//! This module contains the high-level logic for parallel letter frequency counting.
//!
//! It orchestrates the creation of a thread pool, dispatches counting tasks for each
//! input string, and merges the results received from the worker threads.
mod letter_counting;
mod thread_pool;

use std::sync::mpsc::{self, Receiver};

use thread_pool::ThreadPool;
use letter_counting::{CharCounter, count_letter_frequency, merge_counters};

/// Counts the frequency of alphabetic characters in a collection of strings in parallel.
///
/// This is the main entry point for the frequency counting operation. It distributes
/// the counting work among a specified number of worker threads and then merges
/// their individual results into a single final counter.
pub fn frequency(input: &[&str], workers: usize) -> CharCounter {
    let counts_output = run_parallel_counts(input, workers);

    merge_parallel_counts(input.len(), &counts_output)
}

/// Dispatches counting tasks to a thread pool and returns a receiver channel for the results.
///
/// For each string in the input slice, a counting task is sent to a worker thread.
/// The `freq_sender` is used to send the results back to the main thread.
fn run_parallel_counts(input: &[&str], workers: usize) -> Receiver<CharCounter> {
    let (freq_sender, freq_receiver) = mpsc::channel();
    let mut workers = ThreadPool::with(workers);

    for &string in input.iter() {
        let s = freq_sender.clone();
        let st = string.to_string();
        workers.add_task(move || {
            s.send(count_letter_frequency(st)).unwrap();
        });
    }

    workers.finish();

    freq_receiver
}

/// Merges the letter frequency counters received from the worker threads.
///
/// This function waits for results from the `counts_yielder` channel and
/// merges them sequentially into a single `CharCounter`. It expects to receive
/// a number of results equal to `total_counts`.
fn merge_parallel_counts(
    total_counts: usize,
    counts_yielder: &Receiver<CharCounter>,
) -> CharCounter {
    let mut counter = CharCounter::new();

    for _ in 0..total_counts {
        counter = merge_counters(counter, counts_yielder.recv().unwrap());
    }

    counter
}