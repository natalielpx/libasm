#include "../libasm.h"

#define N 11

int main(void) {
	
	printf("==========================\n");
    printf("===== LIBASM - BONUS =====\n");
    printf("==========================\n");
    

    printf("\n===== FT_ATOI_BASE =====\n");
	printf("%s	(base: %d)	= %d\n", "0", 2, ft_atoi_base("0", 2));
	printf("%s	(base: %d)	= %d\n", "-1", 2, ft_atoi_base("-1", 2));
	printf("%s	(base: %d)	= %d\n", "a", 2, ft_atoi_base("a", 2));
	printf("%s	(base: %d)	= %d\n", "101010", 2, ft_atoi_base("101010", 2));
	printf("%s	(base: %d)	= %d\n", "4242", 10, ft_atoi_base("4242", 10));
	printf("%s	(base: %d)	= %d\n", "-42042", 10, ft_atoi_base("-42042", 10));
	printf("%s	(base: %d)	= %d\n", "-42000", 10, ft_atoi_base("-42000", 10));
	printf("%s	(base: %d)	= %d\n", "AD86", 16, ft_atoi_base("AD86", 16));
	printf("%s	(base: %d)	= %d\n", "-ad86", 16, ft_atoi_base("ad86", 16));
	printf("%s (base: %d)	= %d\n", "   -214748", 10, ft_atoi_base("   -214748", 10));
	printf("%s (base: %d)	= %d\n", "  --214748", 10, ft_atoi_base("  --214748", 10));
	printf("%s (base: %d)	= %d\n", "  214748a3", 10, ft_atoi_base("  214748a3", 10));
	printf("%s (base: %d)	= %d\n", "2147483647", 10, ft_atoi_base("2147483647", 10));
	printf("%s (base: %d)	= %d\n", "-2147483648", 10, ft_atoi_base("-2147483648", 10));
    printf("========================\n");


	printf("\n===== FT_LIST_PUSH_FRONT =====\n");
	ft_list_push_front(NULL, "0");

	t_list ** lst = malloc(sizeof(*lst));
	for (int i = 0; i < N; ++i) {
		char * data = malloc(sizeof(*data));
		*data = i + 1 + '0';
		ft_list_push_front(lst, data);
		printf("pushed data: %c\n", *data);
	}
    printf("==============================\n");


    printf("\n===== FT_LIST_SIZE =====\n");
	ft_list_size(NULL);

	printf("list size: %d\n", ft_list_size(*lst));
    printf("========================\n");


	printf("\n===== FT_LIST_SORT =====\n");
	ft_list_sort(lst, NULL);
	ft_list_sort(NULL, ft_strcmp);

	ft_list_sort(lst, ft_strcmp);
	for (t_list * tmp = *lst; tmp; tmp = tmp->next)
		printf("%c\n", (*(char *)tmp->data));
    printf("========================\n");


	printf("\n===== FT_LIST_REMOVE_IF =====\n");
	ft_list_remove_if(NULL, "4", ft_strcmp, free);
	ft_list_remove_if(lst, "4", NULL, free);
	ft_list_remove_if(lst, "4", ft_strcmp, NULL);

	ft_list_remove_if(lst, "4", ft_strcmp, free);
	for (t_list * tmp = *lst; tmp; tmp = tmp->next)
		printf("%c\n", (*(char *)tmp->data));
    printf("=============================\n");

    return 0;
}