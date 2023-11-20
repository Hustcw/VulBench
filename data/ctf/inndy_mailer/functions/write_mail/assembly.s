write_mail proc
    push    ebp
    mov     ebp, esp
    sub     esp, 18h
    sub     esp, 0Ch
    push    offset format; "Content Length: "
    call    _printf
    add     esp, 10h
    call    readint
    sub     esp, 0Ch
    push    eax
    call    new_mail
    add     esp, 10h
    mov     [ebp+var_C], eax
    sub     esp, 0Ch
    push    offset aTitle; "Title: "
    call    _printf
    add     esp, 10h
    mov     eax, [ebp+var_C]
    add     eax, 4
    sub     esp, 0Ch
    push    eax; s
    call    _gets
    add     esp, 10h
    sub     esp, 0Ch
    push    offset aContent; "Content: "
    call    _printf
    add     esp, 10h
    mov     eax, [ebp+var_C]
    add     eax, 48h ; 'H'
    sub     esp, 0Ch
    push    eax; s
    call    _gets
    add     esp, 10h
    mov     edx, ds:root
    mov     eax, [ebp+var_C]
    mov     [eax], edx
    mov     eax, [ebp+var_C]
    mov     ds:root, eax
    nop
    leave
    retn
write_mail endp

