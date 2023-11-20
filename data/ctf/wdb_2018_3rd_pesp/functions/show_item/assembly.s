show_item proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     eax, cs:num
    test    eax, eax
    jnz     short loc_40095A
    mov     edi, offset aNoServantInThe; "No servant in the team"
    call    _puts
    jmp     short loc_4009B4
loc_40095A:
    mov     [rbp+var_4], 0
    jmp     short loc_4009A4
loc_400963:
    mov     eax, [rbp+var_4]
    cdqe
    shl     rax, 4
    add     rax, 6020C8h
    mov     rax, [rax]
    test    rax, rax
    jz      short loc_4009A0
    mov     eax, [rbp+var_4]
    cdqe
    shl     rax, 4
    add     rax, 6020C8h
    mov     rdx, [rax]
    mov     eax, [rbp+var_4]
    mov     esi, eax
    mov     edi, offset aDS; "%d : %s"
    mov     eax, 0
    call    _printf
loc_4009A0:
    add     [rbp+var_4], 1
loc_4009A4:
    cmp     [rbp+var_4], 63h ; 'c'
    jle     short loc_400963
    mov     edi, offset byte_4010AC; s
    call    _puts
loc_4009B4:
    nop
    leave
    retn
show_item endp

