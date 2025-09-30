#include "../libasm.h"

#define N 11

int main(void) {
	
	printf("==========================\n");
    printf("===== LIBASM - BONUS =====\n");
    printf("==========================\n");
    

    printf("\n===== FT_ATOI_BASE =====\n");
    // prompts user for value
	char base[100];
    printf("Please enter a base (2-16): ");
    fgets(base, sizeof(base), stdin);
    char str[100];
    printf("Please enter a value: ");
    // reads line of text (spaces included)
    fgets(str, sizeof(str), stdin);

	printf("HAHAHA: %d\n", ft_atoi_base(str, atoi(base)));
    printf("========================\n");


	printf("\n===== FT_LIST_PUSH_FRONT =====\n");
	t_list ** lst = malloc(sizeof(*lst));
	for (int i = 0; i < N; ++i) {
		char * data = malloc(sizeof(*data));
		*data = i + 1 + '0';
		ft_list_push_front(lst, data);
		printf("pushed: %c\n", *data);
	}
    printf("==============================\n");


    printf("\n===== FT_LIST_SIZE =====\n");
	printf("list size: %d\n", ft_list_size(*lst));
    printf("========================\n");


	printf("\n===== FT_LIST_SORT =====\n");
	ft_list_sort(lst, ft_strcmp);
	for (t_list * tmp = *lst; tmp; tmp = tmp->next)
		printf("%c\n", (*(char *)tmp->data));
    printf("========================\n");


	printf("\n===== FT_LIST_REMOVE_IF =====\n");
	ft_list_remove_if(lst, ";", ft_strcmp, free);
	for (t_list * tmp = *lst; tmp; tmp = tmp->next)
		printf("%c\n", (*(char *)tmp->data));
    printf("=============================\n");

    return 0;
}