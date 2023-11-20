sub_E0E proc
    push    ebp
    mov     ebp, esp
    push    ebx
    sub     esp, 14h
    call    sub_590
    add     ebx, (offset off_2FB8 - $)
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
loc_E2B:
    sub     esp, 0Ch
    lea     eax, (a0TakeNote - 2FB8h)[ebx]; "0 - Take note"
    push    eax; s
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    lea     eax, (a1ReadNote - 2FB8h)[ebx]; "1 - Read note"
    push    eax; s
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    lea     eax, (a2Polish - 2FB8h)[ebx]; "2 - Polish"
    push    eax; s
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    lea     eax, (a3Infix - 2FB8h)[ebx]; "3 - Infix"
    push    eax; s
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    lea     eax, (a4ReversePolish - 2FB8h)[ebx]; "4 - Reverse Polish"
    push    eax; s
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    lea     eax, (a5Sign - 2FB8h)[ebx]; "5 - Sign"
    push    eax; s
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    lea     eax, (a6Exit - 2FB8h)[ebx]; "6 - Exit"
    push    eax; s
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    lea     eax, (asc_10FE - 2FB8h)[ebx]; "> "
    push    eax; format
    call    _printf
    add     esp, 10h
    sub     esp, 8
    push    2
    lea     eax, [ebp+var_E]
    push    eax
    call    sub_6C0
    add     esp, 10h
    movzx   eax, [ebp+var_E]
    cmp     al, 30h ; '0'
    jnz     short loc_EE1
    sub     esp, 0Ch
    push    1
    call    sub_D8E
    add     esp, 10h
loc_EE1:
    movzx   eax, [ebp+var_E]
    cmp     al, 31h ; '1'
    jnz     short loc_EF6
    sub     esp, 0Ch
    push    0
    call    sub_D8E
    add     esp, 10h
loc_EF6:
    movzx   eax, [ebp+var_E]
    cmp     al, 32h ; '2'
    jnz     short loc_F03
    call    sub_AA3
loc_F03:
    movzx   eax, [ebp+var_E]
    cmp     al, 33h ; '3'
    jnz     short loc_F10
    call    sub_87B
loc_F10:
    movzx   eax, [ebp+var_E]
    cmp     al, 34h ; '4'
    jnz     short loc_F1D
    call    sub_732
loc_F1D:
    movzx   eax, [ebp+var_E]
    cmp     al, 35h ; '5'
    jnz     short loc_F2A
    call    sub_D57
loc_F2A:
    movzx   eax, [ebp+var_E]
    cmp     al, 36h ; '6'
    jz      short loc_F37
    jmp     loc_E2B
loc_F37:
    nop
    mov     eax, [ebp+var_C]
    xor     eax, large gs:14h
    jz      short loc_F49
    call    sub_1030
loc_F49:
    mov     ebx, [ebp+var_4]
    leave
    retn
sub_E0E endp

