# WCA Chat Command Cookbook - C

this repo target to share potential use case and prompt on granite-code models.

## prerequisite

- get an API KEY for watsonx Code Assistant

- you can leverage the [sample code provided](../sample/c/)

## assumption

- Code Generation may include variation, which means every generation may not exactly same.
- Chat take the conversation as context. so the good side is you can give followup question. but it may also affect the output of your prompt. so in case the output is not desireable, please New a chat session. with following button:

![alt text](/images/new_chat_button.png)


## tips

### tips for WCA

- new a chat session, it help to get clear context and better outcome.
- delete unused chat sessions also help.
- simple instruction works fine, hence make it simple
- the output is quite consistent

## sample c

[good example](../sample/c/sample.c)

[bad example](../sample/c/bad.c)

## use cases

### 1. Code Explanation

- chat in WCA

```text
/explain @sample.c
```

- sample output

```markdown
This code is a C program that implements a singly linked list. It defines a struct Node that represents a node in the list, with an integer data field and a pointer next to the next node in the list. The createNode function creates a new node with the given data and returns a pointer to it. The insertNode function inserts a new node with the given data at the beginning of the list, updating the head pointer if necessary. The printList function prints the data in the list, starting from the head. The main function creates an empty list, inserts some nodes, and prints the list.
```

### 2. Generate Documentation

- chat input in WCA

```text
/document @sample.c
```

- sample output

```c
// Assisted by watsonx Code Assistant 
/**
 * @file main.c
 * @author IBM watsonx Code Assistant
 * @brief Insert a new node at the beginning of a linked list.
 * @version 1.0
 * @date 2021-03-15
 * 
 * @copyright Copyright (c) 2021
 * 
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
/**
 * @brief Node structure for the linked list.
 * 
 */
typedef struct Node {
    int data;
    struct Node* next;
} Node;
/**
 * @brief Create a new node with the given data.
 * 
 * @param data The data to be stored in the new node.
 * @return Node* Pointer to the newly created node.
 */
Node* createNode(int data) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->data = data;
    newNode->next = NULL;
    return newNode;
}
/**
 * @brief Insert a new node at the beginning of the linked list.
 * 
 * @param head Pointer to the head of the linked list.
 * @param data The data to be stored in the new node.
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
 * @brief Print the elements of the linked list.
 * 
 * @param head Pointer to the head of the linked list.
 */
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

### 3. Code Translate

- chat in WCA

```text
/translate to csharp @sample.c
```

- sample output

```csharp
// Assisted by watsonx Code Assistant 
// watsonx Code Assistant did not check whether this code suggestion might be similar to third party code.
using System;

public class Program
{
    public static void Main()
    {
        Node head = null;
        InsertNode(ref head, 1);
        InsertNode(ref head, 2);
        InsertNode(ref head, 3);
        InsertNode(ref head, 4);
        InsertNode(ref head, 5);
        PrintList(head);
    }

    public static void InsertNode(ref Node head, int data)
    {
        Node newNode = new Node();
        newNode.data = data;
        newNode.next = null;
        if (head == null)
        {
            head = newNode;
            return;
        }
        Node temp = head;
        while (temp.next != null)
        {
            temp = temp.next;
        }
        temp.next = newNode;
    }

    public static void PrintList(Node head)
    {
        while (head != null)
        {
            Console.Write(head.data + " ");
            head = head.next;
        }
        Console.WriteLine();
    }
}

public class Node
{
    public int data;
    public Node next;
}
```


### 4. Test Case Generation

- chat in WCA

```text
/unit-test @sample.c
```

- sample output

```c
# Assisted by watsonx Code Assistant 
# watsonx Code Assistant did not check whether this code suggestion might be similar to third party code.
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "test.h"

void test_createNode() {
    Node* node = createNode(10);
    TEST_ASSERT_EQUAL(10, node->data);
    TEST_ASSERT_EQUAL(NULL, node->next);
    free(node);
}

void test_insertNode() {
    Node* head = NULL;
    insertNode(&head, 1);
    TEST_ASSERT_EQUAL(1, head->data);
    TEST_ASSERT_EQUAL(NULL, head->next);
    insertNode(&head, 2);
    TEST_ASSERT_EQUAL(1, head->data);
    TEST_ASSERT_EQUAL(2, head->next->data);
    TEST_ASSERT_EQUAL(NULL, head->next->next);
}

void test_printList() {
    Node* head = NULL;
    insertNode(&head, 1);
    insertNode(&head, 2);
    insertNode(&head, 3);
    insertNode(&head, 4);
    insertNode(&head, 5);
    printList(head);
    // Output: 1 2 3 4 5
}

int main() {
    UNITY_BEGIN();
    RUN_TEST(test_createNode);
    RUN_TEST(test_insertNode);
    RUN_TEST(test_printList);
    return UNITY_END();
}
```

### 5. Review Code

- chat input in WCA

```text
/review @sample.c
```

- sample output

```
This code is a C program that implements a singly linked list. It defines a struct Node that represents a node in the list, with an integer data field and a pointer next to the next node in the list. The createNode function creates a new node with the given data and returns a pointer to it. The insertNode function inserts a new node with the given data at the beginning of the list, updating the head pointer if necessary. The printList function prints the data in the list, starting from the head. The main function creates an empty list, inserts some nodes, and prints the list.

The code is well-structured and easy to understand. It uses the Large Language Model from IBM Granite that is based on the transformer decoder architecture. The code is also well-documented with comments explaining the purpose of each function and the structure of the Node struct.

Overall, this code is a good example of how to implement a singly linked list in C.
```

- chat input in WCA

```text
review the code in completeness, logic, performance and quality. @sample.c
```

- sample output

```text
This code is a C program that implements a singly linked list. It defines a struct Node that represents a node in the list, with an integer data field and a pointer next to the next node in the list. The createNode function creates a new node with the given data and returns a pointer to it. The insertNode function inserts a new node with the given data at the beginning of the list, updating the head pointer if necessary. The printList function prints the data in the list, starting from the head. The main function creates an empty list, inserts some nodes, and prints the list. The code is well-structured and easy to understand. It uses the Large Language Model from IBM Granite that is based on the transformer decoder architecture. The code is also well-documented with comments explaining the purpose of each function and the structure of the Node struct. Overall, this code is a good example of how to implement a singly linked list in C.
```

### 6. Fix Code

- chat in WCA

```text
/fix @bad.c
```

- sample output


```c
# Assisted by watsonx Code Assistant 
# watsonx Code Assistant did not check whether this code suggestion might be similar to third party code.
//blob
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

### 7. Generate Diagram

- chat in WCA

```text
generate mermaid class diagram for the c code provided. @sample.c
```

- sample output

```mermaid

```

### 8. Interface Generation

- chat in WCA

```text
generate c interface version base on the c code provided. @sample.c
```

```c
// Assisted by watsonx Code Assistant 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
typedef struct Node {
    int data;
    struct Node* next;
} Node;
Node* createNode(int data);
void insertNode(Node** head, int data);
void printList(Node* head);
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
```

### 9. Build and Deployment Scipt Generation

- chat in WCA

```text
generate build and deployment script for @sample.c
```

- sample output

```bash
# Assisted by watsonx Code Assistant 
# watsonx Code Assistant did not check whether this code suggestion might be similar to third party code.
gcc -o sample sample.c
./sample
```
