vulnerable_function proc
    push    ebp
    mov     ebp, esp
    sub     esp, 88h
    sub     esp, 0Ch
    push    offset command; "echo Input:"
    call    _system
    add     esp, 10h
    sub     esp, 4
    push    100h; nbytes
    lea     eax, [ebp+buf]
    push    eax; buf
    push    0; fd
    call    _read
    add     esp, 10h
    nop
    leave
    retn
vulnerable_function endp

