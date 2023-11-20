sub_400F46 proc
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 28h
    mov     [rbp+var_28], rdi
    call    _rand
    cdqe
    movzx   ebx, ax
    call    _rand
    cdqe
    shl     rax, 10h
    and     eax, 8FFFFFFFh
    or      rbx, rax
    call    _rand
    cdqe
    shl     rax, 20h
    mov     rdx, rax
    mov     rax, 0FFFF00000000h
    and     rax, rdx
    or      rax, rbx
    mov     [rbp+var_18], rax
    mov     rax, [rbp+var_28]
    mov     ecx, 0FFFFFFFFh
    mov     [rax], rcx
    nop
    add     rsp, 28h
    pop     rbx
    pop     rbp
    retn
sub_400F46 endp

