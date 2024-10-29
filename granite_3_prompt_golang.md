# Prompting with IBM Granite 3 Model for Coding Use Cases

I utilising the latest IBM Granite 3 8B Instruct Model for these coding tasks. This model is lightweight and supports a wide range of programming languages, making it ideal for diverse coding needs.
Experiment Objectives
The experiment focuses on several key areas, grouped into Code Understanding and Code Generation:

Code Understanding

- Code Explanation: Break down complex code snippets to make them easier to understand.
- Code Documentation: Automatically generate detailed documentation to keep records up-to-date.
- Code Review: Analyze code for potential improvements and ensure adherence to best practices.

Code Generation

- Code Improvement: Suggest optimizations to enhance efficiency and performance.
- Code Conversion: Translate code between different programming languages.
- Code Fixing: Identify and resolve bugs or errors in existing code.
- API Generation: Automatically create APIs from given specifications.
- Test Case Generation: Develop test cases to ensure code reliability and performance.
- Diagram Generation: Visualize code structure and workflows through generated diagrams.

The experiment will be conducted using sample Golang code to demonstrate these capabilities.

```golang
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
		done:   done,
		wg:     sync.WaitGroup{},
	}
}

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

A few context variable

```python
model_id = GRANITE_3_8B_INSTRUCT
language = "golang"
documentframework = "godoc"
testframework = "testing"
```

Initialise with watsonx.ai, please prepare your API_KEY and PROJECT_ID

```bash
pip install -U ibm-watsonx-ai
```

```python
from ibm_watsonx_ai.foundation_models import ModelInference
from ibm_watsonx_ai.metanames import GenTextParamsMetaNames as GenParams
import os
from dotenv import load_dotenv

load_dotenv()
api_key = os.getenv("API_KEY", None)
project_id = os.getenv("PROJECT_ID", None)

creds = {
    "url"    : "https://us-south.ml.cloud.ibm.com",
    "apikey" : api_key
}

params = {
    GenParams.DECODING_METHOD:"greedy",
    GenParams.MAX_NEW_TOKENS:4000,
    GenParams.MIN_NEW_TOKENS:1,
    # "temperature":0.1,
    GenParams.TOP_K:50,
    GenParams.TOP_P:1,
    GenParams.STOP_SEQUENCES:["```","[/INST]","<|user|>","<|endoftext|>","<|assistant|>"],
}

model = ModelInference(model_id="ibm/granite-3-8b-instruct", credentials=creds, params=params, project_id=project_id)
```

## Code Explanation

Understanding complex code segments is made easier with Granite 3 Model's detailed code explanations. It breaks down intricate code logic into comprehensible language, helping developers to grasp the functionality and purpose of different code sections. This feature is particularly useful for onboarding new team members, debugging, and maintaining large codebases where understanding legacy code is essential.

prompt for Explanation

```python
prompt = f"""<|user|>
Please provide a detailed explanation for the following {language} code:
-ensure have new line after every full stop.

###
code: `{sample_code}`
<|assistant|>
explanation:
"""

answer = model.generate_text(prompt)
print(answer)
```

output for explanation

```markdown
This Go code is a simple example of a worker pool pattern, where multiple workers process tasks concurrently. Here's a detailed explanation:

1. The `Worker` struct represents a worker with an ID, a channel for receiving tasks, a channel for signaling completion, and a `sync.WaitGroup` for waiting on all tasks to finish.

2. The `NewWorker` function creates a new worker with the given ID, tasks channel, and done channel.

3. The `Start` method of the `Worker` struct processes tasks from the tasks channel. For each task, it adds a goroutine to the `sync.WaitGroup`, processes the task (simulating processing time with `time.Sleep`), and then calls `wg.Done()` to signal that the task is finished.

4. The `Stop` method of the `Worker` struct closes the done channel and waits for all tasks to finish using `wg.Wait()`.

5. In the `main` function, a tasks channel and a done channel are created. Five workers are created and started using the `NewWorker` and `Start` functions. Ten tasks are sent to the workers using the tasks channel. After all tasks are sent, the tasks channel is closed, and the main function waits for all workers to finish using the done channel. Finally, a message is printed to indicate that all tasks are completed.

