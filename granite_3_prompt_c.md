# Prompting with IBM Granite 3 Model for Coding Use Cases

The experiment will be conducted using sample C code to demonstrate these capabilities.

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Node {
    int data;
    struct Node* next;
} Node;

Node* createNode(int data) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->data = data;
    newNode->next = NULL;
    return newNode;
}

void insertNode(Node** head, int data) {
    Node* newNode = createNode(data);
    if (*head == NULL) {
        *head = newNode;
        return;
    }
    Node* temp = *head;
    while (temp->next != NULL) {
        temp = temp->next;
    }
    temp->next = newNode;
}

void printList(Node* head) {
    while (head != NULL) {
        printf("%d ", head->data);
        head = head->next;
    }
    printf("\n");
}

int main() {
    Node* head = NULL;
    insertNode(&head, 1);
    insertNode(&head, 2);
    insertNode(&head, 3);
    insertNode(&head, 4);
    insertNode(&head, 5);
    printList(head);
    return 0;
}
```

A few context variable

```python
model_id = GRANITE_3_8B_INSTRUCT
language = "c"
documentframework = "doxygen"
testframework = "cunit"
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
This C code is a simple implementation of a singly linked list. Here's a breakdown of the code:

1. The code starts by including the necessary libraries: `stdio.h` for input/output operations, `stdlib.h` for memory management functions like `malloc` and `free`, and `string.h` for string manipulation functions.

2. A structure `Node` is defined to represent a node in the linked list. Each node contains an integer `data` and a pointer `next` to the next node in the list.

3. The `createNode` function is defined to create a new node with the given data and return a pointer to it.

4. The `insertNode` function is defined to insert a new node at the end of the linked list. It takes a pointer to the head of the list and the data for the new node as arguments. If the list is empty, it sets the head to the new node. Otherwise, it traverses the list to the end and appends the new node.

5. The `printList` function is defined to print the data of all nodes in the linked list. It takes the head of the list as an argument and traverses the list, printing the data of each node followed by a space. After printing all nodes, it prints a newline character to ensure a new line after every full stop.

6. In the `main` function, a linked list is created and five nodes are inserted into it using the `insertNode` function. Finally, the `printList` function is called to print the data of all nodes in the list.

The code ensures a new line after every full stop by printing a newline character after printing the data of each node in the `printList` function.
```

## Automatic Documentation Generation

IBM Granite 3 Model automates the creation of comprehensive documentation for your codebase, eliminating the need for manual documentation efforts. By analyzing the code structure and functionality, it generates clear and detailed documentation that is essential for maintaining and scaling projects. This feature ensures that all aspects of the code are well-documented, making it easier for new developers to understand and contribute to the project.

prompt for document generation

```python
prompt = f"""<|user|>
generate {documentframework} document for the {language} provided.
-generate the {language} code only.
{language}: `{sample_code}`
<|assistant|>
```{language}"""

answer = model.generate_text(prompt).replace("```","")
print(answer)
```

output for document generation

```c

/**
 * @file linkedlist.c
 * @brief A simple linked list implementation in C.
 *
 * This file contains the implementation of a singly linked list in C.
 * The linked list is implemented using a struct called Node, which contains
 * an integer data field and a pointer to the next Node in the list.
 *
 * @author Your Name
 * @date 2023-03-15
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/**
 * @brief A struct representing a Node in the linked list.
 */
typedef struct Node {
    int data;
    struct Node* next;
} Node;

/**
 * @brief Creates a new Node with the given data and returns a pointer to it.
 *
 * @param data The data to store in the new Node.
 * @return A pointer to the new Node.
 */
Node* createNode(int data) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->data = data;
    newNode->next = NULL;
    return newNode;
}

/**
 * @brief Inserts a new Node with the given data at the end of the linked list.
 *
 * @param head A pointer to the head of the linked list.
 * @param data The data to store in the new Node.
 */
void insertNode(Node** head, int data) {
    Node* newNode = createNode(data);
    if (*head == NULL) {
        *head = newNode;
        return;
    }
    Node* temp = *head;
    while (temp->next != NULL) {
        temp = temp->next;
    }
    temp->next = newNode;
}

/**
 * @brief Prints the data in the linked list.
 *
 * @param head A pointer to the head of the linked list.
 */
void printList(Node* head) {
    while (head != NULL) {
        printf("%d ", head->data);
        head = head->next;
    }
    printf("\n");
}

/**
 * @brief The main function that creates a linked list and prints its data.
 *
 * @return 0 on success, -1 on error.
 */
