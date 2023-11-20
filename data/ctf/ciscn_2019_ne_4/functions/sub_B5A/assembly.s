sub_B5A proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, s; "Welcome to Children's Day Paradise.\nPl"...
    call    puts
    lea     rdi, a1GetTicket; "1. GET TICKET"
    call    puts
    lea     rdi, a2PalyGane; "2. PALY GANE"
    call    puts
    lea     rdi, a3GameOver; "3. GAME OVER"
    call    puts
    lea     rdi, a4LookGane; "4. LOOK GANE"
    call    puts
    lea     rdi, a5ExitGame; "5. EXIT GAME"
    call    puts
    lea     rdi, format; "CHOICE: "
    mov     eax, 0
    call    printf
    mov     rdx, [rbp+var_8]
    xor     rdx, fs:28h
    jz      short locret_BDE
    call    __stack_chk_fail
locret_BDE:
    leave
    retn
sub_B5A endp