The new line after every full stop in the code is not related to the functionality of the code, but rather a formatting convention to improve readability.
```

## Automatic Documentation Generation

IBM Granite 3 Model automates the creation of comprehensive documentation for your codebase, eliminating the need for manual documentation efforts. By analyzing the code structure and functionality, it generates clear and detailed documentation that is essential for maintaining and scaling projects. This feature ensures that all aspects of the code are well-documented, making it easier for new developers to understand and contribute to the project.

prompt for document generation

```python
prompt = f"""<|user|>
generate {documentframework} document for the {language} provided.
-generate the {language} code only.
{language}: `{sample_code}`
-generate inline comment with code.
<|assistant|>
```{language}"""

answer = model.generate_text(prompt).replace("```","")
print(answer)
```

output for document generation

```golang

// Package main provides a simple example of a worker pool in Go.
// The Worker struct represents a worker that processes tasks from a channel.
// The NewWorker function creates a new worker with the given ID, tasks channel, and done channel.
// The Start method starts processing tasks from the tasks channel.
// The Stop method closes the done channel and waits for all workers to finish.
// The main function creates a worker pool with 5 workers, sends 10 tasks to the workers, and waits for all workers to finish.
package main

import (
	"fmt"
	"sync"
	"time"
)

// Worker represents a worker that processes tasks from a channel.
type Worker struct {
	ID     int
	tasks  chan int
	done   chan struct{}
	wg     sync.WaitGroup
}

// NewWorker creates a new worker with the given ID, tasks channel, and done channel.
func NewWorker(id int, tasks chan int, done chan struct{}) *Worker {
	return &Worker{
		ID:     id,
		tasks:  tasks,
		done:   done,
		wg:     sync.WaitGroup{},
	}
}

// Start starts processing tasks from the tasks channel.
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

// Stop closes the done channel and waits for all workers to finish.
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

## Code Review and Scoring

Granite 3 Model offers automated code reviews that assess the quality of your code against industry standards. It provides scoring mechanisms that highlight areas of strength and identify potential issues, allowing developers to maintain high-quality codebases. This automated review process accelerates the feedback loop, enabling developers to make timely improvements and adhere to best practices without the need for extensive manual code inspections.

prompt for review and score

```python
prompt = f"""<|user|>
you are {language} expert. you need to review the following {language} code. 
-please understand the {language} code provided in detail.
-please review the code in completeness, logic, performance and quality.
-make it more object oriented.
-give a score out of 10 for the quality of code.
-please provide constructive suggestion in detail.
-generate the review and suggestion only.
{language} code: `{sample_code}`
-DONT generate the improve code directly.
-dont generate code.
<|assistant|>
score and review:"""

suggestion = model.generate_text(prompt)
print(suggestion)
```

outcome for review and score

```markdown


The provided Go code is a simple implementation of a worker pool using goroutines and channels. It creates a specified number of workers, each processing tasks from a shared channel. The code is generally well-structured and easy to understand, but there are some areas for improvement in terms of object-oriented design, error handling, and performance.

Here's a detailed review and suggestions for improvement:

1. Object-oriented design:
   - The `Worker` struct is a good start, but it could be improved by adding methods for task processing and error handling.
   - Consider creating a `Task` struct to encapsulate task-related data and behavior.
   - Add a `ProcessTask` method to the `Worker` struct to handle task processing logic.

2. Error handling:
   - The code currently lacks error handling. For example, there's no error checking when creating goroutines or when processing tasks.
   - Add error handling to make the code more robust and easier to debug.

3. Performance:
   - The code uses a `sync.WaitGroup` to wait for all workers to finish. This can lead to unnecessary context switching and reduced performance.
   - Consider using a `sync.Pool` to reuse worker goroutines instead of creating new ones for each task.

4. Code quality:
   - The code could benefit from more comments and documentation to improve readability and maintainability.
   - Use consistent naming conventions for variables and functions.

5. Suggestions:
   - Refactor the code to use the `Task` struct and the `ProcessTask` method.
   - Add error handling to the `Start` and `ProcessTask` methods.
   - Implement a `sync.Pool` to reuse worker goroutines.
   - Add more comments and documentation to improve code quality.

Overall, the code is a good starting point, but there's room for improvement in terms of object-oriented design, error handling, and performance. By addressing these areas, the code can become more robust, maintainable, and efficient.

Score: 6/10 (based on completeness, logic, performance, and quality)
```

