sub_DAF proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 50h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, aWelcomeToTheSt; "Welcome to the story kingdom."
    call    puts
    lea     rdi, aWhatSYourName; "What's your name?"
    call    puts
    lea     rax, [rbp+buf]
    mov     edx, 20h ; ' '; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    lea     rax, [rbp+buf]
    mov     rsi, rax
    mov     edi, 1
    mov     eax, 0
    call    __printf_chk
    lea     rdi, aPleaseInputYou; "Please input your ID."
    call    puts
    lea     rax, [rbp+s]
    mov     edx, 8; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    lea     rax, [rbp+s]
    mov     rdi, rax; s
    call    puts
loc_E38:
    mov     eax, 0
    call    sub_B7D
    lea     rax, [rbp+var_44]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    __isoc99_scanf
    call    getchar
    mov     eax, [rbp+var_44]
    cmp     eax, 5; switch 6 cases
    ja      short def_E88; jumptable 0000000000000E88 default case, case 0
    mov     eax, eax
    lea     rdx, ds:0[rax*4]
    lea     rax, jpt_E88
    mov     eax, ds:(jpt_E88 - 1144h)[rdx+rax]
    movsxd  rdx, eax
    lea     rax, jpt_E88
    add     rax, rdx
def_E88:
    jmp     rax; switch jump
    mov     eax, 0; jumptable 0000000000000E88 case 1
    call    sub_BE9
    jmp     short loc_EEE
    mov     eax, 0; jumptable 0000000000000E88 case 2
    call    sub_D1F
    jmp     short loc_EEE
    mov     eax, 0; jumptable 0000000000000E88 case 3
    call    sub_D0C
    jmp     short loc_EEE
    mov     eax, 0; jumptable 0000000000000E88 case 4
    call    sub_D32
    jmp     short loc_EEE
    lea     rdi, aGoodbye; jumptable 0000000000000E88 case 5
    call    puts
    mov     edi, 0; status
    call    exit
    lea     rdi, aWrongChoice; jumptable 0000000000000E88 default case, case 0
    call    puts
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_EF8
    jmp     short loc_EF3
loc_EEE:
    jmp     loc_E38
loc_EF3:
    call    __stack_chk_fail
locret_EF8:
    leave
    retn
sub_DAF endp

