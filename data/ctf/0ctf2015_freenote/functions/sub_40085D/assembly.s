sub_40085D proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_18], rdi
    mov     [rbp+var_1C], esi
    cmp     [rbp+var_1C], 0
    jg      short loc_400879
    mov     eax, 0
    jmp     short locret_4008C7
loc_400879:
    mov     [rbp+var_8], 0
    jmp     short loc_4008BC
loc_400882:
    mov     eax, [rbp+var_8]
    mov     edx, [rbp+var_1C]
    sub     edx, eax
    mov     eax, edx
    cdqe
    mov     edx, [rbp+var_8]
    movsxd  rcx, edx
    mov     rdx, [rbp+var_18]
    add     rcx, rdx
    mov     rdx, rax; nbytes
    mov     rsi, rcx; buf
    mov     edi, 0; fd
    call    _read
    mov     [rbp+var_4], eax
    cmp     [rbp+var_4], 0
    jg      short loc_4008B6
    jmp     short loc_4008C4
loc_4008B6:
    mov     eax, [rbp+var_4]
    add     [rbp+var_8], eax
loc_4008BC:
    mov     eax, [rbp+var_8]
    cmp     eax, [rbp+var_1C]
    jl      short loc_400882
loc_4008C4:
    mov     eax, [rbp+var_8]
locret_4008C7:
    leave
    retn
sub_40085D endp

