sub_400DA0 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_18], rdi
    call    _rand
    mov     ecx, eax
    mov     edx, 10624DD3h
    mov     eax, ecx
    imul    edx
    sar     edx, 6
    mov     eax, ecx
    sar     eax, 1Fh
    sub     edx, eax
    mov     eax, edx
    mov     [rbp+var_8], eax
    mov     eax, [rbp+var_8]
    imul    eax, 3E8h
    sub     ecx, eax
    mov     eax, ecx
    mov     [rbp+var_8], eax
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
    mov     [rbp+var_4], eax
    mov     edx, [rbp+var_4]
    mov     eax, edx
    shl     eax, 2
    add     eax, edx
    sub     ecx, eax
    mov     eax, ecx
    mov     [rbp+var_4], eax
    mov     eax, [rbp+var_4]
    mov     edx, [rbp+var_8]
    mov     ecx, eax
    shl     edx, cl
    mov     ecx, edx
    mov     edx, 51EB851Fh
    mov     eax, ecx
    imul    edx
    sar     edx, 5
    mov     eax, ecx
    sar     eax, 1Fh
    sub     edx, eax
    mov     eax, edx
    imul    eax, 64h ; 'd'
    sub     ecx, eax
    mov     eax, ecx
    movsxd  rdx, eax
    mov     rax, [rbp+var_18]
    mov     [rax], rdx
    nop
    leave
    retn
sub_400DA0 endp

