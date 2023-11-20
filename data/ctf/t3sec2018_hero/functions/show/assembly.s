show proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, aWhatHeroDoYouW; "What hero do you want to show?"
    call    puts
    lea     rax, [rbp+buf]
    mov     edx, 10h; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    lea     rax, [rbp+buf]
    mov     rdi, rax; nptr
    call    atoi
    mov     [rbp+var_24], eax
    cmp     [rbp+var_24], 9
    ja      short loc_C24
    mov     eax, [rbp+var_24]
    lea     rdx, ds:0[rax*8]
    lea     rax, name
    mov     rax, [rdx+rax]
    test    rax, rax
    jnz     short loc_C32
loc_C24:
    lea     rdi, aNoSuchHero; "No such hero!"
    call    puts
    jmp     short loc_C7E
loc_C32:
    mov     eax, [rbp+var_24]
    lea     rdx, ds:0[rax*8]
    lea     rax, power
    mov     rdx, [rdx+rax]
    mov     eax, [rbp+var_24]
    lea     rcx, ds:0[rax*8]
    lea     rax, name
    mov     rax, [rcx+rax]
    mov     rsi, rax
    lea     rdi, format; "Hero:%s\nPower:%s\n"
    mov     eax, 0
    call    printf
    lea     rdi, aDone; "Done!"
    call    puts
loc_C7E:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_C92
    call    __stack_chk_fail
locret_C92:
    leave
    retn
show endp

