add proc
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 18h
    mov     [rbp+var_14], 0
    jmp     short loc_AB4
loc_A93:
    mov     eax, [rbp+var_14]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, name
    mov     rax, [rdx+rax]
    test    rax, rax
    jz      short loc_ABC
    add     [rbp+var_14], 1
loc_AB4:
    cmp     [rbp+var_14], 9
    jle     short loc_A93
    jmp     short loc_ABD
loc_ABC:
    nop
loc_ABD:
    cmp     [rbp+var_14], 0Ah
    jnz     short loc_AD4
    lea     rdi, s; "You can't add more heros!"
    call    puts
    jmp     loc_BB4
loc_AD4:
    mov     edi, 68h ; 'h'; size
    call    malloc
    mov     rcx, rax
    mov     eax, [rbp+var_14]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, name
    mov     [rdx+rax], rcx
    mov     edi, 0F8h; size
    call    malloc
    mov     rcx, rax
    mov     eax, [rbp+var_14]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, power
    mov     [rdx+rax], rcx
    lea     rdi, aWhatSYourHeroS; "What's your hero's name:"
    call    puts
    mov     eax, [rbp+var_14]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, name
    mov     rbx, [rdx+rax]
    mov     eax, [rbp+var_14]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, name
    mov     rax, [rdx+rax]
    mov     edx, 68h ; 'h'; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    add     rax, rbx
    mov     byte ptr [rax], 0
    lea     rdi, aWhatSYourHeroS_0; "What's your hero's power:"
    call    puts
    mov     eax, [rbp+var_14]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, power
    mov     rax, [rdx+rax]
    mov     edx, 0F8h; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    lea     rdi, aDone; "Done!"
    call    puts
loc_BB4:
    add     rsp, 18h
    pop     rbx
    pop     rbp
    retn
add endp