## Enhancement Based on Reviews

Leveraging the feedback from automated code reviews, the Granite 3 Model facilitates continuous improvement of your codebase. It suggests specific enhancements to optimize performance, improve maintainability, and increase readability. By acting on these insights, developers can refine their code systematically, ensuring that the software remains robust and efficient as it evolves.

Prompt for improvement

```python
prompt = f"""<|user|>
improve the {language} provided base on the review provided.
-understand the review suggestion in detail.
-adopt the review suggestion if applicable.
-dont generate explanation.
###
original {language} code: `{sample_code}`
review suggestion: `{suggestion}`
<|assistant|>
improved {language}
```{language}"""

answer = model.generate_text(prompt).replace("```","")
print(answer)
```

Output for improvement

```golang

package main

import (
	"fmt"
	"sync"
	"time"
)

type Task struct {
	ID     int
	data   interface{}
}

type Worker struct {
	ID     int
	tasks  chan Task
	done   chan struct{}
	pool   sync.Pool
	wg     sync.WaitGroup
}

func NewWorker(id int, tasks chan Task, done chan struct{}) *Worker {
	return &Worker{
		ID:     id,
		tasks:  tasks,
		done:   done,
		pool:   sync.Pool{New: func() interface{} { return NewWorker(id, tasks, done) }},
		wg:     sync.WaitGroup{},
	}
}

func (w *Worker) Start() {
	for task := range w.tasks {
		w.wg.Add(1)
		go func(task Task) {
			defer w.wg.Done()
			err := w.ProcessTask(task)
			if err != nil {
				fmt.Printf("Worker %d failed to process task %d: %v\n", w.ID, task.ID, err)
			}
		}(task)
	}
}

func (w *Worker) ProcessTask(task Task) error {
	fmt.Printf("Worker %d processing task %d with data: %v\n", w.ID, task.ID, task.data)
	// Simulate task processing time
	time.Sleep(1 * time.Second)
	fmt.Printf("Worker %d finished task %d\n", w.ID, task.ID)
	return nil
}

func (w *Worker) Stop() {
	close(w.done)
	w.wg.Wait()
	w.pool.Put(w)
}

func main() {
	tasks := make(chan Task, 10)
	done := make(chan struct{})

	for i := 1; i <= 5; i++ {
		worker := NewWorker(i, tasks, done)
		go worker.Start()
	}

	// Send tasks to workers
	for i := 1; i <= 10; i++ {
		tasks <- Task{ID: i, data: nil}
	}

	// Close tasks channel and wait for all workers to finish
	close(tasks)
	for i := 1; i <= 5; i++ {
		<-done
	}

	fmt.Println("All tasks completed")
}
```

## Error Identification and Fixing

The Granite 3 Model excels at identifying and rectifying errors in your code. It efficiently locates potential syntax errors andlogical flaws. By analyzing the code, it proposes fixes and improvements, offering developers an initial draft to consider. This feature streamlines the debugging process, enabling developers to focus on verification and testing, ensuring robust code.

Problem Code

```golang
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
```

Prompt for Fixing

```python
prompt = f"""<|user|>
fix the {language} provided.
-understand the review suggestion in detail.
-identify if any problem.
-fix the problem if any.
-add explanation as inline comment.

###
{language}: `{bad_code}`
<|assistant|>
fixed version with inline comment at the point it fix.
```{language}"""

answer = model.generate_text(prompt).replace("```","")
print(answer)
```

Output for Fixing

```golang

package main

import (
	"fmt"
	"sync"
	"time"
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
		done:   done, // add done channel to Worker struct
	}
}

func (w *Worker) Start() {
	for task := range w.tasks {
		w.wg.Add(1) // increment wait group counter
		go func(task int) {
			defer w.wg.Done() // decrement wait group counter when done
			time.Sleep(1 * time.Second) // sleep for 1 second
			fmt.Printf("Worker %d finished task %d\n", w.ID, task)
		}(task)
	}
}

func (w *Worker) Stop() {
	close(w.done) // close done channel to signal workers to stop
	w.wg.Wait()   // wait for all workers to finish
}

