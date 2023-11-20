dele proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    lea     rdi, aWeapon; "weapon:"
    call    puts_flush
    mov     eax, 0
    call    read_atoi
    mov     [rbp+var_4], eax
    cmp     [rbp+var_4], 0
    js      short loc_1279
    cmp     [rbp+var_4], 8
    jg      short loc_1279
    mov     eax, [rbp+var_4]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, weapon_list
    mov     rax, [rdx+rax]
    test    rax, rax
    jz      short loc_1279
    mov     eax, [rbp+var_4]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, weapon_list
    mov     rax, [rdx+rax]
    mov     rdi, rax; ptr
    call    _free
    nop
loc_1279:
    nop
    leave
    retn
dele endp

