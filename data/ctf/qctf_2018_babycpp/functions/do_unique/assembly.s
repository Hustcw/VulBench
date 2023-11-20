do_unique proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+var_8], rdi
    mov     eax, cs:n
    cdqe
    lea     rdx, ds:0[rax*4]
    mov     rax, [rbp+var_8]
    add     rdx, rax
    mov     rax, [rbp+var_8]
    mov     rsi, rdx
    mov     rdi, rax
    call    _ZSt6uniqueIPiET_S1_S1_; std::unique<int *>(int *,int *)
    mov     rax, [rbp+var_8]
    mov     rdi, rax; int *
    call    _Z8show_numPi; show_num(int *)
    nop
    leave
    retn
do_unique endp

