# WCA Chat Command Cookbook - Go

this repo target to share potential use case and prompt on granite-code models.

## prerequisite

- get an API KEY for watsonx Code Assistant

- you can leverage the [sample code provided](../sample/golang/)

## tips

### tips for WCA

- new a chat session, it help to get clear context and better outcome.
- simple instruction works fine, hence make it simple
- the output is quite consistent

## sample go

[good example](../sample/go/sample.go)

[bad example](../sample/go/bad.go)

## use cases

### 1. Code Explanation

- chat in WCA

```text
/explain @sample.go
```

- sample output

```markdown
This code is a Go program that creates a worker pool to process tasks concurrently. The program defines a Worker struct with an ID, a channel for tasks, a channel for completion signals, and a sync.WaitGroup to wait for all tasks to be completed.

The NewWorker function creates a new worker with the given ID, tasks channel, and completion signal channel.

The Start method of the Worker struct starts a goroutine for each task received from the tasks channel. The goroutine simulates task processing time by sleeping for 1 second and then prints a message indicating the worker's ID and the task it is processing.

The Stop method of the Worker struct closes the completion signal channel and waits for all tasks to be completed using the sync.WaitGroup.

In the main function, a tasks channel and a done channel are created. Five workers are created with unique IDs and assigned the tasks channel and done channel. The tasks channel is populated with 10 tasks, and then closed. The main function waits for all workers to finish by receiving from the done channel. Finally, a message is printed indicating that all tasks have been completed.
```

### 2. Generate Documentation

- chat input in WCA

```text
/document @sample.go
```

- sample output

```go
# Assisted by watsonx Code Assistant 
//blob
// Assisted by watsonx Code Assistant 
// NewWorker creates a new worker with the given ID, tasks channel, and done channel.
func NewWorker(id int, tasks chan int, done chan struct{}) *Worker {
	return &Worker{
		ID:    id,
		tasks: tasks,
		done:  done,
		wg:    sync.WaitGroup{},
	}
}

// Start starts the worker by processing tasks from the tasks channel.
func (w *Worker) Start() {
	for task := range w.tasks {
		w.wg.Add(1)
		go func(task int) {
			defer w.wg.Done()
			fmt.Printf("Worker %d processing task %d\n", w.ID, task)
			// Simulate task processing time
			time.Sleep(1 * time.Second)
			fmt.Printf("Worker %d finished task %d\n", w.ID, task)
		}(task)
	}
}

// Stop stops the worker by closing the done channel and waiting for all tasks to finish.
func (w *Worker) Stop() {
	close(w.done)
	w.wg.Wait()
}
```


### 3. Code Translate

- chat in WCA

```text
/translate to csharp, @sample.go
```

- sample output

```csharp
// Assisted by watsonx Code Assistant 
// watsonx Code Assistant did not check whether this code suggestion might be similar to third party code.
using System;
using System.Threading;

namespace WorkerPoolExample
{
    class Worker
    {
        private int id;
        private Queue<int> tasks;
        private ManualResetEvent done;
        private ManualResetEventSlim wg;

        public Worker(int id, Queue<int> tasks, ManualResetEvent done)
        {
            this.id = id;
            this.tasks = tasks;
            this.done = done;
            this.wg = new ManualResetEventSlim();
        }

        public void Start()
        {
            while (true)
            {
                if (tasks.Count == 0)
                {
                    done.Set();
                    return;
                }
                int task = tasks.Dequeue();
                wg.Wait();
                wg.Reset();
                Console.WriteLine($"Worker {id} processing task {task}");
                Thread.Sleep(1000);
                Console.WriteLine($"Worker {id} finished task {task}");
                wg.Set();
            }
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            Queue<int> tasks = new Queue<int>();
            for (int i = 1; i <= 10; i++)
            {
                tasks.Enqueue(i);
            }
            ManualResetEvent done = new ManualResetEvent(false);
            Worker[] workers = new Worker[5];
            for (int i = 0; i < 5; i++)
            {
                workers[i] = new Worker(i + 1, tasks, done);
                workers[i].Start();
            }
            done.WaitOne();
            Console.WriteLine("All tasks completed");
        }
    }
}
```


### 4. Test Case Generation

- chat in WCA

```text
/unit-test @sample.go
```

- sample output

