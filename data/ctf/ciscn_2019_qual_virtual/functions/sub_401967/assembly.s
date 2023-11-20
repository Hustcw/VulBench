sub_401967 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     [rbp+var_18], rdi
    mov     [rbp+var_20], rsi
    mov     [rbp+var_28], rdx
    mov     [rbp+var_C], 1
    jmp     loc_401A86
loc_401987:
    mov     rax, [rbp+var_8]
    sub     rax, 11h; switch 34 cases
    cmp     rax, 21h
    ja      def_4019B7; jumptable 00000000004019B7 default case, cases 19-32,37-48
    lea     rdx, ds:0[rax*4]
    lea     rax, jpt_4019B7
    mov     eax, ds:(jpt_4019B7 - 402088h)[rdx+rax]
    cdqe
    lea     rdx, jpt_4019B7
    add     rax, rdx
def_4019B7:
    jmp     rax; switch jump
    mov     rdx, [rbp+var_20]; jumptable 00000000004019B7 case 17
    mov     rax, [rbp+var_28]
    mov     rsi, rdx
    mov     rdi, rax
    call    sub_401AAC
    mov     [rbp+var_C], eax
    jmp     loc_401A86
    mov     rdx, [rbp+var_20]; jumptable 00000000004019B7 case 18
    mov     rax, [rbp+var_28]
    mov     rsi, rdx
    mov     rdi, rax
    call    sub_401AF8
    mov     [rbp+var_C], eax
    jmp     loc_401A86
    mov     rdx, [rbp+var_20]; jumptable 00000000004019B7 case 33
    mov     rax, [rbp+var_28]
    mov     rsi, rdx
    mov     rdi, rax
    call    sub_401B44
    mov     [rbp+var_C], eax
    jmp     short loc_401A86
    mov     rdx, [rbp+var_20]; jumptable 00000000004019B7 case 34
    mov     rax, [rbp+var_28]
    mov     rsi, rdx
    mov     rdi, rax
    call    sub_401BA5
    mov     [rbp+var_C], eax
    jmp     short loc_401A86
    mov     rdx, [rbp+var_20]; jumptable 00000000004019B7 case 35
    mov     rax, [rbp+var_28]
    mov     rsi, rdx
    mov     rdi, rax
    call    sub_401C06
    mov     [rbp+var_C], eax
    jmp     short loc_401A86
    mov     rdx, [rbp+var_20]; jumptable 00000000004019B7 case 36
    mov     rax, [rbp+var_28]
    mov     rsi, rdx
    mov     rdi, rax
    call    sub_401C68
    mov     [rbp+var_C], eax
    jmp     short loc_401A86
    mov     rdx, [rbp+var_20]; jumptable 00000000004019B7 case 49
    mov     rax, [rbp+var_28]
    mov     rsi, rdx
    mov     rdi, rax
    call    sub_401CCE
    mov     [rbp+var_C], eax
    jmp     short loc_401A86
    mov     rdx, [rbp+var_20]; jumptable 00000000004019B7 case 50
    mov     rax, [rbp+var_28]
    mov     rsi, rdx
    mov     rdi, rax
    call    sub_401D37
    mov     [rbp+var_C], eax
    jmp     short loc_401A86
    mov     [rbp+var_C], 0; jumptable 00000000004019B7 default case, cases 19-32,37-48
loc_401A86:
    cmp     [rbp+var_C], 0
    jz      short loc_401AA7
    lea     rdx, [rbp+var_8]
    mov     rax, [rbp+var_18]
    mov     rsi, rdx
    mov     rdi, rax
    call    sub_4014B4
    test    eax, eax
    jnz     loc_401987
loc_401AA7:
    mov     eax, [rbp+var_C]
    leave
    retn
sub_401967 endp

