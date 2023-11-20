read_integer proc
    push    ebp
    mov     ebp, esp
    sub     esp, 28h
    mov     eax, ds:stdin@@GLIBC_2_0
    mov     [esp+8], eax; stream
    mov     dword ptr [esp+4], 7; n
    lea     eax, [ebp+buff]
    mov     [esp], eax; s
    call    _fgets
    lea     eax, [ebp+buff]
    mov     [esp], eax; nptr
    call    _atoi
    leave
    retn
read_integer endp

