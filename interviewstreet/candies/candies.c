/**
 * Alice is a kindergarden teacher. She wants to give some candies to the
 * children in her class.  All the children sit in a line and each  of them  has
 * a rating score according to his or her usual performance.  Alice wants to
 * give at least 1 candy for each child.Children get jealous of their immediate
 * neighbors, so if two children sit next to each other then the one with the
 * higher rating must get more candies. Alice wants to save money, so she wants
 * to minimize the total number of candies.
 */


#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <math.h>
#include <string.h>


// Courtesy of Zed Shaw's Awesome Debug Macros
#define clean_errno() (errno == 0 ? "None" : strerror(errno))
#define log_err(M, ...) fprintf(stderr, "[ERROR] (%s:%d: errno: %s) " M "\n", __FILE__, __LINE__, clean_errno(), ##__VA_ARGS__)
#define check(A, M, ...) if(!(A)) { log_err(M, ##__VA_ARGS__); errno=0; goto error; }
#define check_mem(A) check((A), "Out of memory.")

#define max(a,b) \
   ({ __typeof__ (a) _a = (a); \
       __typeof__ (b) _b = (b); \
     _a > _b ? _a : _b; })


int calc_min_candies(int* kids, int n) {
    int result = -1,
        *min_r = NULL,
        *min_l = NULL;

    min_r = malloc(sizeof(int) * n);
    check_mem(min_r);
    min_l = malloc(sizeof(int) * n);
    check_mem(min_l);

    memset(min_r, 0, sizeof(int) * n);
    memset(min_l, 0, sizeof(int) * n);

    for (int i = n - 2; i >= 0; i--) {
        if (kids[i + 1] < kids[i]) {
            min_r[i] = 1 + min_r[i + 1];
        }
    }

    for (int i = 1; i < n; i++) {
        if (kids[i - 1] < kids[i]) {
            min_l[i] = 1 + min_l[i - 1];
        }
    }

    result = 0;
    for (int i = 0; i < n; i++) {
        // I don't always do C, but when I do I do useless pointer arithmetic.
        result += max(*(min_r++), *(min_l++)) + 1;
    }

error:
    if (min_r != NULL) {
        free(min_r - n);
    }

    if (min_l != NULL) {
        free(min_l - n);
    }

    return result;
}


int main(void) {
    int *n, result,
        *kids = NULL;

    scanf("%d", n);
    kids = malloc(sizeof(int) * *n);
    check_mem(kids);

    for (int i = 0; i < *n; i++) {
        scanf("%d", (kids + i));
    }

    result = calc_min_candies(kids, *n);
    printf("%d", result);

    free(kids);
    return EXIT_SUCCESS;
error:

    if (kids != NULL) {
        free(kids);
    }

    return EXIT_FAILURE;
}
