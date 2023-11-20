admin proc
    push    ebp
    mov     ebp, esp
    sub     esp, 8
    sub     esp, 0Ch
    push    offset command; "sh"
    call    _system
    add     esp, 10h
    nop
    leave
    retn
admin endp

