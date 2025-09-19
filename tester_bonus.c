#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>

#define STD_IN 0
#define STD_OUT 1
#define N 3

typedef struct s_list {
	void * data;
	struct s_list * next;
} t_list;

int ft_atoi_base(const char * str, int str_base);
int	ft_list_size(t_list * begin_list);

int main(void) {

	
	printf("==========================\n");
    printf("===== LIBASM - BONUS =====\n");
    printf("==========================\n");
    

    // printf("\n===== FT_ATOI_BASE =====\n");
    // // prompts user for value
	// char base[100];
    // printf("Please enter a base (2-16): ");
    // fgets(base, sizeof(base), stdin);
    // char str[100];
    // printf("Please enter a value: ");
    // // reads line of text (spaces included)
    // fgets(str, sizeof(str), stdin);

	// printf("HAHAHA: %d\n", ft_atoi_base(str, atoi(base)));
    // printf("========================\n");


    printf("\n===== FT_LIST_SIZE =====\n");
	t_list * begin = malloc(sizeof(*begin));
	t_list * lst = begin;
	for (int i = 0; i < N; ++i) {
		lst->data = NULL;
		lst->next = NULL;
		lst->next = malloc(sizeof(*lst));
		lst = lst->next;
	}

	printf("list size: %d\n", ft_list_size(begin));
    printf("========================\n");

    return 0;
}