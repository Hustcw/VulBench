sub_804869C proc
    push    ebp
    mov     ebp, esp
    sub     esp, 28h
    mov     eax, [ebp+arg_0]
    mov     [ebp+fd], eax
    mov     eax, [ebp+arg_4]
    mov     [ebp+buf], eax
    mov     eax, [ebp+arg_8]
    mov     [ebp+nbytes], eax
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    cmp     [ebp+nbytes], 0
    jns     short loc_80486CF
    sub     esp, 0Ch
    push    0; status
    call    _exit
loc_80486CF:
    mov     eax, [ebp+nbytes]
    sub     esp, 4
    push    eax; nbytes
    push    [ebp+buf]; buf
    push    [ebp+fd]; fd
    call    _read
    add     esp, 10h
    mov     edx, [ebp+var_C]
    xor     edx, large gs:14h
    jz      short locret_80486F5
    call    ___stack_chk_fail
locret_80486F5:
    leave
    retn
sub_804869C endp

