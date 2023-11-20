read_num proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     qword ptr [rbp+buf], 0
    mov     qword ptr [rbp+buf+8], 0
    mov     qword ptr [rbp+buf+10h], 0
    mov     qword ptr [rbp+buf+18h], 0
    lea     rax, [rbp+buf]
    mov     ecx, 0Ah; endchar
    mov     edx, 20h ; ' '; len
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read_until
    test    eax, eax
    jns     short loc_A7D
    mov     eax, 0FFFFFFFFh
    jmp     short locret_A89
loc_A7D:
    lea     rax, [rbp+buf]
    mov     rdi, rax; nptr
    call    _atoi
locret_A89:
    leave
    retn
read_num endp

