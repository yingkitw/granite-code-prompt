// Assisted by watsonx Code Assistant 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sample.c"
#include "unity.h"

void test_createNode() {
    Node* node = createNode(10);
    if (node == NULL) {
        printf("Failed to create node\n");
        exit(1);
    }
    if (node->data != 10) {
        printf("Node data is incorrect\n");
        exit(1);
    }
    if (node->next != NULL) {
        printf("Next pointer is not NULL\n");
        exit(1);
    }
    free(node);
}

void test_insertNode() {
    Node* head = NULL;
    insertNode(&head, 1);
    if (head == NULL) {
        printf("Failed to insert node\n");
        exit(1);
    }
    if (head->data != 1) {
        printf("Node data is incorrect\n");
        exit(1);
    }
    if (head->next != NULL) {
        printf("Next pointer is not NULL\n");
        exit(1);
    }
    insertNode(&head, 2);
    if (head->data != 1) {
        printf("Node data is incorrect\n");
        exit(1);
    }
    if (head->next->data != 2) {
        printf("Next node data is incorrect\n");
        exit(1);
    }
    if (head->next->next != NULL) {
        printf("Next pointer is not NULL\n");
        exit(1);
    }
}

void test_printList() {
    Node* head = NULL;
    insertNode(&head, 1);
    insertNode(&head, 2);
    insertNode(&head, 3);
    insertNode(&head, 4);
    insertNode(&head, 5);
    printList(head);
}

int main() {
    test_createNode();
    test_insertNode();
    test_printList();
    return 0;
}
