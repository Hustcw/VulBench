sub_400D2C proc
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 18h
    mov     [rbp+var_20], 0
    jmp     loc_400DEE
loc_400D41:
    mov     eax, [rbp+var_20]
    cdqe
    mov     rax, ds:ptr[rax*8]
    test    rax, rax
    jnz     loc_400DEA
    mov     edi, offset aPleaseEnterThe; "Please enter the name's size: "
    call    sub_400C52
    mov     eax, 0
    call    sub_400C90
    mov     [rbp+var_1C], eax
    cmp     [rbp+var_1C], 0
    jle     loc_400DFA
    cmp     [rbp+var_1C], 1000h
    jg      short loc_400DFA
    mov     eax, [rbp+var_1C]
    add     eax, 10h
    cdqe
    mov     rdi, rax; size
    call    _malloc
    mov     [rbp+var_18], rax
    mov     rax, [rbp+var_18]
    mov     qword ptr [rax], 0
    mov     rax, [rbp+var_18]
    lea     rbx, [rax+8]
    mov     edi, 0; timer
    call    _time
    mov     [rbx], rax
    mov     edi, offset aPleaseEnterThe_0; "Please enter the name: "
    call    sub_400C52
    mov     eax, [rbp+var_1C]
    cdqe
    mov     rdx, [rbp+var_18]
    add     rdx, 10h
    mov     rsi, rax
    mov     rdi, rdx
    call    sub_400B76
    mov     eax, [rbp+var_20]
    cdqe
    mov     rdx, [rbp+var_18]
    mov     ds:ptr[rax*8], rdx
    jmp     short loc_400DFA
loc_400DEA:
    add     [rbp+var_20], 1
loc_400DEE:
    cmp     [rbp+var_20], 0Fh
    jle     loc_400D41
    jmp     short loc_400DFB
loc_400DFA:
    nop
loc_400DFB:
    add     rsp, 18h
    pop     rbx
    pop     rbp
    retn
sub_400D2C endp

