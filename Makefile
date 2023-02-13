
SRC_FILES = main.c systolic_sorting.c

amemory: $(SRC_FILES)
	gcc -std=c99 -o app $^
#-Wall
clean: rm -f *.o
