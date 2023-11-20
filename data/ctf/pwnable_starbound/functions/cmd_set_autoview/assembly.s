cmd_set_autoview proc
    cmp     ds:dword_80580CC, 0
    setz    al
    movzx   eax, al
    mov     ds:dword_80580CC, eax
    retn
cmd_set_autoview endp

