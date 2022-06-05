#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, const char* argv[])
{
    char** mem = malloc((argc - 2) * sizeof(char*));
    for(int i = 3; i < argc; i++)
    {
        mem[i - 3] = argv[i];
    }
    mem[argc - 3] = (char*)NULL;

    int arr[2];
    pipe(arr);

    if(fork() == 0)
    {
        close(arr[0]);
        dup2(arr[1], STDOUT_FILENO);
        execlp(argv[1], argv[1]);
    }
    else
    {
        wait(NULL);
        close(arr[1]);
        dup2(arr[0], STDIN_FILENO);
        execvp(argv[2], mem);
    }
    return 0;
}
