sub_400EC8 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_18], rdi
    call    _rand
    mov     ecx, eax
    mov     edx, 14F8B589h
    mov     eax, ecx
    imul    edx
    sar     edx, 0Dh
    mov     eax, ecx
    sar     eax, 1Fh
    sub     edx, eax
    mov     eax, edx
    imul    eax, 186A0h
    sub     ecx, eax
    mov     eax, ecx
    cdqe
    mov     [rbp+var_8], rax
    mov     rax, [rbp+var_8]
    shl     rax, 10h
    mov     rcx, rax
    mov     rdx, 2AAAAAAAAAAAAAABh
    mov     rax, rcx
    imul    rdx
    sar     rdx, 1Ch
    mov     rax, rcx
    sar     rax, 3Fh
    sub     rdx, rax
    mov     rax, rdx
    add     rax, rax
    add     rax, rdx
    shl     rax, 1Dh
    sub     rcx, rax
    mov     rdx, rcx
    mov     rax, [rbp+var_18]
    mov     [rax], rdx
    nop
    leave
    retn
sub_400EC8 endp

