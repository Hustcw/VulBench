sub_4019A4 proc
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 38h
    mov     [rbp+var_38], rdi
    mov     rax, fs:28h
    mov     [rbp+var_18], rax
    xor     eax, eax
    mov     edi, offset aBossAttack; "\n====================================="...
    call    _puts
    mov     edi, offset aBossIsAttackin; "Boss is Attacking you!"
    call    _puts
    mov     rax, [rbp+var_38]
    mov     rdi, rax
    call    sub_401476
    mov     edi, offset aChoice; "choice:"
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+var_24]
    mov     rsi, rax
    mov     edi, offset aD; "%d"
    mov     eax, 0
    call    _scanf
    mov     eax, [rbp+var_24]
    cmp     eax, 2
    jz      short loc_401A21
    cmp     eax, 3
    jz      short loc_401A2B
    cmp     eax, 1
    jnz     short loc_401A34
    mov     rax, [rbp+var_38]
    mov     byte ptr [rax+0Ch], 1
    jmp     short loc_401A34
loc_401A21:
    mov     rax, [rbp+var_38]
    mov     byte ptr [rax+0Dh], 1
    jmp     short loc_401A34
loc_401A2B:
    mov     rax, [rbp+var_38]
    mov     byte ptr [rax+0Eh], 1
    nop
loc_401A34:
    call    _rand
    mov     [rbp+var_20], eax
    mov     eax, [rbp+var_20]
    cdq
    shr     edx, 1Eh
    add     eax, edx
    and     eax, 3
    sub     eax, edx
    mov     [rbp+var_1C], eax
    mov     eax, [rbp+var_1C]
    cmp     eax, 1
    jz      short loc_401AA7
    cmp     eax, 2
    jz      loc_401AE5
    test    eax, eax
    jnz     loc_401B22
    mov     rax, [rbp+var_38]
    movzx   eax, byte ptr [rax+0Ch]
    test    al, al
    jz      short loc_401A81
    mov     edi, offset aYouSucceedInDe; "You succeed in defense"
    call    _puts
    jmp     loc_401B22
loc_401A81:
    mov     rax, [rbp+var_38]
    mov     rbx, [rax]
    mov     rax, [rbp+var_38]
    add     rax, 10h
    mov     rdi, rax
    call    sub_4013D2
    sub     rbx, rax
    mov     rdx, rbx
    mov     rax, [rbp+var_38]
    mov     [rax], rdx
    jmp     short loc_401B22
loc_401AA7:
    mov     rax, [rbp+var_38]
    movzx   eax, byte ptr [rax+0Eh]
    test    al, al
    jz      short loc_401ABF
    mov     edi, offset aYouSucceedInDe; "You succeed in defense"
    call    _puts
    jmp     short loc_401B22
loc_401ABF:
    mov     rax, [rbp+var_38]
    mov     rbx, [rax]
    mov     rax, [rbp+var_38]
    add     rax, 10h
    mov     rdi, rax
    call    sub_4013E2
    sub     rbx, rax
    mov     rdx, rbx
    mov     rax, [rbp+var_38]
    mov     [rax], rdx
    jmp     short loc_401B22
loc_401AE5:
    mov     rax, [rbp+var_38]
    movzx   eax, byte ptr [rax+0Dh]
    test    al, al
    jz      short loc_401AFD
    mov     edi, offset aYouSucceedInDe; "You succeed in defense"
    call    _puts
    jmp     short loc_401B21
loc_401AFD:
    mov     rax, [rbp+var_38]
    mov     rbx, [rax]
    mov     rax, [rbp+var_38]
    add     rax, 10h
    mov     rdi, rax
    call    sub_4013F2
    mov     rdx, rbx
    sub     rdx, rax
    mov     rax, [rbp+var_38]
    mov     [rax], rdx
loc_401B21:
    nop
loc_401B22:
    mov     rax, [rbp+var_38]
    mov     rdi, rax
    call    sub_40137C
    mov     rax, [rbp+var_38]
    mov     rdi, rax
    call    sub_40132E
    mov     edi, offset asc_402290; "======================================="...
    call    _puts
    nop
    mov     rax, [rbp+var_18]
    xor     rax, fs:28h
    jz      short loc_401B59
    call    ___stack_chk_fail
loc_401B59:
    add     rsp, 38h
    pop     rbx
    pop     rbp
    retn
sub_4019A4 endp

