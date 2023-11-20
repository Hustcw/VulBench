do_naenae proc
    push    ebp
    mov     ebp, esp
    sub     esp, 8
    lea     eax, aO; "(\\)\n  \\(:O)\n   /||\\_\n_/"
    mov     [esp], eax; format
    call    _printf
    mov     [ebp+var_4], eax
    add     esp, 8
    pop     ebp
    retn
do_naenae endp

