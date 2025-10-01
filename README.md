# libasm - 42 project
## :open_file_folder: Project Overview
Introductory project to x86-64 assembly  
A library of several fundamental functions written in assembly
## :triangular_ruler: Prerequisites
### Operating System
Compiled and tested on Linux (x86-64 architecture)
### Assembler
**Netwide Assembler (NASM)**  
Used to assemble assembly source files into object files
### Compiler & Linker
**GNU Compiler Collection (gcc)**  
Used to compile tester files, link object files into a library, and then link library with tester files
### Optional (But Useful)
**GNU Project debugger (gdb)**  
Used to inspect what goes on in a program as it executes  
**Valgrind**  
Used to detect memory management and threading bugs

## :pushpin: Learning Objectives
### Syntax
#### Intel vs AT&T
Understand the difference between Intel and AT&T syntax
#### sections: data, rodata, bss, text, etc.
Familiarise the fundamental structure of a `.s` file  
Understand the difference between data/rodata and bss  
#### labels & functions
Understand the difference between labels and functions  
Learn to create a clear workflow jumping from label to label  
Familiarise register handling when calling functions, including arguments and return values
#### global vs extern
Understand the importance of global and the purpose it serves  
Experiment ommiting global/extern when compiling  
### Fundamentals
- parsing
- if/else conditioning
- for loops
- function calling
- passing arguments
### Calling conventions
There are several hard rules regarding the usage of registers in assembly. Failing to comply with any of these rules will result in either compilation failure, unpredictable outcome due to garbage memory, and or segmentation faults.  
caller/callee saved registers  
clobbered values between system calls  
accessing only target parts of registers  
restrictions between two memory addresses  
### Error handling
`errno` is a **C** standard library feature, and is not directly used in **assembly**. As the tester functions will be written in **C** (as specified by the subject), it would be useful to also mirror their errno outputs. When an error occurs, __errno_location() is called to obtain an address, which should be filled with the error number, before the called function returns to the outer function.
```
int * __errno_location(void);

Returns the address of the errno variable for the current thread
```
### Memory handling
- usage of malloc
- pushing and popping data
- handling linked lists
- -no-pie
## :card_index_dividers: Contents
### Files & Structure
```
.
├── src/
│   │   [ Mandatory Functions ]
│   ├── ft_strlen.s
│   ├── ...
│   │   [ Bonus functions ]
│   ├── ft_atoi_base.s
│   └── ...
├── test/
│   ├── tester.c
│   └── tester_bonus.c
├── libasm.h
├── Makefile
└── README.md
```
### Mandatory Functions
ft_strlen (man 3 strlen)  
ft_strcpy (man 3 strcpy)  
ft_strcmp (man 3 strcmp)  
ft_write (man 2 write)  
ft_read (man 2 read)  
ft_strdup (man 3 strdup)
### Bonus Functions
#### `int ft_atoi_base(const char * str, int base);`
Converts string argument `str` of 2 <= `base` <= 16 to an integer (base 10)  
Returns converted integer
```
typedef struct s_list {
    void          *data;
    struct s_list *next;
} t_list;
```
**REMARK:** This function differs from what the subject requires. The subject asks for ft_atoi_base to take in a string for the base. I have merely decided that this version of ft_atoi_base makes more sense to me, and forfeited completing this particular part of the bonus.
#### `void ft_list_push_front(t_list ** begin_list, void * data);`
Inserts a new element at the beginning of the list, right before its current first element  
`data` is copied/moved to the inserted element
#### `int ft_list_size(t_list * begin_list);`
Counts number of elements in linked list passsed to it  
Returns element count  
#### `void ft_list_sort(t_list ** begin_list, int (* cmp)());`
Sorts elements in given list, altering their position within the list  
Comparisons are made by the function `int (* cmp)()`  
#### `void ft_list_remove_if(t_list ** begin_list, void * data_ref, int (* cmp)(), void (* free_fct)(void *));`
Removes from the passed list any element the data of which is "equal" to the reference data (`data_ref`)  
Equality is determined by the function `int (* cmp)()`  
Removed element is freed via `void (* free_fct)(void *)`
## :building_construction: Compilation
### `make`
Creates a library named libasm comprising of the mandatory functions  
Links the library to a tester main function where users can test and compare the assembly functions to those in the C library  
Creates an executable named `tester`
```
make
./tester
```
### `make bonus`
Creates a library named libasm_bonus comprising of the bonus functions and any depending mandatory functions  
Links the library to a bonus tester main function where users can test the assembly functions with given values   
Creates an executable named `bonus`
```
make bonus
./bonus
```
## :test_tube: Tester Files
### tester.c (for mandatory functions)
Tested cases include:  
| Type | Special Cases |
| ---- | ----- |
| strings | NULL pointers, empty strings, non null-terminated strings |
### tester_bonus.c (for bonus functions)
Tested cases include:  
| Type | Singularities / Edge Cases |
| ---- | ----- |
| strings | white spaces, invalid 'digits', long strings, non-valid characters, multiple '-' |
| lists | NULL pointers |
## :lady_beetle: Debugging
### gdb
Use gdb to look under the hood of the program and watch how the it alters the values of the registers.  
Place breakpoints and step instruction by instruction to inspect register changes.  
```
gdb tester
```
```
gdb bonus
```
### valgrind
```
valgrind ./tester
valgrind --leak-check=full ./tester
```
## :mag: Resources
### Assembly
Keep in mind that this tutorial targets 32-bit assembly, whereas libasm requires 64-bit.  
The concepts of the two are inherently indentical, but certain notations and syntax may differ.  
https://www.tutorialspoint.com/assembly_programming/assembly_introduction.htm
### gdb
Beej never lets us down when it comes to documentations  
Here is another one of their well-explained, light-toned breakdowns on how to use gdb  
https://beej.us/guide/bggdb/