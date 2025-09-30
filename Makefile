######################################

# 	LIBASM

######################################

NAME    = libasm.a
HEADER	= libasm.h
TESTER	= tester

NAME_BONUS    	= libasm_bonus.a
TESTER_BONUS	= tester_bonus
BONUS			= bonus

######################################
# 	TOOLS
######################################

NASM    = nasm
CC		= gcc
ARMCC	= x86_64-linux-gnu-gcc
AR      = ar
RM      = rm -f
RMDIR   = rm -rf
MKDIR   = mkdir -p

######################################
# 	FLAGS
######################################

NASMFLAGS	= -f elf64 -F dwarf
CFLAGS		= -Wall -Wextra -Werror
DBFLAG		= -g
INCL	 	= -I.

######################################
# 	SOURCES/OBJECTS
######################################

SRC_DIR	= src/
OBJ_DIR = obj/
SRCS	= \
			$(SRC_DIR)ft_read.s \
			$(SRC_DIR)ft_strcmp.s \
			$(SRC_DIR)ft_strcpy.s \
			$(SRC_DIR)ft_strdup.s \
			$(SRC_DIR)ft_strlen.s \
			$(SRC_DIR)ft_write.s
OBJS	= $(SRCS:$(SRC_DIR)%.s=$(OBJ_DIR)%.o)

SRCS_BONUS	= \
			$(SRC_DIR)ft_atoi_base.s \
			$(SRC_DIR)ft_list_push_front.s \
			$(SRC_DIR)ft_list_size.s \
			$(SRC_DIR)ft_list_sort.s \
			$(SRC_DIR)ft_list_remove_if.s \
			$(SRC_DIR)ft_strcmp.s
OBJS_BONUS	= $(SRCS_BONUS:$(SRC_DIR)%.s=$(OBJ_DIR)%.o)

TESTER_DIR = test/

######################################
# 	RECIPES
######################################

all: $(NAME)

$(NAME): ${OBJS}
	$(AR) rcs $@ $^

$(NAME_BONUS): ${OBJS_BONUS}
	$(AR) rcs $@ $^

$(OBJ_DIR)%.o: $(SRC_DIR)%.s | $(OBJ_DIR)
	$(NASM) $(NASMFLAGS) $(DBGFLAGS) $< -o $@

$(OBJ_DIR):
	$(MKDIR) $(OBJ_DIR)

%.o: %.s
	$(NASM) ${NASMFLAGS} ${DBFLAGS} $< -o $@

tester: $(NAME) $(TESTER_DIR)$(TESTER).c $(HEADER)
	$(CC) ${CFLAGS} $(INCL) -c $(TESTER_DIR)$(TESTER).c -o $(OBJ_DIR)$(TESTER).o
	$(CC) ${CFLAGS} $(DBFLAG) $(OBJ_DIR)$(TESTER).o -L. -lasm -o $(TESTER)

bonus: $(NAME_BONUS) $(TESTER_DIR)$(TESTER_BONUS).c $(HEADER)
	$(CC) ${CFLAGS} $(INCL) -c $(TESTER_DIR)$(TESTER_BONUS).c -o $(OBJ_DIR)$(TESTER_BONUS).o
	$(CC) ${CFLAGS} $(DBFLAG) $(OBJ_DIR)$(TESTER_BONUS).o -L. -lasm_bonus -o $(BONUS)

clean:
	$(RMDIR) $(OBJ_DIR)

fclean: clean
	$(RM) $(TESTER)
	$(RM) $(NAME)
	$(RM) $(BONUS)
	$(RM) $(NAME_BONUS)

re: fclean all

.phony: all clean fclean tester re bonus