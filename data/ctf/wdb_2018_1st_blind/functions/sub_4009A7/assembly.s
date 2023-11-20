sub_4009A7 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     edi, offset aIndex; "Index:"
    mov     eax, 0
    call    printf
    lea     rax, [rbp+s]
    mov     edx, 10h; n
    mov     esi, 0; c
    mov     rdi, rax; s
    call    memset
    lea     rax, [rbp+s]
    mov     edx, 0Fh; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    lea     rax, [rbp+s]
    mov     rdi, rax; nptr
    call    atoi
    mov     [rbp+var_24], eax
    cmp     [rbp+var_24], 5
    ja      short loc_400A69
    mov     eax, [rbp+var_24]
    mov     rax, ds:ptr[rax*8]
    test    rax, rax
    jnz     short loc_400A69
    mov     edi, 68h ; 'h'; size
    call    malloc
    mov     rdx, rax
    mov     eax, [rbp+var_24]
    mov     ds:ptr[rax*8], rdx
    mov     edi, offset aContent; "Content:"
    mov     eax, 0
    call    printf
    mov     eax, [rbp+var_24]
    mov     rax, ds:ptr[rax*8]
    mov     esi, 68h ; 'h'
    mov     rdi, rax
    call    sub_400932
    mov     edi, offset aDone; "Done!"
    call    puts
    jmp     short loc_400A6A
loc_400A69:
    nop
loc_400A6A:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_400A7E
    call    __stack_chk_fail
locret_400A7E:
    leave
    retn
sub_4009A7 endp

