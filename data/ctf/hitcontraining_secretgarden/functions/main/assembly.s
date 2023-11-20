main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     eax, 0
    call    init
loc_400EA0:
    mov     eax, 0
    call    menu
    lea     rax, [rbp+buf]
    mov     edx, 8; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    lea     rax, [rbp+buf]
    mov     rdi, rax; nptr
    call    _atoi
    mov     [rbp+var_18], eax
    cmp     [rbp+var_18], 5; switch 6 cases
    ja      short def_400EF7; jumptable 0000000000400EF7 default case, case 0
    mov     eax, [rbp+var_18]
    lea     rdx, ds:0[rax*4]
    lea     rax, jpt_400EF7
    mov     eax, ds:(jpt_400EF7 - 401274h)[rdx+rax]
    movsxd  rdx, eax
    lea     rax, jpt_400EF7
    add     rax, rdx
def_400EF7:
    jmp     rax; switch jump
    mov     eax, 0; jumptable 0000000000400EF7 case 1
    call    add
    jmp     short loc_400F4C
    mov     eax, 0; jumptable 0000000000400EF7 case 2
    call    visit
    jmp     short loc_400F4C
    mov     eax, 0; jumptable 0000000000400EF7 case 3
    call    del
    jmp     short loc_400F4C
    mov     eax, 0; jumptable 0000000000400EF7 case 4
    call    clean
    jmp     short loc_400F4C
    lea     rdi, aSeeYouNextTime; jumptable 0000000000400EF7 case 5
    call    _puts
    mov     edi, 0; status
    call    _exit
    lea     rdi, aInvalidChoice; jumptable 0000000000400EF7 default case, case 0
    call    _puts
    nop
loc_400F4C:
    jmp     loc_400EA0
main endp