func main() {
	tasks := make(chan int, 10) // create a buffered channel with capacity 10
	done := make(chan struct{}) // create a done channel

	for i := 1; i <= 5; i++ {
		worker := NewWorker(i, tasks, done) // create a new worker with ID, tasks channel, and done channel
		worker.Start() // start the worker
	}

	// Send tasks to workers
	for i := 1; i <= 10; i++ { // send 10 tasks to workers
		tasks <- i
	}

	// Close tasks channel and wait for all workers to finish
	close(tasks)
	for i := 1; i <= 5; i++ { // wait for all workers to finish
		<-done
	}

	fmt.Println("All tasks completed")
}
```

## Diagram Generation

Understanding complex code structures is made easier with Granite 3 Model's diagram generation capabilities. It automatically creates visual representations of your code architecture, including class diagrams and flowcharts. These diagrams enhance comprehension and improve communication on projects with intricate dependencies.

Prompt for Generate Diagram

```python
prompt = f"""<|user|>
generate diagram for the {language} code provided.
-understand the review suggestion in detail.
-use simple name for node.
-generate in mermaid.
-dont repeating.
-dont generation explanation.
{language}: `{sample_code}`
<|assistant|>
```mermaid"""

answer = model.generate_text(prompt).replace("```","")
print(answer)
```

Output for Generate Diagram

```mermaid
graph TD
A[main] --> B[tasks := make(chan int, 10)]
A --> C[done := make(chan struct{})]
A --> D[for i := 1; i <= 5; i++ { worker := NewWorker(i, tasks, done) go worker.Start() }]
A --> E[for i := 1; i <= 10; i++ { tasks <- i }]
A --> F[close(tasks)]
A --> G[for i := 1; i <= 5; i++ { <-done }]
A --> H[fmt.Println("All tasks completed")]
```

## Code Conversion

Granite 3 Model seamlessly converts code between different programming languages or formats, enhancing compatibility and facilitating cross-platform development. Whether migrating legacy systems to modern languages or adapting code for different environments, this feature ensures that the transition is smooth and error-free. It can supports a wide range of languages, making it a versatile tool for diverse development needs.

Prompt for conversion

```python
target_language = "rust"

prompt = f"""<|user|>
rewrite the {language} code provided to {target_language}.
-understand the code provided in detail.
-understand how to map technology and syntax to the target {target_language} langauge.
-dont generation explanation.
{language}: `{sample_code}`
<|assistant|>
```{target_language}"""

answer = model.generate_text(prompt).replace("```","")
print(answer)
```

Output for conversion

```rust

use std::sync::mpsc;
use std::sync::Arc;
use std::sync::Mutex;
use std::thread;
use std::time::Duration;

struct Worker {
    id: u32,
    tasks: mpsc::Receiver<u32>,
    done: Arc<Mutex<bool>>,
}

impl Worker {
    fn new(id: u32, tasks: mpsc::Receiver<u32>, done: Arc<Mutex<bool>>) -> Self {
        Self { id, tasks, done }
    }

    fn start(&self) {
        for task in self.tasks.iter() {
            let done = self.done.clone();
            thread::spawn(move || {
                println!("Worker {} processing task {}", self.id, task);
                std::thread::sleep(Duration::from_secs(1));
                println!("Worker {} finished task {}", self.id, task);
                *done.lock() = true;
            });
        }
    }

    fn stop(&self) {
        drop(self.tasks);
    }
}

fn main() {
    let (tasks_tx, tasks_rx) = mpsc::channel();
    let done = Arc::new(Mutex::new(false));

    for i in 1..=5 {
        let tasks_tx = tasks_tx.clone();
        let done = done.clone();
        let worker = Worker::new(i, tasks_rx.clone(), done);
        thread::spawn(move || {
            worker.start();
            worker.stop();
        });
    }

    for i in 1..=10 {
        tasks_tx.send(i).unwrap();
    }

    drop(tasks_tx);

    while !*done.lock() {
        std::thread::sleep(Duration::from_millis(100));
    }

    println!("All tasks completed");
}
```

## API Generation

Automating the creation of APIs, Granite 3 Model accelerates the integration of your codebase with external systems. It generates well-structured and documented APIs based on your existing code, facilitating seamless communication and data exchange between different software components. This feature is particularly beneficial for developing scalable and interoperable applications that require robust API interfaces.

Prompt for API Generation

```python
prompt = f"""<|user|>
generate a API definition in swagger for the {language} code provided.
-dont generate explanation.
{language}: `{sample_code}`
<|assistant|>
```yaml
"""

