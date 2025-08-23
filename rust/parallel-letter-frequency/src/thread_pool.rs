//! This module provides a simple, round-robin thread pool implementation.
//!
//! The `ThreadPool` can spawn a fixed number of worker threads and distribute
//! tasks to them via message passing.
use std::{
    sync::mpsc::{self, Sender},
    thread,
};

/// A thread pool that can execute tasks in parallel.
///
/// The pool manages a fixed number of worker threads and dispatches tasks to
/// them in a round-robin fashion.
pub(crate) struct ThreadPool<F: FnOnce() + 'static + Send> {
    accepting_new_tasks: bool,
    current_worker: usize,
    workers_senders: Vec<Sender<F>>,
}

impl<F: FnOnce() + 'static + Send> ThreadPool<F> {
    /// Creates a new `ThreadPool` with a specified number of worker threads.
    ///
    /// This is the public constructor for the thread pool. It creates an internal
    /// pool and spawns the required number of workers.
    pub(crate) fn with(workers_count: usize) -> Self {
        let mut pool = ThreadPool::new();

        (0..workers_count).for_each(|_| pool.spawn_worker());

        pool
    }

    /// Adds a new task to the thread pool for execution.
    ///
    /// The task is sent to the next available worker thread in the pool.
    pub(crate) fn add_task(&mut self, task: F) {
        if self.accepting_new_tasks {
            self.workers_senders[self.current_worker].send(task).unwrap();
            self.current_worker = (self.current_worker + 1) % self.workers_senders.len();
        }
    }

    /// Stops the thread pool from accepting new tasks.
    ///
    /// Once this method is called, no new tasks can be added to the pool.
    pub(crate) fn finish(&mut self) {
        self.accepting_new_tasks = false;
    }

    /// Spawns a new worker thread and adds its sender to the pool.
    ///
    /// Each worker thread runs in an infinite loop, waiting to receive and execute tasks.
    fn spawn_worker(&mut self) {
        let (sender, receiver) = mpsc::channel();
        self.workers_senders.push(sender);

        thread::spawn(move || {
            loop {
                let task = receiver.recv().unwrap();
                task();
            }
        });
    }

    /// A private, default constructor for `ThreadPool`.
    fn new() -> Self {
        Self {
            accepting_new_tasks: true,
            current_worker: 0,
            workers_senders: Vec::new(),
        }
    }
}