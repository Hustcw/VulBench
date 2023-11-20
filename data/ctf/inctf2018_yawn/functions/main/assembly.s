main proc
    push    rbp
    mov     rbp, rsp
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    mov     rax, cs:stdout_ptr
    mov     rax, [rax]
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    setvbuf
    lea     rdi, asc_4011F9; "---------------------------"
    call    puts
loc_401030:
    mov     eax, 0
    call    printmenu
    cmp     eax, 5; switch 6 cases
    ja      short def_401060; jumptable 0000000000401060 default case, case 0
    mov     eax, eax
    lea     rdx, ds:0[rax*4]
    lea     rax, jpt_401060
    mov     eax, ds:(jpt_401060 - 401220h)[rdx+rax]
    movsxd  rdx, eax
    lea     rax, jpt_401060
    add     rax, rdx
def_401060:
    jmp     rax; switch jump
    mov     eax, 0; jumptable 0000000000401060 case 1
    call    add_note
    jmp     short loc_4010A9
    mov     eax, 0; jumptable 0000000000401060 case 2
    call    edit_note
    jmp     short loc_4010A9
    mov     eax, 0; jumptable 0000000000401060 case 3
    call    remove_note
    jmp     short loc_4010A9
    mov     eax, 0; jumptable 0000000000401060 case 4
    call    view_note
    jmp     short loc_4010A9
    mov     edi, 0; jumptable 0000000000401060 case 5
    call    exit
    lea     rdi, aInvalid; jumptable 0000000000401060 default case, case 0
    call    puts
    nop
loc_4010A9:
    jmp     short loc_401030
main endp

