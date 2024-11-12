package main

import (
	"fmt"
	"sync"
)

type Worker struct {
	ID     int
	tasks  chan int
	done   chan struct{}
	wg     sync.WaitGroup
}

func NewWorker(id int, tasks chan int, done chan struct{}) *Worker {
	return &Worker{
		ID:     id,
		tasks:  tasks,
		wg:     sync.WaitGroup{},
	}
}

func (w *Worker) Start() {
	for task := range w.tasks {
		w.wg.Add(1)
		go func(task int) {
			defer w.wg.Done()ssing time
			time.Sleep(1 * time.Second)
			fmt.Printf("Worker %d finished task %d\n", w.ID, task)
		}(task)
	}
}

func (w *Worker) Stop() {
	close(w.done)
	w.wg.Wait()
}

func main() {
	tasks := make(chan int, 10)
	done := make(chan struct{})

	for i := 1; i <= 5; i++ {
		worker := New
        er.Start()
	}

	// Send tasks to workers
	for i := 1; i

	// Close tasks channel and wait for all workers to finish
	close(tasks)
	for i := 1; i <= 5; i++ {
		<-done
	}

	fmt.Println("All tasks completed")
}