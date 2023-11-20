sub_D8E proc
    push    ebp
    mov     ebp, esp
    push    ebx
    sub     esp, 24h
    call    sub_590
    add     ebx, (offset off_2FB8 - $)
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    cmp     [ebp+arg_0], 0
    jz      short loc_DD6
    sub     esp, 0Ch
    lea     eax, (aYourNote - 2FB8h)[ebx]; "Your note: "
    push    eax; format
    call    _printf
    add     esp, 10h
    sub     esp, 8
    push    14h
    lea     eax, [ebp+s]
    push    eax
    call    sub_6C0
    add     esp, 10h
    jmp     short loc_DF7
loc_DD6:
    sub     esp, 0Ch
    lea     eax, (aYourNote - 2FB8h)[ebx]; "Your note: "
    push    eax; format
    call    _printf
    add     esp, 10h
    sub     esp, 0Ch
    lea     eax, [ebp+s]
    push    eax; s
    call    _puts
    add     esp, 10h
loc_DF7:
    nop
    mov     eax, [ebp+var_C]
    xor     eax, large gs:14h
    jz      short loc_E09
    call    sub_1030
loc_E09:
    mov     ebx, [ebp+var_4]
    leave
    retn
sub_D8E endp

