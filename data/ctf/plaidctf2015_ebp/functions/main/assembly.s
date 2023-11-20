main proc
    push    ebp
    mov     ebp, esp
    and     esp, 0FFFFFFF0h
    sub     esp, 10h
    jmp     short loc_8048557
loc_8048552:
    call    echo
loc_8048557:
    mov     eax, ds:stdin@@GLIBC_2_0
    mov     [esp+8], eax; stream
    mov     dword ptr [esp+4], 400h; n
    mov     dword ptr [esp], offset buf; s
    call    _fgets
    test    eax, eax
    jnz     short loc_8048552
    leave
    retn
main endp

