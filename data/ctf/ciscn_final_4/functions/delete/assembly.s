delete proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     edi, offset aPleaseDonTPatc; "please don't patch this function!! I wi"...
    call    puts
    mov     edi, offset aIndex; "index ?"
    call    puts
    lea     rax, [rbp+var_C]
    mov     rsi, rax
    mov     edi, offset aD; "%d"
    mov     eax, 0
    call    __isoc99_scanf
    mov     eax, [rbp+var_C]
    test    eax, eax
    js      short loc_400BF5
    mov     eax, [rbp+var_C]
    cmp     eax, 1Fh
    jg      short loc_400BF5
    mov     eax, [rbp+var_C]
    cdqe
    mov     rax, ds:note[rax*8]
    test    rax, rax
    jnz     short loc_400C01
loc_400BF5:
    mov     edi, offset aInvalidIndex; "invalid index"
    call    puts
    jmp     short loc_400C16
loc_400C01:
    mov     eax, [rbp+var_C]
    cdqe
    mov     rax, ds:note[rax*8]
    mov     rdi, rax; ptr
    call    free
loc_400C16:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_400C2A
    call    __stack_chk_fail
locret_400C2A:
    leave
    retn
delete endp

