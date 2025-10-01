#ifndef LIBASM_H
# define LIBASM_H

// Libraries
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

// Constants
#define STD_IN 0
#define STD_OUT 1

// Mandatory Functions
size_t  ft_strlen(const char * str);
char *  ft_strcpy(char * dst, const char * src);
int     ft_strcmp(const char * s1, const char * s2);
char *  ft_strdup(const char * s);
ssize_t ft_write(int fd, const void * buf, size_t count);
ssize_t ft_read(int fd, void * buf, size_t count);

// Bonus Utils
typedef struct s_list {
    void * data;
	struct s_list * next;
} t_list;

// Bonus Functions
int 	ft_atoi_base(const char * str, int str_base);
void	ft_list_push_front(t_list ** begin_list, void * data);
int		ft_list_size(t_list * begin_list);
void	ft_list_sort(t_list ** begin_list, int (* cmp)());
void	ft_list_remove_if(t_list ** begin_list, void * data_ref, int (* cmp)(), void (* free_fct)(void *));

#endif