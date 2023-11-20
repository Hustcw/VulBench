sub_4013A0 proc
    push    rbp
    mov     rbp, rsp
    mov     [rbp+var_8], rdi
    mov     [rbp+var_C], esi
    mov     eax, [rbp+var_C]
    movsxd  rdx, eax
    mov     rax, [rbp+var_8]
    mov     [rax], rdx
    mov     rax, [rbp+var_8]
    mov     rax, [rax]
    mov     rdx, qword_603100[rax*8]
    mov     rax, [rbp+var_8]
    mov     [rax+8], rdx
    nop
    pop     rbp
    retn
sub_4013A0 endp

