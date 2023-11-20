main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     eax, 0
    call    Init
    lea     rdi, aDoYouWantToBeS; "Do you want to be superhero?"
    call    puts
loc_FC6:
    mov     eax, 0
    call    menu
    lea     rax, [rbp+buf]
    mov     edx, 10h; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    lea     rax, [rbp+buf]
    mov     rdi, rax; nptr
    call    atoi
    cmp     eax, 5; switch 6 cases
    ja      short def_1018; jumptable 0000000000001018 default case, case 0
    mov     eax, eax
    lea     rdx, ds:0[rax*4]
    lea     rax, jpt_1018
    mov     eax, ds:(jpt_1018 - 1268h)[rdx+rax]
    movsxd  rdx, eax
    lea     rax, jpt_1018
    add     rax, rdx
def_1018:
    jmp     rax; switch jump
    mov     eax, 0; jumptable 0000000000001018 case 1
    call    add
    jmp     short loc_106D
    mov     eax, 0; jumptable 0000000000001018 case 2
    call    show
    jmp     short loc_106D
    mov     eax, 0; jumptable 0000000000001018 case 3
    call    edit
    jmp     short loc_106D
    mov     eax, 0; jumptable 0000000000001018 case 4
    call    del
    jmp     short loc_106D
    lea     rdi, aByeBye; jumptable 0000000000001018 case 5
    call    puts
    mov     edi, 0; status
    call    exit
    lea     rdi, aInvalidChoice; jumptable 0000000000001018 default case, case 0
    call    puts
    nop
loc_106D:
    jmp     loc_FC6
main endp

