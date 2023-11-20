main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     eax, 0
    call    sub_400842
loc_400B36:
    mov     edi, offset aGuessYourOptio; "Guess your option:"
    mov     eax, 0
    call    printf
    lea     rax, [rbp+s]
    mov     edx, 10h; n
    mov     esi, 0; c
    mov     rdi, rax; s
    call    memset
    lea     rax, [rbp+s]
    mov     edx, 10h; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    lea     rax, [rbp+s]
    mov     rdi, rax; nptr
    call    atoi
    mov     [rbp+var_24], eax
    cmp     [rbp+var_24], 2
    jz      short loc_400BB1
    cmp     [rbp+var_24], 2
    jg      short loc_400B94
    cmp     [rbp+var_24], 1
    jz      short loc_400BA5
    jmp     short loc_400BD5
loc_400B94:
    cmp     [rbp+var_24], 3
    jz      short loc_400BBD
    cmp     [rbp+var_24], 2333h
    jz      short loc_400BC9
    jmp     short loc_400BD5
loc_400BA5:
    mov     eax, 0
    call    sub_400A22
    jmp     short loc_400BDF
loc_400BB1:
    mov     eax, 0
    call    sub_400999
    jmp     short loc_400BDF
loc_400BBD:
    mov     eax, 0
    call    sub_400A9B
    jmp     short loc_400BDF
loc_400BC9:
    mov     eax, 0
    call    sub_4008A3
    jmp     short loc_400BDF
loc_400BD5:
    mov     edi, offset aHaha; "haha"
    call    puts
loc_400BDF:
    jmp     loc_400B36
main endp

