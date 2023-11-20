main proc
    push    rbp
    mov     rbp, rsp
    mov     eax, 0
    call    init
loc_1031:
    mov     eax, 0
    call    menu
    mov     eax, 0
    call    read_int
    cmp     eax, 5; switch 6 cases
    ja      short def_106B; jumptable 000000000000106B default case, case 0
    mov     eax, eax
    lea     rdx, ds:0[rax*4]
    lea     rax, jpt_106B
    mov     eax, ds:(jpt_106B - 1290h)[rdx+rax]
    movsxd  rdx, eax
    lea     rax, jpt_106B
    add     rax, rdx
def_106B:
    jmp     rax; switch jump
    mov     eax, 0; jumptable 000000000000106B case 1
    call    Create
    jmp     short loc_10B3
    mov     eax, 0; jumptable 000000000000106B case 2
    call    Edit
    jmp     short loc_10B3
    mov     eax, 0; jumptable 000000000000106B case 3
    call    Show
    jmp     short loc_10B3
    mov     eax, 0; jumptable 000000000000106B case 4
    call    Delete
    jmp     short loc_10B3
    mov     edi, 0; jumptable 000000000000106B case 5
    call    _exit
    lea     rdi, aInvalidChoice; jumptable 000000000000106B default case, case 0
    call    _puts
loc_10B3:
    jmp     loc_1031
main endp

