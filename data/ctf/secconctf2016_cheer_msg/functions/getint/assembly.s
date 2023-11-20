getint proc
    push    ebp
    mov     ebp, esp
    sub     esp, 68h
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    mov     dword ptr [esp+4], 40h ; '@'; n
    lea     eax, [ebp+nptr]
    mov     [esp], eax; s
    call    getnline
    lea     eax, [ebp+nptr]
    mov     [esp], eax; nptr
    call    _atoi
    mov     edx, [ebp+var_C]
    xor     edx, large gs:14h
    jz      short locret_804874D
    call    ___stack_chk_fail
locret_804874D:
    leave
    retn
getint endp

