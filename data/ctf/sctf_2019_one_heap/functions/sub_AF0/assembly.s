sub_AF0 proc
    sub     rsp, 18h
    mov     rdi, cs:stdin; stream
    xor     ecx, ecx; n
    xor     esi, esi; buf
    mov     edx, 2; modes
    mov     rax, fs:28h
    mov     [rsp+18h+var_10], rax
    xor     eax, eax
    call    setvbuf
    mov     rdi, cs:stderr; stream
    xor     ecx, ecx; n
    xor     esi, esi; buf
    mov     edx, 2; modes
    call    setvbuf
    mov     rdi, cs:stdout; stream
    xor     ecx, ecx; n
    xor     esi, esi; buf
    mov     edx, 2; modes
    call    setvbuf
    mov     rax, [rsp+18h+var_10]
    xor     rax, fs:28h
    jnz     short loc_B61
    mov     edi, 20h ; ' '; seconds
    add     rsp, 18h
    jmp     alarm
loc_B61:
    call    __stack_chk_fail
sub_AF0 endp

