sub_C14 proc
    push    rbp
    mov     rbp, rsp
    mov     [rbp+var_4], edi
    mov     [rbp+var_8], esi
    mov     [rbp+var_C], edx
    lea     rax, dword_202040
    mov     edx, [rbp+var_4]
    movsxd  rdx, edx
    mov     edx, [rax+rdx*4]
    mov     eax, [rbp+var_8]
    mov     esi, 1
    mov     ecx, eax
    shl     esi, cl
    mov     eax, [rbp+var_C]
    mov     edi, 1
    mov     ecx, eax
    shl     edi, cl
    mov     eax, edi
    or      eax, esi
    mov     ecx, edx
    or      ecx, eax
    lea     rax, dword_202040
    mov     edx, [rbp+var_4]
    movsxd  rdx, edx
    mov     [rax+rdx*4], ecx
    nop
    pop     rbp
    retn
sub_C14 endp

