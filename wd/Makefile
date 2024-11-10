SRC       := hoge.c
OBJ       := $(SRC:.c=.o)
BUILD_DIR := ./build
DIR_13    := $(BUILD_DIR)/13
DIR_14    := $(BUILD_DIR)/14

.PHONY: all FORCE
all: 13a 14 13b

13a: FORCE
	@echo "\n==== clang-13 ok ===="
	@mkdir -p $(DIR_13)
	clang-13 -c $(SRC) -o $(DIR_13)/$(OBJ)
	clang-13 $(DIR_13)/$(OBJ) -o $(DIR_13)/a.out

13b: FORCE
	@echo "\n==== clang-13 ng ===="
	@mkdir -p $(DIR_13)
	clang-13 -c $(SRC) -o $(DIR_13)/$(OBJ)
	gcc $(DIR_13)/$(OBJ) -o $(DIR_13)/a.out

14: FORCE
	@echo "\n==== clang-14 ok ===="
	@mkdir -p $(DIR_14)
	clang-14 -c $(SRC) -o $(DIR_14)/$(OBJ)
	gcc $(DIR_14)/$(OBJ) -o $(DIR_14)/a.out

info: FORCE
	-@echo "\n=== ld version ==="
	-@ld -v
	-@echo "\n=== ld default warn ==="
	-@ld --help | grep textrel
	-@echo "\n=== clang-13 default PIC flag ==="
	-@clang-13 -c -### $(SRC) 2>&1 | sed 's/ "-/\n"-/g' | grep -iE 'pic|pie' || :
	-@echo "\n=== clang-14 default PIC flag ==="
	-@clang-14 -c -### $(SRC) 2>&1 | sed 's/ "-/\n"-/g' | grep -iE 'pic|pie' || :

fclean: FORCE
	rm -rf $(BUILD_DIR)
