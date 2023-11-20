sub_B47 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, aWhichGoodsThat; "Which goods that you don't need?"
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
    mov     [rbp+var_28], rax
    mov     rax, cs:qword_202090
    cmp     [rbp+var_28], rax
    jbe     short loc_BB7
    lea     rdi, aThatGoodsIsOut; "That goods is out of your cart."
    call    _puts
    jmp     short loc_BC3
loc_BB7:
    mov     rax, [rbp+var_28]
    mov     rdi, rax
    call    sub_AD0
loc_BC3:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_BD7
    call    ___stack_chk_fail
locret_BD7:
    leave
    retn
sub_B47 endp

