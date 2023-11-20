main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     eax, 0
    call    init
loc_C21:
    mov     eax, 0
    call    menu
    mov     eax, 0
    call    get_int
    mov     [rbp+var_C], eax
    cmp     [rbp+var_C], 5; switch 6 cases
    ja      short def_C60; jumptable 0000000000000C60 default case, case 0
    mov     eax, [rbp+var_C]
    lea     rdx, ds:0[rax*4]
    lea     rax, jpt_C60
    mov     eax, ds:(jpt_C60 - 1478h)[rdx+rax]
    movsxd  rdx, eax
    lea     rax, jpt_C60
    add     rax, rdx
def_C60:
    jmp     rax; switch jump
    mov     eax, 0; jumptable 0000000000000C60 case 1
    call    add
    jmp     short loc_CB5
    mov     eax, 0; jumptable 0000000000000C60 case 2
    call    edit
    jmp     short loc_CB5
    mov     eax, 0; jumptable 0000000000000C60 case 3
    call    delete
    jmp     short loc_CB5
    mov     eax, 0; jumptable 0000000000000C60 case 4
    call    show
    jmp     short loc_CB5
    lea     rdi, s; jumptable 0000000000000C60 case 5
    call    puts
    mov     edi, 0; status
    call    exit
    lea     rdi, aInvalidChoice; jumptable 0000000000000C60 default case, case 0
    call    puts
    nop
loc_CB5:
    jmp     loc_C21
main endp

