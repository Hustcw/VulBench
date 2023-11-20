new proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     [rbp+var_C], 0
    jmp     short loc_400ACC
loc_400AB6:
    mov     eax, [rbp+var_C]
    cdqe
    mov     rax, ds:note[rax*8]
    test    rax, rax
    jz      short loc_400AD4
    add     [rbp+var_C], 1
loc_400ACC:
    cmp     [rbp+var_C], 1Fh
    jle     short loc_400AB6
    jmp     short loc_400AD5
loc_400AD4:
    nop
loc_400AD5:
    cmp     [rbp+var_C], 20h ; ' '
    jnz     short loc_400AEA
    mov     edi, offset s; "full!"
    call    puts
    jmp     loc_400B7D
loc_400AEA:
    mov     edi, offset aSize; "size?"
    call    puts
    lea     rax, [rbp+var_10]
    mov     rsi, rax
    mov     edi, offset aD; "%d"
    mov     eax, 0
    call    __isoc99_scanf
    mov     eax, [rbp+var_10]
    test    eax, eax
    js      short loc_400B1B
    mov     eax, [rbp+var_10]
    cmp     eax, 1000h
    jle     short loc_400B27
loc_400B1B:
    mov     edi, offset aInvalidSize; "invalid size"
    call    puts
    jmp     short loc_400B7D
loc_400B27:
    mov     eax, [rbp+var_10]
    cdqe
    mov     rdi, rax; size
    call    malloc
    mov     rdx, rax
    mov     eax, [rbp+var_C]
    cdqe
    mov     ds:note[rax*8], rdx
    mov     edx, [rbp+var_10]
    mov     eax, [rbp+var_C]
    cdqe
    mov     ds:note_size[rax*4], edx
    mov     edi, offset aContent; "content?"
    call    puts
    mov     eax, [rbp+var_10]
    movsxd  rdx, eax; nbytes
    mov     eax, [rbp+var_C]
    cdqe
    mov     rax, ds:note[rax*8]
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
loc_400B7D:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_400B91
    call    __stack_chk_fail
locret_400B91:
    leave
    retn
new endp

