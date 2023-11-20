sub_CDB proc
    push    ebp
    mov     ebp, esp
    push    ebx
    sub     esp, 24h
    call    sub_590
    add     ebx, (offset off_2FB8 - $)
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    sub     esp, 8
    push    0Ch
    lea     eax, [ebp+nptr]
    push    eax
    call    sub_6C0
    add     esp, 10h
    sub     esp, 0Ch
    lea     eax, [ebp+nptr]
    push    eax; nptr
    call    _atoi
    add     esp, 10h
    mov     [ebp+var_1C], eax
    cmp     [ebp+var_1C], 0
    jle     short loc_D2C
    lea     eax, (sub_C85 - 2FB8h)[ebx]
    mov     [ebp+var_20], eax
    jmp     short loc_D3B
loc_D2C:
    cmp     [ebp+var_1C], 0
    jns     short loc_D3B
    lea     eax, (sub_CB0 - 2FB8h)[ebx]
    mov     [ebp+var_20], eax
loc_D3B:
    mov     eax, [ebp+var_20]
    call    eax
    nop
    mov     eax, [ebp+var_C]
    xor     eax, large gs:14h
    jz      short loc_D52
    call    sub_1030
loc_D52:
    mov     ebx, [ebp+var_4]
    leave
    retn
sub_CDB endp

