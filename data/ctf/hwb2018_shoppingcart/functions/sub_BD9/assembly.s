sub_BD9 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, aWhichGoodsYouN; "Which goods you need to modify?"
    call    _puts
    mov     rdx, cs:stdin; stream
    lea     rax, [rbp+s]
    mov     esi, 18h; n
    mov     rdi, rax; s
    call    _fgets
    lea     rax, [rbp+s]
    mov     edx, 0; base
    mov     esi, 0; endptr
    mov     rdi, rax; nptr
    call    _strtoul
    mov     [rbp+var_30], rax
    mov     rax, [rbp+var_30]
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_2021E0
    mov     rax, [rdx+rax]
    mov     rax, [rax]
    mov     rsi, rax
    lea     rdi, format; "OK, what would you like to modify %s to"...
    mov     eax, 0
    call    _printf
    mov     rax, [rbp+var_30]
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_2021E0
    mov     rax, [rdx+rax]
    mov     rax, [rax]
    mov     edx, 8; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    mov     [rbp+var_28], rax
    mov     rax, [rbp+var_30]
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_2021E0
    mov     rax, [rdx+rax]
    mov     rdx, [rax]
    mov     rax, [rbp+var_28]
    add     rax, rdx
    mov     byte ptr [rax], 0
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_CC5
    call    ___stack_chk_fail
locret_CC5:
    leave
    retn
sub_BD9 endp

