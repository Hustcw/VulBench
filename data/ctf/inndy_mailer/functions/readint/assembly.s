readint proc
    push    ebp
    mov     ebp, esp
    sub     esp, 38h
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    mov     eax, ds:stdin@@GLIBC_2_0
    sub     esp, 4
    push    eax; stream
    push    20h ; ' '; n
    lea     eax, [ebp+s]
    push    eax; s
    call    _fgets
    add     esp, 10h
    sub     esp, 4
    push    0Ah; base
    push    0; endptr
    lea     eax, [ebp+s]
    push    eax; nptr
    call    _strtoll
    add     esp, 10h
    mov     edx, [ebp+var_C]
    xor     edx, large gs:14h
    jz      short locret_80486A7
    call    ___stack_chk_fail
locret_80486A7:
    leave
    retn
readint endp

