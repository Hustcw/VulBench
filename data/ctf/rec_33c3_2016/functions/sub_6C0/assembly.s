sub_6C0 proc
    push    ebp
    mov     ebp, esp
    push    ebx
    sub     esp, 14h
    call    sub_590
    add     ebx, (offset off_2FB8 - $)
    call    _getchar
    mov     [ebp+var_10], eax
    mov     [ebp+var_C], 0
    jmp     short loc_6FE
loc_6E3:
    mov     eax, [ebp+var_C]
    lea     edx, [eax+1]
    mov     [ebp+var_C], edx
    mov     edx, [ebp+arg_0]
    add     eax, edx
    mov     edx, [ebp+var_10]
    mov     [eax], dl
    call    _getchar
    mov     [ebp+var_10], eax
loc_6FE:
    mov     eax, [ebp+var_C]
    cmp     eax, [ebp+arg_4]
    jnb     short loc_712
    cmp     [ebp+var_10], 0FFFFFFFFh
    jz      short loc_712
    cmp     [ebp+var_10], 0Ah
    jnz     short loc_6E3
loc_712:
    mov     edx, [ebp+arg_0]
    mov     eax, [ebp+var_C]
    add     eax, edx
    mov     byte ptr [eax], 0
    mov     eax, [ebp+arg_4]
    lea     edx, [eax-1]
    mov     eax, [ebp+arg_0]
    add     eax, edx
    mov     byte ptr [eax], 0
    nop
    add     esp, 14h
    pop     ebx
    pop     ebp
    retn
sub_6C0 endp

