#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>

#define STD_IN  0
#define STD_OUT 1

#define STR "Miaouuuu"
#define S1  "Miaouuuuu"
#define S2  "Miaouuu"

size_t  ft_strlen(const char * str);
char *  ft_strcpy(char * dst, const char * src);
int     ft_strcmp(const char * s1, const char * s2);
char *  ft_strdup(const char * s);
ssize_t ft_write(int fd, const void * buf, size_t count);
ssize_t ft_read(int fd, void * buf, size_t count);

void test_ft_strlen(char * example, char * str) {
    printf("%s\n", example);
    printf("strlen    : %zu\n", strlen(str));
    printf("ft_strlen : %zu\n", ft_strlen(str));
}

void test_ft_strcpy(char * example, char * buf, char * str) {
    printf("%s\n", example);
    printf("strcpy    : %s\n", strcpy(buf, str));
    printf("ft_strcpy : %s\n", ft_strcpy(buf, str));
}

void test_ft_strcmp(char * example, char * buf, char * str) {
    printf("%s\n", example);
    printf("strcmp    : %d\n", strcmp(buf, str));
    printf("ft_strcmp : %d\n", ft_strcmp(buf, str));
}

void test_ft_strdup(char * example, char * str) {
    
    printf("%s\n", example);

    char * dup = strdup(str);
    printf("strdup    : %s\n", dup);
    free(dup);
    
    dup = ft_strdup(str);
    printf("ft_strdup : %s\n", dup);
    free(dup);
}

void test_ft_write(char * example, int fd, char * str) {

    printf("%s\n", example);

    size_t written = write(fd, str, strlen(str));
    printf("\n");
    printf("write    : %zu\n", written);

    written = ft_write(fd, str, strlen(str));
    printf("\n");
    printf("ft_write : %zu\n", written);
}

int main(void) {
	
	printf("==================\n");
    printf("===== LIBASM =====\n");
    printf("==================\n");
	
    char no_null[3];
    no_null[0] = 'M'; 
    no_null[1] = 'i'; 
    no_null[2] = 'a';


    printf("\n===== FT_STRLEN =====\n");
    // strlen(NULL) causes segfault
    test_ft_strlen("Empty String", "");
    test_ft_strlen("Non NULL-terminated string", no_null);
    test_ft_strlen(STR, STR);
    printf("=====================\n");


    printf("\n===== FT_STRCPY =====\n");
	char buf[100];
    // strcpy(NULL, NULL) causes segfault
    test_ft_strcpy("str is Empty String", buf, "");
    // passing non null terminated strings to strcpy leads to undefined results
    test_ft_strcpy(STR, buf, STR);
    printf("=====================\n");


    printf("\n===== FT_STRCMP =====\n");
    // strcpy(NULL, NULL) causes segfault
    test_ft_strcmp("S1 is Empty String", "", S2);
    test_ft_strcmp("S2 is Empty String", S1, "");
    test_ft_strcmp("S1 is Non NULL-terminated String", S1, no_null);
    test_ft_strcmp("S2 is Non NULL-terminated String", no_null, S2);
    test_ft_strcmp("S1 & S2", S1, S2);
    printf("=====================\n");


    printf("\n===== FT_STRDUP =====\n");
    // strdup(NULL) causes segfault
    test_ft_strdup("Empty String", "");
    test_ft_strdup("Non NULL-terminated string", no_null);
    test_ft_strdup(STR, STR);
    printf("=====================\n");


    printf("\n===== FT_WRITE =====\n");
    // writing from NULL pointer causes segfault
    test_ft_write("Empty String", STD_OUT, "");
    test_ft_write("Non NULL-terminated string", STD_OUT, no_null);
    test_ft_write(STR, STD_OUT, STR);
    printf("====================\n");


    printf("\n===== FT_READ =====\n");

    memset(buf, 0, 100);
    write(STD_OUT, "Please enter a string (<=10 characters): ", 41);
    size_t readd = read(STD_IN, buf, 10);
    printf("read : %zu\n", readd);
    printf("%s\n", buf);

    memset(buf, 0, 100);
    write(STD_OUT, "Please enter the same string: ", 30);
    readd = ft_read(STD_IN, buf, 10);
    printf("ft_read : %zu\n", readd);
    printf("%s\n", buf);

    printf("===================\n");

    return 0;
}