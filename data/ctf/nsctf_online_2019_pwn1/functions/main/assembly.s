main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     [rbp+var_C], 0
    mov     eax, 0
    call    sub_A10
loc_EC9:
    mov     eax, 0
    call    sub_A7D
    lea     rax, [rbp+var_C]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    __isoc99_scanf
    mov     eax, [rbp+var_C]
    cmp     eax, 5; switch 6 cases
    ja      short def_F14; jumptable 0000000000000F14 default case, case 0
    mov     eax, eax
    lea     rdx, ds:0[rax*4]
    lea     rax, jpt_F14
    mov     eax, ds:(jpt_F14 - 1114h)[rdx+rax]
    movsxd  rdx, eax
    lea     rax, jpt_F14
    add     rax, rdx
def_F14:
    jmp     rax; switch jump
    mov     eax, 0; jumptable 0000000000000F14 case 1
    call    sub_AC0
    jmp     short loc_F69
    mov     eax, 0; jumptable 0000000000000F14 case 2
    call    sub_C1D
    jmp     short loc_F69
    mov     eax, 0; jumptable 0000000000000F14 case 3
    call    sub_D1B
    jmp     short loc_F69
    mov     eax, 0; jumptable 0000000000000F14 case 4
    call    sub_D2E
    jmp     short loc_F69
    mov     eax, 0; jumptable 0000000000000F14 case 5
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_F73
    jmp     short loc_F6E
    lea     rdi, aWrongChoice; jumptable 0000000000000F14 default case, case 0
    call    puts
    nop
loc_F69:
    jmp     loc_EC9
loc_F6E:
    call    __stack_chk_fail
locret_F73:
    leave
    retn
main endp

