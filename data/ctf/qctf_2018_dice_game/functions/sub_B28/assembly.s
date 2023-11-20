sub_B28 proc
    push    rbp
    mov     rbp, rsp
    add     rsp, 0FFFFFFFFFFFFFF80h
    mov     [rbp+var_78], rdi
    mov     rax, [rbp+var_78]
    mov     rsi, rax
    lea     rdi, aCongratsS; "Congrats %s\n"
    mov     eax, 0
    call    printf
    lea     rsi, modes; "r"
    lea     rdi, filename; "flag"
    call    fopen
    mov     [rbp+stream], rax
    mov     rdx, [rbp+stream]; stream
    lea     rax, [rbp+s]
    mov     esi, 64h ; 'd'; n
    mov     rdi, rax; s
    call    fgets
    lea     rax, [rbp+s]
    mov     rdi, rax; s
    call    puts
    mov     rax, cs:stdout_ptr
    mov     rax, [rax]
    mov     rdi, rax; stream
    call    fflush
    nop
    leave
    retn
sub_B28 endp

