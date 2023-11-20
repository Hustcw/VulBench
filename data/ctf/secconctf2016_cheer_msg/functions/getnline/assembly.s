getnline proc
    push    ebp
    mov     ebp, esp
    sub     esp, 28h
    mov     eax, ds:stdin@@GLIBC_2_0
    mov     [esp+8], eax; stream
    mov     eax, [ebp+n]
    mov     [esp+4], eax; n
    mov     eax, [ebp+s]
    mov     [esp], eax; s
    call    _fgets
    mov     dword ptr [esp+4], 0Ah; c
    mov     eax, [ebp+s]
    mov     [esp], eax; s
    call    _strchr
    mov     [ebp+var_C], eax
    cmp     [ebp+var_C], 0
    jz      short loc_8048700
    mov     eax, [ebp+var_C]
    mov     byte ptr [eax], 0
loc_8048700:
    mov     eax, [ebp+s]
    mov     [esp], eax; s
    call    _strlen
    leave
    retn
getnline endp

