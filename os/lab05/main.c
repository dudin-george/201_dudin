#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

static unsigned long long initial = 0;
static pthread_mutex_t mtx = PTHREAD_MUTEX_INITIALIZER;

static void * Sum(void * arg) {
    int * arr = ((int ** ) arg)[0];
    int * borders = ((int ** ) arg)[1];
    printf("current borders: %d %d\n", borders[0], borders[1]);

    int s = pthread_mutex_lock( & mtx);
    if (s != 0) {
        perror("pthread_mutex_lock");
        return NULL;
    }

    unsigned long long loc = initial;
    for (int i = borders[0]; i < borders[1]; i++) {
        loc += arr[i];
        printf("current %d arr val: %d\n", i, arr[i]);
    }
    initial = loc;
    printf("current cum %d\n", initial);

    s = pthread_mutex_unlock( & mtx);
    if (s != 0) {
        perror("pthread_mutex_unlock");
        return NULL;
    }

    return NULL;
}

int main() {
    int num;
    time_t t;
    scanf(" %d", & num);

    if (num < 4) {
        perror("Too small.");
        exit(EXIT_FAILURE);
    }

    srand((unsigned) time( & t));

    int * arr = malloc(num * sizeof(int));
    printf("The resulting array is:\n");
    for (int i = 0; i < num; i++) {
        arr[i] = rand() % 696969;
        printf("%d\n", arr[i]);
    }

    pthread_t thre[4];
    for (int i = 0; i < (num / 4) * 4; i += num / 4) {
        int * temp = malloc(2 * sizeof(int));
        temp[0] = i;
        temp[1] = i + num / 4;
        if (i == 3 * num / 4 && num % 2 == 1)
            temp[1] += 1;
        int ** matr = malloc(2 * sizeof(int * ));
        matr[0] = arr;
        matr[1] = temp;
        int s = pthread_create( & thre[i / (num / 4)], NULL, Sum, matr);

        if (s != 0) {
            perror("pthread_create");
            exit(EXIT_FAILURE);
        }
    }

    for (size_t i = 0; i < 4; i++) {
        int s = pthread_join(thre[i], NULL);
        if (s != 0) {
            perror("pthread_join");
            exit(EXIT_FAILURE);
        }
    }

    printf("The sum is: %d\n", initial);
    exit(EXIT_SUCCESS);
}
