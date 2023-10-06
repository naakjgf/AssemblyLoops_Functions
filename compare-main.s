# Write the assembly code for the main of the compare program
.global main
.extern printf
.extern atol
.extern compare

.text
main:
    # Checking if argc is not 3
    cmp %rdi, 3
    jne wrong_args

    # Convert the first arg to long
    mov 8(%rsi), %rdi
    call atol
    mov %rax, %rbx   # Storing result in %rbx instead of %r12 so I don't have to later

    # Convert second arg to long
    mov 16(%rsi), %rdi
    call atol

    # Call compare function
    mov %rbx, %rdi
    call compare

    # Use result of compare to jump directly to the right message, 
    lea less_msg(%rip), %rdx # computes the effective address of less_msg relative to the current %rip value and loads that into %rdx
    lea equal_msg(%rip), %rcx # same applies to these ones as well, cool stuff
    lea greater_msg(%rip), %r8

    cmovl %rdx, %rdi  # If less, it stores into the %rdi, these are all conditional moves
    cmove %rcx, %rdi  # If equal
    cmovg %r8, %rdi  # If greater
    
    mov $0, %rax
    call printf
    
    xor %eax, %eax    # Setting return value to 0, using eax register to clear the first 32 bits showing there was no error    
    ret

wrong_args:
    lea two_args_msg(%rip), %rdi
    call printf

    mov $1, %eax # Setting it to 1 to show that there was an issue, 1 representing an error return value
    ret

.data
two_args_msg:      
   .asciz "Two arguments required.\n"
less_msg:       
   .asciz "less\n"
equal_msg:      
   .asciz "equal\n"
greater_msg:     
   .asciz "greater\n"
