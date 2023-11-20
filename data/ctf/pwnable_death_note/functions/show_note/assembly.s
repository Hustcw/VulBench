show_note proc
    push    ebp
    mov     ebp, esp
    sub     esp, 18h
    sub     esp, 0Ch
    push    offset format; "Index :"
    call    _printf
    add     esp, 10h
    call    read_int
    mov     [ebp+var_C], eax
    cmp     [ebp+var_C], 0Ah
    jle     short loc_80488CA
    sub     esp, 0Ch
    push    offset aOutOfBound; "Out of bound !!"
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    0; status
    call    _exit
loc_80488CA:
    mov     eax, [ebp+var_C]
    mov     eax, ds:note[eax*4]
    test    eax, eax
    jz      short loc_80488F3
    mov     eax, [ebp+var_C]
    mov     eax, ds:note[eax*4]
    sub     esp, 8
    push    eax
    push    offset aNameS; "Name : %s\n"
    call    _printf
    add     esp, 10h
loc_80488F3:
    nop
    leave
    retn
show_note endp

