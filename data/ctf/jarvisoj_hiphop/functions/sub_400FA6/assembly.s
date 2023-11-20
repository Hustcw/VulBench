sub_400FA6 proc
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
    mov     [rbp+var_10], rax
    call    _rand
    mov     ecx, eax
    mov     edx, 66666667h
    mov     eax, ecx
    imul    edx
    sar     edx, 1
    mov     eax, ecx
    sar     eax, 1Fh
    sub     edx, eax
    mov     eax, edx
    shl     eax, 2
    add     eax, edx
    sub     ecx, eax
    mov     edx, ecx
    movsxd  rax, edx
    mov     [rbp+var_8], rax
    mov     rax, [rbp+var_8]
    mov     edx, eax
    mov     rax, [rbp+var_10]
    mov     ecx, edx
    shl     rax, cl
    mov     rcx, rax
    mov     rdx, 8000000008000001h
    mov     rax, rcx
    imul    rdx
    lea     rax, [rdx+rcx]
    sar     rax, 23h
    mov     rdx, rax
    mov     rax, rcx
    sar     rax, 3Fh
    sub     rdx, rax
    mov     rax, rdx
    mov     rdx, rax
    shl     rdx, 24h
    sub     rdx, rax
    mov     rax, rcx
    sub     rax, rdx
    mov     rdx, [rbp+var_18]
    mov     [rdx], rax
    nop
    leave
    retn
sub_400FA6 endp

