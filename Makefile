
SRC_FILES = ./main.c \
			./systolic_sorting.c

amemory: $(SRC_FILES)
	gcc -o app $^
#-Wall
clean: rm -f *.o
