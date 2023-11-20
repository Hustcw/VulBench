sub_400D58 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_18], rdi
    call    _rand
    and     eax, 0FFFFh
    mov     [rbp+var_4], eax
    mov     ecx, [rbp+var_4]
    mov     edx, 10624DD3h
    mov     eax, ecx
    imul    edx
    sar     edx, 6
    mov     eax, ecx
    sar     eax, 1Fh
    sub     edx, eax
    mov     eax, edx
    imul    eax, 3E8h
    sub     ecx, eax
    mov     eax, ecx
    movsxd  rdx, eax
    mov     rax, [rbp+var_18]
    mov     [rax], rdx
    nop
    leave
    retn
sub_400D58 endp

