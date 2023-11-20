main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 50h
    lea     rdx, [rbp+buf]
    mov     eax, 0
    mov     ecx, 6
    mov     rdi, rdx
    rep stosq
    mov     edi, 0; timer
    call    time
    mov     qword ptr [rbp+seed], rax
    lea     rdi, aWelcomeLetMeKn; "Welcome, let me know your name: "
    mov     eax, 0
    call    printf
    mov     rax, cs:stdout_ptr
    mov     rax, [rax]
    mov     rdi, rax; stream
    call    fflush
    lea     rax, [rbp+buf]
    mov     edx, 50h ; 'P'; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    mov     [rbp+var_18], rax
    cmp     [rbp+var_18], 31h ; '1'
    jg      short loc_C14
    mov     rax, [rbp+var_18]
    sub     rax, 1
    mov     [rbp+rax+buf], 0
loc_C14:
    lea     rax, [rbp+buf]
    mov     rsi, rax
    lea     rdi, aHiSLetSPlayAGa; "Hi, %s. Let's play a game.\n"
    mov     eax, 0
    call    printf
    mov     rax, cs:stdout_ptr
    mov     rax, [rax]
    mov     rdi, rax; stream
    call    fflush
    mov     rax, qword ptr [rbp+seed]
    mov     edi, eax; seed
    call    srand
    mov     [rbp+var_4], 1
    mov     [rbp+var_19], 0
loc_C54:
    mov     eax, [rbp+var_4]
    mov     esi, eax
    lea     rdi, aGameD50; "Game %d/50\n"
    mov     eax, 0
    call    printf
    mov     eax, 0
    call    sub_A20
    mov     [rbp+var_19], al
    mov     rax, cs:stdout_ptr
    mov     rax, [rax]
    mov     rdi, rax; stream
    call    fflush
    movzx   eax, [rbp+var_19]
    xor     eax, 1
    test    al, al
    jnz     short loc_CB4
    cmp     [rbp+var_19], 0
    jz      short loc_C54
    cmp     [rbp+var_4], 32h ; '2'
    jnz     short loc_CAE
    lea     rax, [rbp+buf]
    mov     rdi, rax
    call    sub_B28
    jmp     short loc_CB5
loc_CAE:
    add     [rbp+var_4], 1
    jmp     short loc_C54
loc_CB4:
    nop
loc_CB5:
    lea     rdi, aByeBye; "Bye bye!"
    call    puts
    mov     eax, 0
    leave
    retn
main endp

