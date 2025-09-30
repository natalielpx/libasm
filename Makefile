######################################

# 	LIBASM

######################################

NAME    = libasm.a
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

$(OBJ_DIR)%.o: $(SRC_DIR)%.s | $(OBJ_DIR)
	$(NASM) $(NASMFLAGS) $(DBGFLAGS) $< -o $@

$(OBJ_DIR):
	$(MKDIR) $(OBJ_DIR)

%.o: %.s
	$(NASM) ${NASMFLAGS} ${DBFLAGS} $< -o $@

clean:
	$(RMDIR) $(OBJ_DIR)

fclean: clean
	$(RM) $(TESTER)
	$(RM) $(NAME)
	$(RM) $(BONUS)
	$(RM) $(NAME_BONUS)

tester: $(NAME) $(TESTER_DIR)$(TESTER).c
	$(CC) ${CFLAGS} -c $(TESTER_DIR)$(TESTER).c -o $(OBJ_DIR)$(TESTER).o
	$(CC) ${CFLAGS} $(DBFLAG) $(OBJ_DIR)$(TESTER).o -L. -lasm -o $(TESTER)

re: fclean all

arm: $(NAME) $(TESTER_DIR)$(TESTER).c
	$(ARMCC) ${CFLAGS} -c $(TESTER_DIR)$(TESTER).c -o $(OBJ_DIR)$(TESTER).o
	$(ARMCC) ${CFLAGS} $(DBFLAG) $(OBJ_DIR)$(TESTER).o -L. -lasm -o $(TESTER)

$(NAME_BONUS): ${OBJS_BONUS}
	$(AR) rcs $@ $^

bonus: $(NAME_BONUS) $(TESTER_DIR)$(TESTER_BONUS).c
	$(CC) ${CFLAGS} -c $(TESTER_DIR)$(TESTER_BONUS).c -o $(OBJ_DIR)$(TESTER_BONUS).o
	$(CC) ${CFLAGS} $(DBFLAG) $(OBJ_DIR)$(TESTER_BONUS).o -L. -lasm_bonus -o $(BONUS)

.phony: all clean fclean tester re arm bonus