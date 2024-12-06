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
		t.Errorf("Expected done channel to be %v, got %v", done, worker.done)
	}
}

func TestWorkerStart(t *testing.T) {
	tasks := make(chan int, 10)
	done := make(chan struct{})
	worker := NewWorker(1, tasks, done)
	go worker.Start()
	tasks <- 1
	time.Sleep(100 * time.Millisecond)
	close(tasks)
	<-done
}

func TestWorkerStop(t *testing.T) {
	tasks := make(chan int, 10)
	done := make(chan struct{})
	worker := NewWorker(1, tasks, done)
	go worker.Start()
	tasks <- 1
	time.Sleep(100 * time.Millisecond)
	worker.Stop()
	time.Sleep(100 * time.Millisecond)
	if len(tasks) != 0 {
		t.Errorf("Expected tasks channel to be empty, got %v", tasks)
	}
	if len(done) != 1 {
		t.Errorf("Expected done channel to have 1 element, got %v", done)
	}
}
