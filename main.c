//
// Systolic array
// kuchynskiandrei@gmail.com
// 2020
//

#include <stdio.h>
#include <stdlib.h>
#include "systolic_sorting.h"

void PrintBuffer(const int* const buf, const int size);

void main()
{
		// Initialization
	const int CAPACITY = 10;
	int values[CAPACITY];
	int result_values[CAPACITY];

	for(int i = 0; i < CAPACITY; i++)
		values[i] = rand();

		// Sorting
	SystolicSort(values, result_values, CAPACITY);

		// Output
	PrintBuffer(values, CAPACITY);
	PrintBuffer(result_values, CAPACITY);
}

void PrintBuffer(const int* const buf, const int size)
{
	printf(": ");
	for(int i = 0; i < size; i++)
		printf("%d ", buf[i]);
	printf("\n");
}
