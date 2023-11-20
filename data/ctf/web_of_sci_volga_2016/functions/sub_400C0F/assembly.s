sub_400C0F proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_14], edi
    mov     [rbp+var_4], 0
    cmp     [rbp+var_14], 0
    js      short loc_400C32
    mov     eax, cs:dword_60208C
    cmp     [rbp+var_14], eax
    jl      short loc_400C48
loc_400C32:
    mov     eax, [rbp+var_14]
    mov     esi, eax
    mov     edi, offset aWrongPaperInde; "Wrong paper index %d\n\n\n"
    mov     eax, 0
    call    _printf
    jmp     short locret_400CC4
loc_400C48:
    mov     eax, [rbp+var_14]
    mov     [rbp+var_4], eax
    jmp     short loc_400C9C
loc_400C50:
    mov     eax, [rbp+var_4]
    lea     ecx, [rax+1]
    mov     eax, [rbp+var_4]
    cdqe
    shl     rax, 6
    mov     rdx, rax
    shl     rdx, 4
    add     rax, rdx
    lea     rdx, unk_6020A0[rax]
    movsxd  rax, ecx
    shl     rax, 6
    mov     rcx, rax
    shl     rcx, 4
    add     rax, rcx
    add     rax, 6020A0h
    mov     rsi, rax
    mov     eax, 88h
    mov     rdi, rdx
    mov     rcx, rax
    rep movsq
    add     [rbp+var_4], 1
loc_400C9C:
    mov     eax, cs:dword_60208C
    sub     eax, 1
    cmp     eax, [rbp+var_4]
    jg      short loc_400C50
    mov     eax, cs:dword_60208C
    sub     eax, 1
    mov     cs:dword_60208C, eax
    mov     edi, offset asc_4011CE; "\n"
    call    _puts
    nop
locret_400CC4:
    leave
    retn
sub_400C0F endp

