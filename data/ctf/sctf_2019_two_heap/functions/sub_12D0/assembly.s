sub_12D0 proc
    sub     rsp, 18h
    mov     rdi, cs:stdin; stream
    xor     ecx, ecx; n
    xor     esi, esi; buf
    mov     rax, fs:28h
    mov     [rsp+18h+var_10], rax
    xor     eax, eax
    mov     edx, 2; modes
    call    _setvbuf
    mov     rdi, cs:stderr; stream
    xor     ecx, ecx; n
    xor     esi, esi; buf
    mov     edx, 2; modes
    call    _setvbuf
    mov     rdi, cs:stdout; stream
    xor     ecx, ecx; n
    xor     esi, esi; buf
    mov     edx, 2; modes
    call    _setvbuf
    mov     rax, [rsp+18h+var_10]
    xor     rax, fs:28h
    jnz     short loc_1341
    mov     edi, 20h ; ' '; seconds
    add     rsp, 18h
    jmp     _alarm
loc_1341:
    call    ___stack_chk_fail
sub_12D0 endp

