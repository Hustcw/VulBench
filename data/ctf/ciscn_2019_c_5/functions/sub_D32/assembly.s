sub_D32 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, aPleaseInputThe_0; "Please input the index:"
    call    puts
    lea     rax, [rbp+var_C]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    __isoc99_scanf
    mov     eax, [rbp+var_C]
    cdqe
    shl     rax, 4
    mov     rdx, rax
    lea     rax, unk_202068
    mov     rax, [rdx+rax]
    mov     rdi, rax; ptr
    call    free
    lea     rdi, aDone; "Done!"
    call    puts
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_DAD
    call    __stack_chk_fail
locret_DAD:
    leave
    retn
sub_D32 endp

