#include <stdio.h>
#include <stdlib.h>

void swap(int *x, int *y){
	int temp;
	temp = *x;
	*x = *y;
	*y = temp;
}

int main() {
	int i, n, size;
	scanf("%d", &n);
	int* list = malloc(sizeof(int) * n);
	
	for (i = 0; i < n; i++)
		scanf("%d", &list[i]);
	
	for (i = 0; i < n / 2; i++)
		swap(&list[i], &list[n - 1 - i]);
	
	for (i = 0; i < n; i++)
		printf("%d ", list[i]);
	
	free(list);
	return 0;
}
