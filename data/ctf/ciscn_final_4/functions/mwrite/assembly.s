mwrite proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     edi, offset aIndex; "index ?"
    call    puts
    lea     rax, [rbp+var_C]
    mov     rsi, rax
    mov     edi, offset aD; "%d"
    mov     eax, 0
    call    __isoc99_scanf
    mov     eax, [rbp+var_C]
    test    eax, eax
    js      short loc_400C84
    mov     eax, [rbp+var_C]
    cmp     eax, 1Fh
    jg      short loc_400C84
    mov     eax, [rbp+var_C]
    cdqe
    mov     rax, ds:note[rax*8]
    test    rax, rax
    jnz     short loc_400C90
loc_400C84:
    mov     edi, offset aInvalidIndex; "invalid index"
    call    puts
    jmp     short loc_400CA5
loc_400C90:
    mov     eax, [rbp+var_C]
    cdqe
    mov     rax, ds:note[rax*8]
    mov     rdi, rax; s
    call    puts
loc_400CA5:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_400CB9
    call    __stack_chk_fail
locret_400CB9:
    leave
    retn
mwrite endp

