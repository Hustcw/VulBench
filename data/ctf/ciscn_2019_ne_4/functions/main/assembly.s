main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     eax, 0
    call    sub_AD0
loc_1223:
    mov     eax, 0
    call    sub_B5A
    mov     eax, [rbp+var_C]
    mov     edi, eax
    call    sub_BE0
    mov     [rbp+var_C], eax
    cmp     [rbp+var_C], 5; switch 6 cases
    ja      def_1266; jumptable 0000000000001266 default case, case 0
    mov     eax, [rbp+var_C]
    lea     rdx, ds:0[rax*4]
    lea     rax, jpt_1266
    mov     eax, ds:(jpt_1266 - 1508h)[rdx+rax]
    movsxd  rdx, eax
    lea     rax, jpt_1266
    add     rax, rdx
def_1266:
    jmp     rax; switch jump
    lea     rdi, aHaveAGoodDay; jumptable 0000000000001266 case 1
    call    puts
    mov     eax, 0
    call    sub_C46
    jmp     short loc_12F7
    lea     rdi, aHereSAGreatThi; jumptable 0000000000001266 case 2
    call    puts
    mov     eax, 0
    call    sub_E98
    jmp     short loc_12F7
    lea     rdi, aAreYouSure; jumptable 0000000000001266 case 3
    call    puts
    mov     eax, 0
    call    sub_FA4
    jmp     short loc_12F7
    lea     rdi, aIsThereAnythin; jumptable 0000000000001266 case 4
    call    puts
    mov     eax, 0
    call    sub_1138
    jmp     short loc_12F7
    lea     rdi, aSeeYou; jumptable 0000000000001266 case 5
    call    puts
    mov     eax, 0
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_1301
    jmp     short loc_12FC
    lea     rdi, aWrongChoicePle; jumptable 0000000000001266 default case, case 0
    call    puts
    nop
loc_12F7:
    jmp     loc_1223
loc_12FC:
    call    __stack_chk_fail
locret_1301:
    leave
    retn
main endp

