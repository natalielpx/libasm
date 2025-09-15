######################################

# 	LIBASM

######################################

NAME    = libasm.a
TESTER	= tester

######################################
# 	TOOLS
######################################

NASM    = nasm
CC		= gcc
AR      = ar
RM      = rm

######################################
# 	FLAGS
######################################

NASMFLAGS	= -f elf64 -F dwarf
CFLAGS		= -Wall -Wextra -Werror
DBFLAG		= -g

######################################
# 	SOURCES/OBJECTS
######################################

SRCS	= \
			ft_read.s \
			ft_strcmp.s \
			ft_strcpy.s \
			ft_strdup.s \
			ft_strlen.s \
			ft_write.s
OBJS	= ${SRCS:.s=.o} 

######################################
# 	RECIPES
######################################

all: $(NAME)

$(NAME): ${OBJS}
	$(AR) rcs $@ $^

%.o: %.s
	$(NASM) ${NASMFLAGS} ${DBFLAGS} $< -o $@

clean:
	$(RM) -f ${OBJS}

fclean: clean
	$(RM) -f $(TESTER).o $(TESTER)
	$(RM) -f $(NAME)

tester: $(NAME) $(TESTER).c
	$(CC) ${CFLAGS} -c $(TESTER).c
	$(CC) ${CFLAGS} $(DBFLAG) $(TESTER).o -L. -lasm -o tester

re: fclean all

.phony: all clean fclean tester re