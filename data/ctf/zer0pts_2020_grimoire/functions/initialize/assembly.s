initialize proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     rax, cs:stdin@@GLIBC_2_2_5
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setbuf
    mov     rax, cs:stdout@@GLIBC_2_2_5
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setbuf
    mov     rax, cs:stderr@@GLIBC_2_2_5
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setbuf
    lea     rsi, handler; handler
    mov     edi, 0Eh; sig
    call    _signal
    mov     edi, 3Ch ; '<'; seconds
    call    _alarm
    mov     rax, 6572696F6D697267h
    mov     cs:filepath, rax
    mov     cs:dword_202288, 7478742Eh
    mov     cs:byte_20228C, 0
    mov     cs:init, 0
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_1476
    call    ___stack_chk_fail
locret_1476:
    leave
    retn
initialize endp

