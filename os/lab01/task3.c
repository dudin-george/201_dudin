#include <stdio.h>
#include <stdlib.h>
int main() {
	int n, m; //n rows m columns
	scanf("%d", &n);
	scanf("%d", &m);
	int* matrix = malloc(sizeof(int) * (n * m));
	int* matrix_transposed = malloc(sizeof(int) * (n * m));
	int i, j;
	for (i = 0; i < n; i++) //input of the original matrix
		for (j = 0; j < m; j++)
			scanf("%d", &matrix[i * m + j]);
	
	for (i = 0; i < n; i++) //transposing matrix_transposed[i][j] = matrix[j][i]
		for (j = 0; j < m; j++)
		matrix_transposed[j * m + i] = matrix[i * m + j];
	
	for (i = 0; i < m; i++){ // printing the new matrix
		for (j = 0; j < n; j++)
			printf("%d ", matrix_transposed[i * m + j]);
		printf("\n");
	}
	
	free(matrix_transposed);
	free(matrix);
	return 0;
}