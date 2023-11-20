add proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, format; "Give me a book ID: "
    mov     eax, 0
    call    printf
    lea     rax, [rbp+var_10]
    mov     rsi, rax
    lea     rdi, unk_1108
    mov     eax, 0
    call    __isoc99_scanf
    lea     rax, [rbp+var_10]
    mov     rsi, rax
    lea     rdi, aHowLong; "how long: "
    mov     eax, 0
    call    printf
    lea     rax, [rbp+var_14]
    mov     rsi, rax
    lea     rdi, unk_1108
    mov     eax, 0
    call    __isoc99_scanf
    mov     eax, [rbp+var_10]
    test    eax, eax
    js      loc_D32
    mov     eax, [rbp+var_10]
    cmp     eax, 9
    jg      loc_D32
    mov     eax, cs:number
    cmp     eax, 0Ah
    jg      loc_D32
    mov     eax, [rbp+var_14]
    test    eax, eax
    js      short loc_D26
    mov     eax, [rbp+var_14]
    cmp     eax, 0FFh
    jg      short loc_D26
    mov     eax, [rbp+var_10]
    mov     [rbp+var_C], eax
    mov     eax, [rbp+var_14]
    cdqe
    mov     rdi, rax; size
    call    malloc
    mov     rcx, rax
    mov     eax, [rbp+var_C]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, chunk
    mov     [rdx+rax], rcx
    mov     eax, [rbp+var_14]
    cdqe
    mov     rcx, rax
    mov     eax, [rbp+var_C]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, size
    mov     [rdx+rax], rcx
    mov     eax, cs:number
    add     eax, 1
    mov     cs:number, eax
    lea     rdi, aDone; "Done!\n"
    call    puts
    jmp     short loc_D32
loc_D26:
    lea     rdi, aTooLarge; "too large!"
    call    puts
loc_D32:
    mov     rsi, [rbp+var_8]
    xor     rsi, fs:28h
    jz      short locret_D46
    call    __stack_chk_fail
locret_D46:
    leave
    retn
add endp

