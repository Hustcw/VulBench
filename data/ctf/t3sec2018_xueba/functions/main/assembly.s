main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     eax, 0
    call    sub_A50
    lea     rdi, aWelcomeToTheXu; "Welcome to the xueba note system"
    call    puts
loc_F6D:
    mov     eax, 0
    call    sub_A93
    lea     rax, [rbp+var_C]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    __isoc99_scanf
    mov     eax, [rbp+var_C]
    cmp     eax, 5; switch 6 cases
    ja      short def_FB8; jumptable 0000000000000FB8 default case, case 0
    mov     eax, eax
    lea     rdx, ds:0[rax*4]
    lea     rax, jpt_FB8
    mov     eax, ds:(jpt_FB8 - 123Ch)[rdx+rax]
    movsxd  rdx, eax
    lea     rax, jpt_FB8
    add     rax, rdx
def_FB8:
    jmp     rax; switch jump
    mov     eax, 0; jumptable 0000000000000FB8 case 1
    call    sub_B0E
    jmp     short loc_1016
    mov     eax, 0; jumptable 0000000000000FB8 case 2
    call    sub_C7E
    jmp     short loc_1016
    mov     eax, 0; jumptable 0000000000000FB8 case 3
    call    sub_D3F
    jmp     short loc_1016
    mov     eax, 0; jumptable 0000000000000FB8 case 4
    call    sub_E11
    jmp     short loc_1016
    lea     rdi, aByeByeHopeYouG; jumptable 0000000000000FB8 case 5
    call    puts
    mov     edi, 0; status
    call    exit
    lea     rdi, aInvalidOption; jumptable 0000000000000FB8 default case, case 0
    call    puts
    mov     edi, 0; status
    call    exit
loc_1016:
    jmp     loc_F6D
main endp

