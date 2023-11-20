main proc
    push    ebp
    mov     ebp, esp
    push    ebx
    and     esp, 0FFFFFFF0h
    sub     esp, 110h
    call    init
    lea     ebx, [esp+114h+nptr]
loc_804A61B:
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    call    ds:dword_805817C
    mov     dword ptr [esp+4], 100h; size_t
    mov     [esp], ebx; void *
    call    readn
    test    eax, eax
    jz      short loc_804A666
    mov     dword ptr [esp+8], 0Ah; base
    mov     dword ptr [esp+4], 0; endptr
    mov     [esp], ebx; nptr
    call    _strtol
    test    eax, eax
    jz      short loc_804A666
    call    ds:dword_8058154[eax*4]
    jmp     short loc_804A61B
loc_804A666:
    call    do_bye
    mov     eax, 0
    mov     ebx, [ebp+var_4]
    leave
    retn
main endp

