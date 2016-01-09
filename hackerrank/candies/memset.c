#include <stdlib.h>
#include <stdio.h>
#include <string.h>


int main(void) {
   int* x = malloc(sizeof(int) * 5);
   memset(x, 1, sizeof(x) / sizeof(int));

   printf("%d", x[0]);
}
