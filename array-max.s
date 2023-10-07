# Write the assembly code for the array_max function
.global array_max

# General Idea:
# unsigned long array_max(unsigned long n, unsigned long *items)
# Input:
#   rdi = n (number of elements)
#   rsi = items (pointer to the first element of the array)
# Output:
#   rax = maximum value in the array

.text
array_max:
    enter $0, $0

    movq (%rsi), %rax       # Initialize rax (max value) with the first element of the array
    dec %rdi                # Decrement count for the first element we've already considered
    test %rdi, %rdi         # Test if there are more elements
    jz end                 # If no more elements, jump to the end

loop:
    addq $8, %rsi           # Move to the next element in the array
    movq (%rsi), %rbx       # Load the next element into rbx
    cmpq %rax, %rbx         # Compare max value (rax) with the next element (rbx)
    cmovg %rbx, %rax        # If rbx > rax, move rbx into rax
    dec %rdi                # Decrement the count
    jnz loop               # If there are more elements, repeat the loop

end:
    leave
    ret

