sub_D38 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, s; "1. add"
    call    puts
    lea     rdi, a2Show; "2. show"
    call    puts
    lea     rdi, a3Remove; "3. remove"
    call    puts
    lea     rdi, a4Exit; "4. exit"
    call    puts
    lea     rdi, aChoice; "choice> "
    mov     eax, 0
    call    printf
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_DA5
    call    __stack_chk_fail
locret_DA5:
    leave
    retn
sub_D38 endp

