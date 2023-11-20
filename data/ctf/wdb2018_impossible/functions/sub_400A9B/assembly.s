sub_400A9B proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     edi, offset aThisIsAReallyP; "This is a really powerful weapon...(to "...
    call    puts
    lea     rax, [rbp+s]
    mov     edx, 8; n
    mov     esi, 0; c
    mov     rdi, rax; s
    call    memset
    lea     rax, [rbp+s]
    mov     edx, 2; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    lea     rax, [rbp+s]
    mov     esi, 1
    mov     rdi, rax; format
    mov     eax, 0
    call    printf
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_400B13
    call    __stack_chk_fail
locret_400B13:
    leave
    retn
sub_400A9B endp