int main() {
    Node* head = NULL;
    insertNode(&head, 1);
    insertNode(&head, 2);
    insertNode(&head, 3);
    insertNode(&head, 4);
    insertNode(&head, 5);
    printList(head);
    return 0;
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


The provided C code is a simple implementation of a singly linked list. The code is well-structured and easy to understand, with clear function definitions and proper use of pointers. However, there are a few areas that could be improved for better performance and quality.

1. Error handling: The code does not check if the `malloc` function fails to allocate memory. This could lead to unexpected behavior or crashes if memory allocation fails.
2. Memory management: The code does not free the memory allocated for each node when it is no longer needed. This could lead to memory leaks, especially if the linked list is large.
3. Code organization: The code could be better organized by separating the linked list implementation into a separate header file and source file. This would make it easier to reuse the linked list implementation in other projects.
4. Code comments: The code could benefit from more comments to explain the purpose of each function and the overall structure of the program.

Overall, the code is well-written and easy to understand, but there are some areas that could be improved for better performance and quality. I would give this code a score of 7 out of 10.

Suggestions:

1. Add error handling for `malloc` to check if memory allocation fails.
2. Add code to free the memory allocated for each node when it is no longer needed.
3. Separate the linked list implementation into a separate header file and source file.
4. Add more comments to explain the purpose of each function and the overall structure of the program.
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

```c

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Define the Node structure
typedef struct Node {
    int data;
    struct Node* next;
} Node;

// Function to create a new node
Node* createNode(int data) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    if (newNode == NULL) {
        printf("Memory allocation failed\n");
        exit(1);
    }
    newNode->data = data;
    newNode->next = NULL;
    return newNode;
}

// Function to insert a new node at the end of the list
void insertNode(Node** head, int data) {
    Node* newNode = createNode(data);
    if (*head == NULL) {
        *head = newNode;
        return;
    }
    Node* temp = *head;
    while (temp->next != NULL) {
        temp = temp->next;
    }
    temp->next = newNode;
}

// Function to print the linked list
void printList(Node* head) {
    while (head != NULL) {
        printf("%d ", head->data);
        head = head->next;
    }
    printf("\n");
}

// Function to free the memory allocated for the linked list
void freeList(Node* head) {
    Node* temp = head;
    while (temp != NULL) {
        Node* next = temp->next;
        free(temp);
        temp = next;
    }
}

int main() {
    Node* head = NULL;
    insertNode(&head, 1);
    insertNode(&head, 2);
    insertNode(&head, 3);
    insertNode(&head, 4);
    insertNode(&head, 5);
    printList(head);
    freeList(head);
    return 0;
}
```

## Error Identification and Fixing

The Granite 3 Model excels at identifying and rectifying errors in your code. It efficiently locates potential syntax errors andlogical flaws. By analyzing the code, it proposes fixes and improvements, offering developers an initial draft to consider. This feature streamlines the debugging process, enabling developers to focus on verification and testing, ensuring robust code.

Problem Code

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Node {
    int data;
    struct Node* next;
} Node;

Node* createNode(int data) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->data 
    return newNode;
}

void insertNode(Node** head, int data) {
    Node* newNode = createNode(data);
    if (*hea
    }
    Node* temp = *head;
    while (temp->next != NULL) {
        temp = temp->next;
    }
    temp->next = newNode;
}

void printList(Node* head) {
    while (head != NUL
    }
    printf("\n");
}

