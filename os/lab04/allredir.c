#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>

int main(int argc, const char* argv[]){
    char** mem = malloc((argc - 2) * sizeof(char*));
    for (int i = 1 ; i < argc - 2 ; i++) {
        mem[i - 1] = argv[i];
    }
    mem[argc - 3] = (char*)NULL;

    pid_t pid = fork();
    if (pid == 0)
    {
        int no_file;
        no_file = dup(STDOUT_FILENO);
        int fop = open(argv[argc - 1], O_CREAT | O_WRONLY | O_TRUNC, S_IRUSR | S_IWUSR);
        close(STDOUT_FILENO);
        dup2(fop, STDOUT_FILENO);
        int num1 = open(argv[argc - 2], O_CREAT | O_RDONLY, S_IRUSR | S_IWUSR);
        close(STDIN_FILENO);
        dup2(num1, STDIN_FILENO);
        execvp(argv[1], mem);
    }
    else
    {
        int* mem2 = malloc(sizeof(int));
        wait(mem2);
        printf("%d", WEXITSTATUS(mem2));
    }
    return 0;
}