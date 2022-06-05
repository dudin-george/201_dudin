#include <stdio.h>
#include <sys/wait.h>
#include <unistd.h>

int main()
{
    pid_t pidt, pidt2;

    pidt = fork();

    if (pidt == 0)
        pidt2 = fork();

    if (pidt < 0)
    {
        perror("fork");
        return 1;
    } else if (pidt != 0)
    {
        wait(NULL);
        printf("Hello from parent\n");
    } else
    {
        wait(NULL);
        if (pidt2)
        {
            printf("Hello from child");
        } else
        {
            printf("Hello from grandchild");
        }
        printf("\n");
        return 0;

    }

    return 0;
}

