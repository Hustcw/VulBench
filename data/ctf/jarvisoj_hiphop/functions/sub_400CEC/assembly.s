sub_400CEC proc
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
    mov     [rbp+var_4], eax
    mov     eax, [rbp+var_4]
    imul    eax, 3E8h
    sub     ecx, eax
    mov     eax, ecx
    mov     [rbp+var_4], eax
    mov     eax, [rbp+var_4]
    shl     eax, 10h
    mov     ecx, eax
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
sub_400CEC endp

