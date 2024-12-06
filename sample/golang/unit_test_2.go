// Assisted by watsonx Code Assistant 
package main

import (
	"testing"
	"time"
)

func TestNewWorker(t *testing.T) {
	tasks := make(chan int, 10)
	done := make(chan struct{})
	worker := NewWorker(1, tasks, done)

	if worker.ID != 1 {
		t.Errorf("Expected worker ID 1, got %d", worker.ID)
	}
	if worker.tasks != tasks {
		t.Errorf("Expected tasks channel to be %v, got %v", tasks, worker.tasks)
	}
	if worker.done != done {
		t.Errorf("Expected done channel to be %v, got %v", done)
	}
}

func TestWorkerStart(t *testing.T) {
	tasks := make(chan int, 10)
	done := make(chan struct{})
	worker := NewWorker(1, tasks, done)

	go worker.Start()

	// Send a task
	tasks <- 1
	close(tasks)

	select {
	case <-done:
		// Success: Worker processed task and signaled done
	case <-time.After(1 * time.Second):
		t.Errorf("Worker did not signal done in time")
	}
}

func TestWorkerStop(t *testing.T) {
	tasks := make(chan int, 10)
	done := make(chan struct{})
	worker := NewWorker(1, tasks, done)

	go worker.Start()

	// Send a task
	tasks <- 1

	// Stop the worker
	close(tasks)
	worker.Stop()

	// Check if done channel was signaled
	select {
	case <-done:
		// Success: Worker completed tasks
	case <-time.After(1 * time.Second):
		t.Errorf("Worker did not signal done in time")
	}
}
