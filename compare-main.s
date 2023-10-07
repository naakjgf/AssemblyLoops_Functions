.global main
.extern printf
.extern atol
.extern compare

.text
main:
    enter $0, $0

# Moving args into registers
    movq 8(%rsi), %r12  # op = argv[1]
    movq 16(%rsi), %r13 # arg1 = argv[2]
    
# Check if argc is not 3
    cmp $3, %rdi
    jne wrong_args
   
# Convert the first arg to long
    mov %r12, %rdi
    call atol
    mov %rax, %r12

# Convert the second arg to long
    mov %r13, %rdi
    call atol
    mov %rax, %r13

    # Call compare function
    mov %r12, %rdi
    mov %r13, %rsi
    call compare

    # Bitwise operation to see what the result was
    test %rax, %rax

    je equal #if rax, as in the result from compare is 0
    jl less  #if rax, the result from compare is -1
    jmp greater # default, but technically if it is 1 is the only case it will get here

less:
    mov $less_msg, %rdi
    jmp print_msg

equal:
    mov $equal_msg, %rdi
    jmp print_msg

greater:
    mov $greater_msg, %rdi

print_msg:
    mov $0, %rax  # Clearing rax, to show none of the vector registers are being used
    call printf

    xor %eax, %eax    # Return 0 (no error :D)
    leave
    ret

wrong_args:
    mov $two_args_msg, %rdi
    call printf
    mov $1, %eax # Return 1 (error)
    leave
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

