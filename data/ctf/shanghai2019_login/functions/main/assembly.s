main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     eax, 0
    call    sub_400806
loc_400E04:
    mov     eax, 0
    call    sub_40084F
    mov     [rbp+var_C], 0
    lea     rdi, aChoice; "Choice:"
    call    puts
    lea     rax, [rbp+var_C]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    __isoc99_scanf
    mov     eax, [rbp+var_C]
    cmp     eax, 5; switch 6 cases
    ja      short def_400E62; jumptable 0000000000400E62 default case, case 0
    mov     eax, eax
    lea     rdx, ds:0[rax*4]
    lea     rax, jpt_400E62
    mov     eax, ds:(jpt_400E62 - 4010BCh)[rdx+rax]
    movsxd  rdx, eax
    lea     rax, jpt_400E62
    add     rax, rdx
def_400E62:
    jmp     rax; switch jump
    mov     eax, 0; jumptable 0000000000400E62 case 1
    call    sub_400A67
    jmp     short loc_400EC3
    mov     eax, 0; jumptable 0000000000400E62 case 2
    call    sub_4008C5
    jmp     short loc_400EC3
    mov     eax, 0; jumptable 0000000000400E62 case 3
    call    sub_400C2A
    jmp     short loc_400EC3
    mov     eax, 0; jumptable 0000000000400E62 case 4
    call    sub_400D05
    jmp     short loc_400EC3
    lea     rdi, aExit; jumptable 0000000000400E62 case 5
    call    puts
    mov     eax, 0
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_400ECD
    jmp     short loc_400EC8
    lea     rdi, aWhat; jumptable 0000000000400E62 default case, case 0
    call    puts
    nop
loc_400EC3:
    jmp     loc_400E04
loc_400EC8:
    call    __stack_chk_fail
locret_400ECD:
    leave
    retn
main endp

