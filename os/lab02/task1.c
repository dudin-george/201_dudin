#include <stdio.h>
#include <stdlib.h>
#include <regex.h>
#include <string.h>

#define ARRAY_SIZE(arr) (sizeof((arr)) / sizeof((arr)[0]))

int replacement(char* str, char* re, char* inst)
{
    char *s = str;
    regex_t regexpr;
    regmatch_t pmatch[1];
    regoff_t off;
    int len = strlen(s);

    char* buffer = malloc(len * sizeof(char));

    if (regcomp(&regexpr, re, REG_NEWLINE))
        return EXIT_FAILURE;

    for (int i = 0; ; i++) {
        if (regexec(&regexpr, s, ARRAY_SIZE(pmatch), pmatch, 0))
            break;

        off = pmatch[0].rm_so + (s - str);

        if(len < off + strlen(inst))
        {
            len = off + strlen(inst);
            realloc(buffer, len * sizeof(char));
        }

        strncat(buffer, s, pmatch[0].rm_so);
        strcat(buffer, inst);

        s += pmatch[0].rm_eo;
    }

    if(!strlen(buffer))
        strcpy(buffer, str);

    printf("%s\n", buffer);
    free(buffer);

    return 0;
}

int main(int argc, char *argv[])
{
    if(argc != 4 || replacement(argv[2], argv[1], argv[3]))
        exit(EXIT_FAILURE);
    exit(EXIT_SUCCESS);
}
