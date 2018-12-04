#include <stdio.h>
#include "example.h"

void square_array(double *start, double *end)
{
    for (; start != end; ++start)
        *start = (*start) * (*start);
}

void print_array(double *start, double *end)
{
    if (start == end) return;
    for (;;)
    {
        printf("%g", *start);
        ++start;
        if (start != end)
            putchar(' ');
        else
        {
            putchar('\n');
            break;
        }
    }
}