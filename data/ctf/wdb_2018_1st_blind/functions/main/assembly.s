main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     eax, 0
    call    sub_400882
loc_400C2C:
    mov     eax, 0
    call    sub_4008F4
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
    cmp     [rbp+var_24], 2
    jz      short loc_400C8F
    cmp     [rbp+var_24], 3
    jz      short loc_400C9B
    cmp     [rbp+var_24], 1
    jnz     short loc_400CA7
    mov     eax, 0
    call    sub_4009A7
    jmp     short loc_400CB1
loc_400C8F:
    mov     eax, 0
    call    sub_400A80
    jmp     short loc_400CB1
loc_400C9B:
    mov     eax, 0
    call    sub_400B41
    jmp     short loc_400CB1
loc_400CA7:
    mov     edi, 0; status
    call    exit
loc_400CB1:
    jmp     loc_400C2C
main endp

