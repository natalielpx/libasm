#include <stdio.h>
#include <string.h>
#include <unistd.h>

size_t ft_strlen(const char * str);
char * ft_strcpy(char * dst, const char * src);

int main(void) {

    char str[100];
    char dst[100];

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
    size_t ft_len_str = ft_strlen(str);
    printf("strlen    : %zu\n", strlen(str));
    printf("ft_strlen : %zu\n", ft_strlen(str));
    printf("=====================\n");

    printf("\n===== FT_STRCPY =====\n");
    printf("strcpy    : %s\n", strcpy(dst, str));
    printf("ft_strcpy : %s\n", ft_strcpy(dst, str));
    printf("=====================\n");


    printf("\n===== FT_WRITE =====\n");
    size_t written = write(1, str, len_str);
    printf("\n");
    size_t ft_written = write(1, str, ft_len_str);
    printf("\n");
    printf("write    : %zu\n", written);
    printf("ft_write : %zu\n", ft_written);
    printf("====================\n");

    return 0;
}