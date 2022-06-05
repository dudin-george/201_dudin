#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>



int main(int argc, const char* argv[])
{
    char** mem = malloc((argc - 1) * sizeof(char*));
    for(int i = 1; i < argc - 1; i++)
    {
        mem[i - 1] = argv[i];
    }
    mem[argc - 2] = (char*)NULL;

    int num = open(argv[argc - 1], O_CREAT | O_WRONLY | O_TRUNC, S_IRUSR | S_IWUSR);
    close(STDOUT_FILENO);
    dup2(num, STDOUT_FILENO);
    execvp(argv[1], mem);
}