#include <unistd.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>


int main(int argc, char *argv[])
{

    int s1 = -1, s2 = -1, i, pfd[2];
    size_t argc2 = argc - 3;
    char *argv2[argc2 + 2];

    argv2[0] = argv[2];

    for (i = 0; i < argc2; ++i)
        argv2[i + 1] = argv[i + 3];

    argv2[argc2 + 1] = NULL;


    if (pipe(pfd) == -1)
    {
        perror("pipe");
        exit(1);
    }
    switch (fork())
    {
        case -1:
            perror("fork");
            exit(1);

        case 0:
            if (close(pfd[0]) != -1)
            {


                if (pfd[1] != STDOUT_FILENO)
                {
                    if (dup2(pfd[1], STDOUT_FILENO) != -1)
                    {
                        if (close(pfd[1]) == -1)
                        {
                            perror("close2");
                            exit(1);
                        }
                    } else
                    {
                        perror("dup2");
                        exit(1);
                    }
                }

                execlp(argv[1], argv[1], (char *) NULL);
                perror("argv");
                exit(1);

            } else
            {
                perror("fd1");
                exit(1);
            }
        default:
            break;
    }
    switch (fork())
    {
        case -1:
            perror("fork");
            exit(1);

        case 0:
            if (close(pfd[1]) == -1)
            {
                perror("close");
                exit(1);
            }

            if (pfd[0] != STDIN_FILENO)
            {
                if (dup2(pfd[0], STDIN_FILENO) != -1)
                {
                    if (close(pfd[0]) == -1)
                    {
                        perror("fd");
                        exit(1);
                    }
                } else
                {
                    perror("dup2");
                    exit(1);
                }
            }


            execvp(argv[2], argv2);

            perror(argv[2]);
            exit(1);
        default:
            break;
    }


    if (close(pfd[0]) != -1)
    {
        if (close(pfd[1]) == -1)
        {
            perror("close pfd[1]");
            exit(1);
        }
        if (wait(&s1) == -1)
        {
            perror("wait");
            exit(1);
        }
        if (wait(&s2) == -1)
        {
            perror("wait");
            exit(1);
        }


        printf("status: %d %d\n", s1, s2);

        return 0;
    } else
    {
        perror("close pfd[0]");
        exit(1);
    }
}