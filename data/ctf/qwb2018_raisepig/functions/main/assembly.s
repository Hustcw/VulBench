main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    push    rax
    xor     eax, eax
    jz      short loc_1214
    add     rsp, 4
loc_1214:
    pop     rax
    mov     eax, 0
    call    sub_1160
loc_121F:
    mov     eax, 0
    call    sub_B90
    lea     rax, [rbp+buf]
    mov     edx, 8; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    lea     rax, [rbp+buf]
    mov     rdi, rax; nptr
    call    atoi
    mov     [rbp+var_24], eax
    cmp     [rbp+var_24], 5; switch 6 cases
    ja      short def_1276; jumptable 0000000000001276 default case, case 0
    mov     eax, [rbp+var_24]
    lea     rdx, ds:0[rax*4]
    lea     rax, jpt_1276
    mov     eax, ds:(jpt_1276 - 1568h)[rdx+rax]
    movsxd  rdx, eax
    lea     rax, jpt_1276
    add     rax, rdx
def_1276:
    jmp     rax; switch jump
    mov     eax, 0; jumptable 0000000000001276 case 1
    call    sub_C8F
    jmp     short loc_12CB
    mov     eax, 0; jumptable 0000000000001276 case 2
    call    sub_101E
    jmp     short loc_12CB
    mov     eax, 0; jumptable 0000000000001276 case 3
    call    sub_E3E
    jmp     short loc_12CB
    mov     eax, 0; jumptable 0000000000001276 case 4
    call    sub_F42
    jmp     short loc_12CB
    lea     rdi, aSeeYouNextTime; jumptable 0000000000001276 case 5
    call    puts
    mov     edi, 0; status
    call    exit
    lea     rdi, aInvalidChoice; jumptable 0000000000001276 default case, case 0
    call    puts
    nop
loc_12CB:
    jmp     loc_121F
main endp

