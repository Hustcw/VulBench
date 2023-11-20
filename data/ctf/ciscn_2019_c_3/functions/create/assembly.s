create proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_18], 0
    jmp     loc_F75
loc_E5F:
    mov     eax, [rbp+var_18]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, weapon_list
    mov     rax, [rdx+rax]
    test    rax, rax
    jnz     loc_F71
    lea     rdi, aSize; "size: "
    call    puts_flush
    mov     eax, 0
    call    read_atoi
    mov     [rbp+var_14], eax
    cmp     [rbp+var_14], 60h ; '`'
    jz      short loc_EB2
    cmp     [rbp+var_14], 100h
    jz      short loc_EB2
    cmp     [rbp+var_14], 4Fh ; 'O'
    jnz     loc_F63
loc_EB2:
    mov     eax, [rbp+var_14]
    cdqe
    mov     rdi, rax; size
    call    _malloc
    mov     [rbp+var_10], rax
    mov     rax, [rbp+var_10]
    mov     qword ptr [rax], 0
    mov     edi, 0; timer
    call    _time
    mov     rcx, rax
    mov     rdx, 6666666666666667h
    mov     rax, rcx
    imul    rdx
    sar     rdx, 2
    mov     rax, rcx
    sar     rax, 3Fh
    sub     rdx, rax
    mov     rax, rdx
    shl     rax, 2
    add     rax, rdx
    add     rax, rax
    sub     rcx, rax
    mov     rdx, rcx
    lea     rax, [rdx+60h]
    mov     [rbp+var_8], rax
    mov     rax, [rbp+var_10]
    lea     rdx, [rax+8]
    mov     rax, [rbp+var_8]
    mov     [rdx], rax
    lea     rdi, aGiveMeTheName; "Give me the name: "
    call    puts_flush
    mov     eax, [rbp+var_14]
    mov     rdx, [rbp+var_10]
    add     rdx, 10h
    mov     esi, eax
    mov     rdi, rdx
    call    read_context
    mov     eax, [rbp+var_18]
    cdqe
    lea     rcx, ds:0[rax*8]
    lea     rax, weapon_list
    mov     rdx, [rbp+var_10]
    mov     [rcx+rax], rdx
    nop
    jmp     short locret_F7F
loc_F63:
    lea     rdi, aYouCanOnlyCrea; "you can only create three kinds of weap"...
    call    puts_flush
    jmp     short locret_F7F
loc_F71:
    add     [rbp+var_18], 1
loc_F75:
    cmp     [rbp+var_18], 8
    jle     loc_E5F
locret_F7F:
    leave
    retn
create endp

