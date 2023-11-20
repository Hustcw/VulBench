sub_E37 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, aIndex; "index: "
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+var_C]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    ___isoc99_scanf
    mov     eax, [rbp+var_C]
    test    eax, eax
    js      short loc_EC3
    mov     eax, [rbp+var_C]
    cmp     eax, 0Fh
    jg      short loc_EC3
    mov     edx, [rbp+var_C]
    lea     rax, unk_2020C0
    movsxd  rdx, edx
    mov     rax, [rax+rdx*8]
    test    rax, rax
    jz      short loc_EC3
    mov     edx, [rbp+var_C]
    lea     rax, unk_2020C0
    movsxd  rdx, edx
    mov     rax, [rax+rdx*8]
    mov     rdi, rax; s
    call    _puts
    lea     rdi, aDone; "done."
    call    _puts
    jmp     short loc_ECF
loc_EC3:
    lea     rdi, aInvalidIndex; "invalid index."
    call    _puts
loc_ECF:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_EE4
    call    ___stack_chk_fail
locret_EE4:
    leave
    retn
sub_E37 endp