```go
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
		t.Errorf("Expected tasks channel, got %v", worker.tasks)
	}
	if worker.done != done {
		t.Errorf("Expected done channel, got %v", worker.done)
	}
}

func TestWorkerStart(t *testing.T) {
	tasks := make(chan int, 10)
	done := make(chan struct{})
	worker := NewWorker(1, tasks, done)
	go worker.Start()
	tasks <- 1
	time.Sleep(100 * time.Millisecond)
	if len(tasks) != 0 {
		t.Errorf("Expected tasks channel to be empty, got %v", tasks)
	}
	if len(done) != 0 {
		t.Errorf("Expected done channel to be empty, got %v", done)
	}
}

func TestWorkerStop(t *testing.T) {
	tasks := make(chan int, 10)
	done := make(chan struct{})
	worker := NewWorker(1, tasks, done)
	go worker.Start()
	tasks <- 1
	time.Sleep(100 * time.Millisecond)
	worker.Stop()
	if len(tasks) != 0 {
		t.Errorf("Expected tasks channel to be empty, got %v", tasks)
	}
	if len(done) != 1 {
		t.Errorf("Expected done channel to have 1 element, got %v", done)
	}
}

```

### 5. Review Code

- chat input in WCA

```text
review @sample.go
```

- sample output

```text
Sure, I can review the sample.go code. Here are some observations:

The code defines a Worker struct with an ID, tasks channel, done channel, and a WaitGroup.
The NewWorker function creates a new Worker instance and returns it.
The Start method of the Worker struct starts a goroutine for each task received from the tasks channel.
The Stop method of the Worker struct closes the done channel and waits for all goroutines to finish using the WaitGroup.
In the main function, tasks and done channels are created, and 5 workers are created with their respective tasks and done channels.
Tasks are sent to the workers through the tasks channel, and after all tasks are sent, the tasks channel is closed.
The main function waits for all workers to finish by receiving from the done channel.
Finally, the main function prints "All tasks completed" once all tasks are completed.
Overall, the code seems to be a simple implementation of a worker pool pattern using a channel-based approach. It demonstrates how to create and manage multiple workers to process tasks concurrently.
```


### 6. Fix code

- chat in WCA

```text
fix @bad.go
```

- sample output


```go
// Assisted by watsonx Code Assistant 
//bad.go
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
			defer w.wg.Done()
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
		worker := NewWorker(i, tasks, done)
		worker.Start()
	}

	// Send tasks to workers
	for i := 1; i <= 10; i++ {
		tasks <- i
	}

	// Close tasks channel and wait for all workers to finish
	close(tasks)
	for i := 1; i <= 5; i++ {
		<-done
	}

	fmt.Println("All tasks completed")
}
```

### 7. Generate Diagram

- chat in WCA

```text
generate mermaid diagram @sample.go
```

- sample output

```mermaid
// Assisted by watsonx Code Assistant 
// watsonx Code Assistant did not check whether this code suggestion might be similar to third party code.
sequenceDiagram
autonumber
title Sample Go Program

Note over Client: Submits 10 tasks to workers
Client->>+Worker: Submit task 1
Client->>+Worker: Submit task 2
Client->>+Worker: Submit task 3
Client->>+Worker: Submit task 4
Client->>+Worker: Submit task 5
Client->>+Worker: Submit task 6
Client->>+Worker: Submit task 7
Client->>+Worker: Submit task 8
Client->>+Worker: Submit task 9
Client->>+Worker: Submit task 10
Worker->>Client: Finished task 1
Worker->>Client: Finished task 2
Worker->>Client: Finished task 3
Worker->>Client: Finished task 4
Worker->>Client: Finished task 5
Worker->>Client: Finished task 6
Worker->>Client: Finished task 7
Worker->>Client: Finished task 8
Worker->>Client: Finished task 9
Worker->>Client: Finished task 10
Note over Client: All tasks completed
```

### 10. Interface Generation

- chat in WCA

```text
generate go interface @sample.go
```

```go

```

### 11. Build and Deployment Scipt Generation

- chat in WCA

```text
generate build and deployment script for @sample.go
```

- sample output

```bash
// Assisted by watsonx Code Assistant 
#!/bin/bash

# Build the sample.go program
go build sample.go

# Run the sample.go program
./sample

# Clean up the build artifacts
rm sample
```
