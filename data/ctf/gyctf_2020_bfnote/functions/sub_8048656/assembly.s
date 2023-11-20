sub_8048656 proc
    push    ebp
    mov     ebp, esp
    sub     esp, 18h
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    sub     esp, 4
    push    8; nbytes
    lea     eax, [ebp+buf]
    push    eax; buf
    push    0; fd
    call    _read
    add     esp, 10h
    sub     esp, 0Ch
    lea     eax, [ebp+buf]
    push    eax; nptr
    call    _atol
    add     esp, 10h
    mov     edx, [ebp+var_C]
    xor     edx, large gs:14h
    jz      short locret_804869A
    call    ___stack_chk_fail
locret_804869A:
    leave
    retn
sub_8048656 endp

