sub_10D1 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, aRemarks; "remarks> "
    mov     eax, 0
    call    printf
    mov     rax, cs:ptr
    mov     rax, [rax+20h]
    mov     esi, 40h ; '@'
    mov     rdi, rax
    call    sub_B41
    mov     rax, cs:ptr
    mov     rsi, rax
    lea     rdi, aGoodByeS; "good bye %s\n"
    mov     eax, 0
    call    printf
    mov     rax, cs:ptr
    mov     rdi, rax; ptr
    call    free
    mov     edi, 0; status
    call    exit
sub_10D1 endp

