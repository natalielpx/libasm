#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>

#define STD_IN 0
#define STD_OUT 1

size_t ft_strlen(const char * str);
char * ft_strcpy(char * dst, const char * src);

char * ft_strdup(const char * s);
ssize_t ft_write(int fd, const void *buf, size_t count);
ssize_t ft_read(int fd, void * buf, size_t count);

int main(void) {

    char str[100];
    char buf[100];

    printf("==================\n");
    printf("===== LIBASM =====\n");
    printf("==================\n");
    
    // prompts user for string
    printf("Please enter a string: ");
    // reads line of text (spaces included)
    fgets(str, sizeof(str), stdin);
    // removes trailing newline
    str[strcspn(str, "\n")] = 0;


    printf("\n===== FT_STRLEN =====\n");
    size_t len_str = strlen(str);
    printf("strlen    : %zu\n", strlen(str));
    printf("ft_strlen : %zu\n", ft_strlen(str));
    printf("=====================\n");


    printf("\n===== FT_STRCPY =====\n");
    printf("strcpy    : %s\n", strcpy(buf, str));
    printf("ft_strcpy : %s\n", ft_strcpy(buf, str));
    printf("=====================\n");


    printf("\n===== FT_STRDUP =====\n");

    char * dup = strdup(str);
    printf("strdup    : %s\n", dup);
    free(dup);
    
    dup = ft_strdup(str);
    printf("ft_strdup : %s\n", dup);
    free(dup);
    
    printf("=====================\n");


    printf("\n===== FT_WRITE =====\n");

    size_t written = write(STD_OUT, str, len_str);
    printf("\n");
    printf("write    : %zu\n", written);

    written = ft_write(STD_OUT, str, len_str);
    printf("\n");
    printf("ft_write : %zu\n", written);

    printf("====================\n");


    printf("\n===== FT_READ =====\n");

    memset(buf, 0, 100);
    write(1, "Please enter a string (<=10 characters): ", 41);
    size_t readd = read(STD_IN, buf, 10);
    printf("read : %zu\n", readd);
    printf("%s\n", buf);

    memset(buf, 0, 100);
    write(1, "Please enter the same string: ", 30);
    readd = ft_read(STD_IN, buf, 10);
    printf("ft_read : %zu\n", readd);
    printf("%s\n", buf);

    printf("===================\n");

    

    return 0;
}