/* Complete the C version of the driver program for compare. This C code does
 * not need to compile. */

#include <stdio.h>
#include <stdlib.h>

extern long compare(long, long);

int main(int argc, char *argv[]) {
    if (argc != 3) { // Checks that there are exactly 3 arguments given including name
        printf("Two arguments required.\n");
        return 1;
    }
    
    long a = atol(argv[1]); // Convert the first meaningful argument to a long integer
    long b = atol(argv[2]); // Convert the second argument to a long integer
    
    long result = compare(a, b);

    if (result == -1) {
        printf("less\n");
    } else if (result == 0) {
        printf("equal\n");
    } else if (result == 1) {
        printf("greater\n");
    }

    return 0;
}
