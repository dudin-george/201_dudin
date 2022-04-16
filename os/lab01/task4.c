#include <stdio.h>
#include <stdlib.h>
struct Node{
	int data;
	struct Node* next;
};


void add_node (struct Node* head, int num){
	struct Node* iter = head;
	while (iter -> next != NULL)
		iter = iter -> next;
	
	iter -> next = (struct Node *) malloc(sizeof(struct Node*));
	iter -> next -> data = num;
	iter -> next -> next = NULL;
}

void print_list(struct Node * head) {
	struct Node* iter = head;
	
	while (iter != NULL) {
		printf("%d", iter->data);
		iter = iter->next;
	}
}

void reverse_list (struct Node** head){
	struct Node* cur_node = *head;
	struct Node* next_node = NULL;
	struct Node* prev_node = NULL;
	
	while(cur_node != NULL){
		next_node = cur_node -> next;
		cur_node -> next = prev_node;
		prev_node = cur_node;
		cur_node = next_node;
	}
	*head = prev_node;
	
}

int main() {
	int flag = 1;
	struct Node* head = NULL;
	head = (struct Node*) malloc(sizeof(struct Node*));
	head -> data = 0;
	// Adding elements to linked list
	while (flag){
		int x;
		scanf("%d", &x);
		if (x == 0){
			flag = 0;
		}
		else{
			add_node(head, x);
		}
		
	}
	print_list(head);
	printf("\n");
	printf("Reversed list\n");
	reverse_list(&head);
	print_list(head);
	return 0;
	
}
