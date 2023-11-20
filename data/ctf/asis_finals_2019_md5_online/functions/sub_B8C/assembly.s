sub_B8C proc
    push    ebp
    mov     ebp, esp
    push    ebx
    sub     esp, 14h
    call    sub_890
    add     ebx, (offset off_2F74 - $)
    mov     [ebp+var_14], 0
    jmp     short loc_C0E
loc_BA7:
    mov     edx, [ebp+var_14]
    mov     eax, [ebp+s]
    add     eax, edx
    sub     esp, 4
    push    1F4h; nbytes
    push    eax; buf
    push    0; fd
    call    _read
    add     esp, 10h
    mov     [ebp+var_10], eax
    cmp     [ebp+var_10], 0
    jnz     short loc_BE7
    sub     esp, 0Ch
    lea     eax, (aRead - 2F74h)[ebx]; "read"
    push    eax; s
    call    _perror
    add     esp, 10h
    sub     esp, 0Ch
    push    1; status
    call    _exit
loc_BE7:
    sub     esp, 8
    push    0Ah; c
    push    [ebp+s]; s
    call    _strchr
    add     esp, 10h
    mov     [ebp+var_C], eax
    cmp     [ebp+var_C], 0
    jz      short loc_C08
    mov     eax, [ebp+var_C]
    mov     byte ptr [eax], 0
    jmp     short loc_C16
loc_C08:
    mov     eax, [ebp+var_10]
    add     [ebp+var_14], eax
loc_C0E:
    mov     eax, [ebp+var_14]
    cmp     eax, [ebp+arg_4]
    jl      short loc_BA7
loc_C16:
    nop
    mov     ebx, [ebp+var_4]
    leave
    retn
sub_B8C endp

