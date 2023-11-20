sub_40114A proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+dest], rdi
    mov     [rbp+var_C], esi
    mov     eax, [rbp+var_C]
    cdqe
    shl     rax, 5
    lea     rdx, aAttack[rax]; "attack"
    mov     rax, [rbp+dest]
    mov     rsi, rdx; src
    mov     rdi, rax; dest
    call    _strcpy
    nop
    leave
    retn
sub_40114A endp

