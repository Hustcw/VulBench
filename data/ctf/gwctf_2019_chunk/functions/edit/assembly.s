edit proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, aWhichBookToWri; "Which book to write?"
    mov     eax, 0
    call    printf
    lea     rax, [rbp+var_C]
    mov     rsi, rax
    lea     rdi, unk_1108
    mov     eax, 0
    call    __isoc99_scanf
    lea     rdi, aContent; "Content: "
    mov     eax, 0
    call    printf
    mov     eax, [rbp+var_C]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, size
    mov     rdx, [rdx+rax]
    mov     eax, [rbp+var_C]
    cdqe
    lea     rcx, ds:0[rax*8]
    lea     rax, chunk
    mov     rax, [rcx+rax]
    mov     rsi, rdx
    mov     rdi, rax
    mov     eax, 0
    call    read_0
    lea     rdi, aDone; "Done!\n"
    call    puts
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_F5E
    call    __stack_chk_fail
locret_F5E:
    leave
    retn
edit endp

