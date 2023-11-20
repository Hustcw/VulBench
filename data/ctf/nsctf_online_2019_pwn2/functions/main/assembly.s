main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     eax, 0
    call    sub_A00
loc_CAD:
    mov     eax, 0
    call    sub_A9B
    lea     rax, [rbp+var_C]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    __isoc99_scanf
    mov     eax, [rbp+var_C]
    cmp     eax, 6; switch 7 cases
    ja      short def_CF8; jumptable 0000000000000CF8 default case, case 0
    mov     eax, eax
    lea     rdx, ds:0[rax*4]
    lea     rax, jpt_CF8
    mov     eax, ds:(jpt_CF8 - 0EC8h)[rdx+rax]
    movsxd  rdx, eax
    lea     rax, jpt_CF8
    add     rax, rdx
def_CF8:
    jmp     rax; switch jump
    mov     eax, 0; jumptable 0000000000000CF8 case 1
    call    sub_AEA
    jmp     short loc_D59
    mov     eax, 0; jumptable 0000000000000CF8 case 2
    call    sub_BB1
    jmp     short loc_D59
    mov     eax, 0; jumptable 0000000000000CF8 case 3
    call    sub_BF3
    jmp     short loc_D59
    mov     eax, 0; jumptable 0000000000000CF8 case 4
    call    sub_C60
    jmp     short loc_D59
    mov     eax, 0; jumptable 0000000000000CF8 case 5
    call    sub_C1B
    jmp     short loc_D59
    mov     eax, 0; jumptable 0000000000000CF8 case 6
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_D63
    jmp     short loc_D5E
    lea     rdi, aWrongChoice; jumptable 0000000000000CF8 default case, case 0
    call    puts
    nop
loc_D59:
    jmp     loc_CAD
loc_D5E:
    call    __stack_chk_fail
locret_D63:
    leave
    retn
main endp

