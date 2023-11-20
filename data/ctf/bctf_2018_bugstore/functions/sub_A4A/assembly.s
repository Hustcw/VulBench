sub_A4A proc
    sub     rsp, 148h
    mov     rax, fs:28h
    mov     [rsp+148h+var_10], rax
    xor     eax, eax
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, cs:stdin; stream
    call    setvbuf
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, cs:stdout; stream
    call    setvbuf
    mov     rdi, rsp
    lea     rsi, asc_EB0; "======================================="...
    mov     ecx, 25h ; '%'
    rep movsq
    mov     eax, [rsi]
    mov     [rdi], eax
    movzx   eax, word ptr cs:asc_EB0+12Ch; "\n"
    mov     [rdi+4], ax
    mov     rdi, rsp; s
    call    puts
    lea     rsi, handler; handler
    mov     edi, 0Eh; sig
    call    signal
    mov     edi, 32h ; '2'; seconds
    call    alarm
    mov     rax, [rsp+148h+var_10]
    xor     rax, fs:28h
    jz      short loc_AF6
    call    __stack_chk_fail
loc_AF6:
    add     rsp, 148h
    retn
sub_A4A endp