answer = model.generate_text(prompt).replace("```","")
print(answer)
```

Output for API Generation

```yaml
openapi: 3.0.0
info:
  title: Worker API
  version: 1.0.0
servers:
  - url: http://localhost:8080/api
paths:
  /start:
    post:
      summary: Start a new worker
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              properties:
                id:
                  type: integer
                  minimum: 1
                tasks:
                  type: array
                  items:
                    type: integer
                  minItems: 1
                  maxItems: 10
                done:
                  type: array
                  items:
                    type: string
                  minItems: 1
                  maxItems: 5
      responses:
        '200':
          description: Worker started successfully
/stop:
  post:
    summary: Stop a worker
    requestBody:
      required: true
      content:
        application/json:
          schema:
            type: object
            properties:
              id:
                type: integer
                minimum: 1
              done:
                type: array
                items:
                  type: string
                minItems: 1
                maxItems: 5
    responses:
      '200':
        description: Worker stopped successfully
```

## Test Case Generation

Ensuring thorough testing is essential for reliable software development. Granite 3 Model automatically generates relevant test cases for your code, covering various scenarios and edge cases. This acceleration of the testing phase helps in identifying potential issues early, ensuring that the code performs as expected and meets the required quality standards before deployment.

Prompt for Test Case

```python
prompt = f"""<|user|>
generate Test Cases in {testframework} for the {language} code provided.
-focus on boundary cases.
-focus on exception handling
-generate the test only.
{language}: `{sample_code}`
<|assistant|>
```{language}"""

answer = model.generate_text(prompt).replace("```","")
print(answer)
```

Output for Test Case

```golang

package main

import (
	"fmt"
	"sync"
	"testing"
	"time"
)

func TestWorker_Start(t *testing.T) {
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

	// Check if all tasks are processed
	for i := 1; i <= 10; i++ {
		select {
		case <-done:
			continue
		default:
			t.Errorf("Task %d not processed", i)
		}
	}
}

func TestWorker_Stop(t *testing.T) {
	tasks := make(chan int, 10)
	done := make(chan struct{})

	worker := NewWorker(1, tasks, done)
	go worker.Start()

	// Stop worker before any tasks are processed
	worker.Stop()

	// Check if done channel is closed
	select {
	case <-done:
	default:
		t.Error("Done channel not closed")
	}
}

func TestWorker_Start_EmptyTasks(t *testing.T) {
	tasks := make(chan int, 10)
	done := make(chan struct{})

	worker := NewWorker(1, tasks, done)
	go worker.Start()

	// Stop worker before any tasks are processed
	worker.Stop()

	// Check if done channel is closed
	select {
	case <-done:
	default:
		t.Error("Done channel not closed")
	}
}

func TestWorker_Start_LargeTasks(t *testing.T) {
	tasks := make(chan int, 100000)
	done := make(chan struct{})

	worker := NewWorker(1, tasks, done)
	go worker.Start()

	// Send large number of tasks to worker
	for i := 1; i <= 100000; i++ {
		tasks <- i
	}

	// Close tasks channel and wait for all workers to finish
	close(tasks)
	for i := 1; i <= 5; i++ {
		<-done
	}

	// Check if all tasks are processed
	for i := 1; i <= 100000; i++ {
		select {
		case <-done:
			continue
		default:
			t.Errorf("Task %d not processed", i)
		}
	}
}

func TestWorker_Start_ExceptionHandling(t *testing.T) {
	tasks := make(chan int, 10)
	done := make(chan struct{})

	worker := NewWorker(1, tasks, done)
	go worker.Start()

	// Send exceptional task to worker
	tasks <- -1

	// Close tasks channel and wait for all workers to finish
	close(tasks)
	for i := 1; i <= 5; i++ {
		<-done
	}

	// Check if exception is handled
	select {
	case <-done:
	default:
		t.Error("Exception not handled")
	}
}
```
