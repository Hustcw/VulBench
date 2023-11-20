del_note proc
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
    jle     short loc_8048865
    sub     esp, 0Ch
    push    offset aOutOfBound; "Out of bound !!"
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    0; status
    call    _exit
loc_8048865:
    mov     eax, [ebp+var_C]
    mov     eax, ds:note[eax*4]
    sub     esp, 0Ch
    push    eax; ptr
    call    _free
    add     esp, 10h
    mov     eax, [ebp+var_C]
    mov     ds:note[eax*4], 0
    nop
    leave
    retn
del_note endp