int main() {
    Node* head = NULL;
    insertNode(&head, 1);
    insertNode(&head, 2);
    insertNode(&head, 3);
    insertNode(&head, 4);
    insertNode(&head, 5);
    printList(head);
    return 0;
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

```c

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Node {
    int data;
    struct Node* next;
} Node;

Node* createNode(int data) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->data = data; // fix: assign data to newNode->data
    return newNode;
}

void insertNode(Node** head, int data) {
    Node* newNode = createNode(data);
    if (*head == NULL) { // fix: check if head is NULL before assigning newNode to it
        *head = newNode;
    } else {
        Node* temp = *head;
        while (temp->next != NULL) {
            temp = temp->next;
        }
        temp->next = newNode;
    }
}

void printList(Node* head) {
    while (head != NULL) { // fix: change NULL to head to avoid infinite loop
        printf("%d ", head->data);
        head = head->next;
    }
    printf("\n");
}

int main() {
    Node* head = NULL;
    insertNode(&head, 1);
    insertNode(&head, 2);
    insertNode(&head, 3);
    insertNode(&head, 4);
    insertNode(&head, 5);
    printList(head);
    return 0;
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
A[main] --> B[createNode(1)]
A --> C[insertNode(&head, 1)]
A --> D[createNode(2)]
A --> E[insertNode(&head, 2)]
A --> F[createNode(3)]
A --> G[insertNode(&head, 3)]
A --> H[createNode(4)]
A --> I[insertNode(&head, 4)]
A --> J[createNode(5)]
A --> K[insertNode(&head, 5)]
A --> L[printList(head)]
```

## Code Conversion

Granite 3 Model seamlessly converts code between different programming languages or formats, enhancing compatibility and facilitating cross-platform development. Whether migrating legacy systems to modern languages or adapting code for different environments, this feature ensures that the transition is smooth and error-free. It can supports a wide range of languages, making it a versatile tool for diverse development needs.

Prompt for conversion

```python
target_language = "python"

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

```python

class Node:
    def __init__(self, data):
        self.data = data
        self.next = None

def create_node(data):
    return Node(data)

def insert_node(head, data):
    new_node = create_node(data)
    if head is None:
        head = new_node
        return
    current = head
    while current.next is not None:
        current = current.next
    current.next = new_node

def print_list(head):
    current = head
    while current is not None:
        print(current.data, end=" ")
        current = current.next
    print()

def main():
    head = None
    insert_node(head, 1)
    insert_node(head, 2)
    insert_node(head, 3)
    insert_node(head, 4)
    insert_node(head, 5)
    print_list(head)

if __name__ == "__main__":
    main()
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
  title: Linked List API
  version: 1.0.0
servers:
  - url: /
paths:
  /insertNode:
    post:
      summary: Insert a new node at the end of the linked list
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              properties:
                data:
                  type: integer
      responses:
        '200':
          description: Node inserted successfully
/printList:
  get:
    summary: Print the linked list
    responses:
      '200':
        description: Linked list printed successfully
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

```c

#include "unity.h"
#include "main.h"

void test_createNode(void) {
    Node* newNode = createNode(10);
    TEST_ASSERT_NOT_NULL(newNode);
    TEST_ASSERT_EQUAL(10, newNode->data);
    TEST_ASSERT_NULL(newNode->next);
    free(newNode);
}

void test_insertNode_emptyList(void) {
    Node* head = NULL;
    insertNode(&head, 1);
    TEST_ASSERT_NOT_NULL(head);
    TEST_ASSERT_EQUAL(1, head->data);
    TEST_ASSERT_NULL(head->next);
}

void test_insertNode_singleElement(void) {
    Node* head = NULL;
    insertNode(&head, 1);
    TEST_ASSERT_NOT_NULL(head);
    TEST_ASSERT_EQUAL(1, head->data);
    TEST_ASSERT_NULL(head->next);
}

void test_insertNode_multipleElements(void) {
    Node* head = NULL;
    insertNode(&head, 1);
    insertNode(&head, 2);
    insertNode(&head, 3);
    TEST_ASSERT_NOT_NULL(head);
    TEST_ASSERT_EQUAL(1, head->data);
    TEST_ASSERT_NOT_NULL(head->next);
    TEST_ASSERT_EQUAL(2, head->next->data);
    TEST_ASSERT_NULL(head->next->next);
}

void test_insertNode_largeData(void) {
    Node* head = NULL;
    insertNode(&head, INT_MAX);
    TEST_ASSERT_NOT_NULL(head);
    TEST_ASSERT_EQUAL(INT_MAX, head->data);
    TEST_ASSERT_NULL(head->next);
}

void test_insertNode_negativeData(void) {
    Node* head = NULL;
    insertNode(&head, INT_MIN);
    TEST_ASSERT_NOT_NULL(head);
    TEST_ASSERT_EQUAL(INT_MIN, head->data);
    TEST_ASSERT_NULL(head->next);
}

void test_insertNode_nullHead(void) {
    Node* head = NULL;
    insertNode(&head, 1);
    TEST_ASSERT_NOT_NULL(head);
    TEST_ASSERT_EQUAL(1, head->data);
    TEST_ASSERT_NULL(head->next);
}

void test_insertNode_nullNext(void) {
    Node* head = NULL;
    insertNode(&head, 1);
    insertNode(&head, 2);
    insertNode(&head, 3);
    insertNode(&head, 4);
    insertNode(&head, 5);
    insertNode(&head, NULL);
    TEST_ASSERT_NOT_NULL(head);
    TEST_ASSERT_EQUAL(1, head->data);
    TEST_ASSERT_NOT_NULL(head->next);
    TEST_ASSERT_EQUAL(2, head->next->data);
    TEST_ASSERT_NULL(head->next->next);
}

void setUp(void) {
    // This function runs before each test
}

void tearDown(void) {
    // This function runs after each test
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_createNode);
    RUN_TEST(test_insertNode_emptyList);
    RUN_TEST(test_insertNode_singleElement);
    RUN_TEST(test_insertNode_multipleElements);
    RUN_TEST(test_insertNode_largeData);
    RUN_TEST(test_insertNode_negativeData);
    RUN_TEST(test_insertNode_nullHead);
    RUN_TEST(test_insertNode_nullNext);
    return UNITY_END();
}
```
