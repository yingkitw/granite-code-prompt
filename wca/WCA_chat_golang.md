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
Please provide a detailed explanation for the following java code @filename
```

- sample output

```markdown
This code is a Go program that creates a worker pool to process tasks concurrently. The program defines a Worker struct that represents a worker in the pool. The Worker has an ID, a channel to receive tasks, a channel to signal completion, and a sync.WaitGroup to wait for all tasks to be completed.

The NewWorker function creates a new worker with the given ID, tasks channel, and done channel. The Start method of the Worker starts a goroutine for each task received from the tasks channel. The goroutine simulates task processing time by sleeping for 1 second and then prints a message indicating the worker's ID and the completed task.

The Stop method of the Worker closes the done channel and waits for all tasks to be completed using the sync.WaitGroup.

In the main function, the program creates a tasks channel, a done channel, and 5 workers with unique IDs. Each worker is started as a goroutine and sends tasks to the tasks channel. After sending all tasks, the tasks channel is closed, and the done channel is used to wait for all workers to finish. Finally, a message is printed to indicate that all tasks have been completed.
```

### 2. Generate Documentation

- chat input in WCA

```text
/document @filename
```

- sample output

```go
# Assisted by watsonx Code Assistant 
//blob
package main

import (
	"fmt"
	"sync"
	"time"
)

// Worker represents a worker in the worker pool.
type Worker struct {
	ID    int
	tasks chan int
	done  chan struct{}
	wg    sync.WaitGroup
}

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

func main() {
	tasks := make(chan int, 10)
	done := make(chan struct{})
	for i := 1; i <= 5; i++ {
		worker := NewWorker(i, tasks, done)
		go worker.Start()
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


### 3. Code Translate

- chat in WCA

```text
/translate to csharp, @filename
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
/unit-test @filename
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
/review @filename
```

- sample output

```text

```


### 6. Fix code

- chat in WCA

```text
/fix @filename
```

- sample output


```go

```

### 7. Generate Diagram

- chat in WCA

```text
generate mermaid diagram for the go code provided. @filename
```

- sample output

```mermaid

```

### 10. Interface Generation

- chat in WCA

```text
generate go interface version base on the go code provided. @filename
```

```go

```

### 11. Build and Deployment Scipt Generation

- chat in WCA

```text
generate build and deployment script for @filename
```

- sample output

```bash

```