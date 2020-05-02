//
// Systolic array for sorting
// kuchynskiandrei@gmail.com
// 2020
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "systolic_sorting.h"

struct Ssort {
	void *pointer0;
	void *pointer1;
	struct Ssort *next;
};

enum eStade {esInput, esOutput};

static struct Ssort* Create(const int size);
static void Destroy(struct Ssort *ssort);
int* StepSorting(struct Ssort *ssort, enum eStade stage, int *set_value);

void SystolicSort(int *buf_in, int *buf_out, const int size)
{
	struct Ssort *ssort_first = Create(size);
	int *ptr;

		// Put the data to the array
    for(int i = 0; i < size; i++) {
		StepSorting(ssort_first, esInput, &buf_in[i]);
		ptr = StepSorting(ssort_first, esInput, NULL); // first result should be here on the last cycle
	}

		// Extract the result
    for(int i = 0, j = 0; i < size*2; i++) {
		if(ptr)
			buf_out[j++] = *ptr;
		ptr = StepSorting(ssort_first, esOutput, NULL);
	}

	Destroy(ssort_first);
}

	// Change this function according to the sorting rule or data type
int CompareFunction(void *pointer0, void *pointer1)
{
	int value0 = *(int*)pointer0;
	int value1 = *(int*)pointer1;
	return (value0 > value1)? 1 : 0;
}

int* StepSorting(struct Ssort *ssort, enum eStade stage, int *set_value)
{
	void *ptr0 = ssort->pointer0;
	ssort->pointer0 = set_value;

	if(ssort->next) {
		void *ptr1 = ssort->pointer1;
		if(ptr0 && ptr1) {
			if(CompareFunction(ptr0, ptr1)) {
				ptr1 = ptr0;
				ptr0 = ssort->pointer1;
			}
		}
		else if(stage == esInput && ptr0) {
			ptr1 = ptr0;
			ptr0 = NULL;
		}
		else if(stage == esOutput && ptr1) {
			ptr0 = ptr1;
			ptr1 = NULL;
		}
		ssort->pointer1 = StepSorting(ssort->next, stage, ptr1);
	}

	return ptr0;
}

static struct Ssort* Create(const int size)
{
	struct Ssort *ssort_first = NULL;

    for(int i = 0; i < size; i++) {
		struct Ssort *ssort_tmp = (struct Ssort*)malloc(sizeof(struct Ssort));
		ssort_tmp->pointer0 = NULL;
		ssort_tmp->pointer1 = NULL;
		ssort_tmp->next = ssort_first;
		ssort_first = ssort_tmp;
	}

	return ssort_first;
}

static void Destroy(struct Ssort *ssort)
{
	while(ssort) {
		struct Ssort *ssort_tmp = ssort;
		ssort = ssort->next;
		free(ssort_tmp);
	}
}
