sub_C64 proc
    push    rbp
    mov     rbp, rsp
    mov     [rbp+var_14], edi
    mov     [rbp+var_18], esi
    mov     [rbp+var_1C], edx
    mov     eax, [rbp+var_18]
    mov     edx, 1
    mov     ecx, eax
    shl     edx, cl
    mov     eax, [rbp+var_1C]
    mov     esi, 1
    mov     ecx, eax
    shl     esi, cl
    mov     eax, esi
    or      eax, edx
    mov     [rbp+var_4], eax
    lea     rax, dword_202040
    mov     edx, [rbp+var_14]
    movsxd  rdx, edx
    mov     eax, [rax+rdx*4]
    and     eax, [rbp+var_4]
    cmp     eax, [rbp+var_4]
    jz      short loc_CAF
    mov     eax, 0
    jmp     short loc_CB4
loc_CAF:
    mov     eax, 1
loc_CB4:
    pop     rbp
    retn
sub_C64 endp

