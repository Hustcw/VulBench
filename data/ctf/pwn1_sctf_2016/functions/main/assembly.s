main proc
    push    ebp
    mov     ebp, esp
    and     esp, 0FFFFFFF0h
    call    vuln
    mov     eax, 0
    leave
    retn
main endp

