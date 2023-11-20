del proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, aWhatHeroDoYouW_0; "What hero do you want to remove?"
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
    ja      short loc_CFD
    mov     eax, [rbp+var_24]
    lea     rdx, ds:0[rax*8]
    lea     rax, name
    mov     rax, [rdx+rax]
    test    rax, rax
    jnz     short loc_D0B
loc_CFD:
    lea     rdi, aNoSuchHero; "No such hero!"
    call    puts
    jmp     short loc_D87
loc_D0B:
    mov     eax, [rbp+var_24]
    lea     rdx, ds:0[rax*8]
    lea     rax, name
    mov     rax, [rdx+rax]
    mov     rdi, rax; ptr
    call    free
    mov     eax, [rbp+var_24]
    lea     rdx, ds:0[rax*8]
    lea     rax, power
    mov     rax, [rdx+rax]
    mov     rdi, rax; ptr
    call    free
    mov     eax, [rbp+var_24]
    lea     rdx, ds:0[rax*8]
    lea     rax, name
    mov     qword ptr [rdx+rax], 0
    mov     eax, [rbp+var_24]
    lea     rdx, ds:0[rax*8]
    lea     rax, power
    mov     qword ptr [rdx+rax], 0
    lea     rdi, aDone; "Done!"
    call    puts
loc_D87:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_D9B
    call    __stack_chk_fail
locret_D9B:
    leave
    retn
del endp

