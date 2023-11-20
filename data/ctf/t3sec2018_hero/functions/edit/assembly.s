edit proc
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 38h
    mov     rax, fs:28h
    mov     [rbp+var_18], rax
    xor     eax, eax
    lea     rdi, aWhatHeroDoYouW_1; "What hero do you want to edit?"
    call    puts
    lea     rax, [rbp+buf]
    mov     edx, 10h; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    lea     rax, [rbp+buf]
    mov     rdi, rax; nptr
    call    atoi
    mov     [rbp+var_34], eax
    cmp     [rbp+var_34], 9
    ja      short loc_E07
    mov     eax, [rbp+var_34]
    lea     rdx, ds:0[rax*8]
    lea     rax, name
    mov     rax, [rdx+rax]
    test    rax, rax
    jnz     short loc_E18
loc_E07:
    lea     rdi, aNoSuchHero; "No such hero!"
    call    puts
    jmp     loc_F2A
loc_E18:
    mov     eax, [rbp+var_34]
    lea     rdx, ds:0[rax*8]
    lea     rax, name
    mov     rax, [rdx+rax]
    mov     rdi, rax; ptr
    call    free
    mov     edi, 68h ; 'h'; size
    call    malloc
    mov     rcx, rax
    mov     eax, [rbp+var_34]
    lea     rdx, ds:0[rax*8]
    lea     rax, name
    mov     [rdx+rax], rcx
    lea     rdi, aWhatSYourHeroS; "What's your hero's name:"
    call    puts
    mov     eax, [rbp+var_34]
    lea     rdx, ds:0[rax*8]
    lea     rax, name
    mov     rbx, [rdx+rax]
    mov     eax, [rbp+var_34]
    lea     rdx, ds:0[rax*8]
    lea     rax, name
    mov     rax, [rdx+rax]
    mov     edx, 68h ; 'h'; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    add     rax, rbx
    mov     byte ptr [rax], 0
    mov     eax, [rbp+var_34]
    lea     rdx, ds:0[rax*8]
    lea     rax, power
    mov     rax, [rdx+rax]
    mov     rdi, rax; ptr
    call    free
    mov     edi, 0F8h; size
    call    malloc
    mov     rcx, rax
    mov     eax, [rbp+var_34]
    lea     rdx, ds:0[rax*8]
    lea     rax, power
    mov     [rdx+rax], rcx
    lea     rdi, aWhatSYourHeroS_0; "What's your hero's power:"
    call    puts
    mov     eax, [rbp+var_34]
    lea     rdx, ds:0[rax*8]
    lea     rax, power
    mov     rax, [rdx+rax]
    mov     edx, 0F8h; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    lea     rdi, aDone; "Done!"
    call    puts
loc_F2A:
    mov     rax, [rbp+var_18]
    xor     rax, fs:28h
    jz      short loc_F3E
    call    __stack_chk_fail
loc_F3E:
    add     rsp, 38h
    pop     rbx
    pop     rbp
    retn
edit endp

