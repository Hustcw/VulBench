vuln proc
    push    ebp
    mov     ebp, esp
    sub     esp, 18h
    sub     esp, 0Ch
    push    offset aEnterYourInput; "Enter your input> "
    call    _printf
    add     esp, 10h
    sub     esp, 0Ch
    lea     eax, [ebp+s]
    push    eax; s
    call    _gets
    add     esp, 10h
    leave
    retn
vuln endp

