sub_400B41 proc
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
    ja      short loc_400BF1
    mov     eax, [rbp+var_24]
    mov     rax, ds:ptr[rax*8]
    test    rax, rax
    jz      short loc_400BF1
    mov     eax, cs:dword_602098
    cmp     eax, 2
    jg      short loc_400BF4
    mov     eax, [rbp+var_24]
    mov     rax, ds:ptr[rax*8]
    mov     rdi, rax; ptr
    call    free
    mov     eax, cs:dword_602098
    add     eax, 1
    mov     cs:dword_602098, eax
    mov     edi, offset aDone; "Done!"
    call    puts
    jmp     short loc_400BF5
loc_400BF1:
    nop
    jmp     short loc_400BF5
loc_400BF4:
    nop
loc_400BF5:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_400C09
    call    __stack_chk_fail
locret_400C09:
    leave
    retn
sub_400B41 endp

