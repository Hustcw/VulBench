main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     edi, 0A0h; size
    call    _malloc
    mov     rdx, rax
    lea     rax, item_array
    mov     [rax], rdx
    mov     eax, 0
    call    welcome
loc_F63:
    mov     eax, 0
    call    print_menu
    mov     eax, 0
    call    read_num
    mov     [rbp+choice], eax
    cmp     [rbp+choice], 0FFFFFFFFh
    jnz     short loc_F8B
    nop
    mov     eax, 0
    jmp     locret_1014
loc_F8B:
    cmp     [rbp+choice], 5; switch 6 cases
    ja      short def_FB3; jumptable 0000000000000FB3 default case, case 0
    mov     eax, [rbp+choice]
    lea     rdx, ds:0[rax*4]
    lea     rax, jpt_FB3
    mov     eax, ds:(jpt_FB3 - 1214h)[rdx+rax]
    movsxd  rdx, eax
    lea     rax, jpt_FB3
    add     rax, rdx
def_FB3:
    jmp     rax; switch jump
    mov     eax, 0; jumptable 0000000000000FB3 case 1
    call    new_item
    jmp     short loc_100F
    mov     eax, 0; jumptable 0000000000000FB3 case 2
    call    list_item
    jmp     short loc_100F
    mov     eax, 0; jumptable 0000000000000FB3 case 3
    call    show_item
    jmp     short loc_100F
    mov     eax, 0; jumptable 0000000000000FB3 case 4
    call    remove_item
    jmp     short loc_100F
    mov     eax, 0; jumptable 0000000000000FB3 case 5
    jmp     short locret_1014
    lea     rdi, aInvalidChoice; jumptable 0000000000000FB3 default case, case 0
    call    _puts
    mov     rax, cs:stdout_ptr
    mov     rax, [rax]
    mov     rdi, rax; stream
    call    _fflush
    jmp     loc_F63
loc_100F:
    jmp     loc_F63
locret_1014:
    leave
    retn
main endp

