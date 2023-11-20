sub_D5D proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    lea     rdi, s; "Calculation Done!"
    call    _puts
loc_D71:
    lea     rdi, aI; "i > "
    mov     eax, 0
    call    _printf
    mov     eax, 0
    call    sub_B1A
    mov     [rbp+var_4], eax
    cmp     [rbp+var_4], 0
    js      short loc_DC4
    mov     rax, cs:qword_202068
    mov     edx, [rbp+var_4]
    movsxd  rdx, edx
    shl     rdx, 3
    add     rax, rdx
    mov     rdx, [rax]
    mov     eax, [rbp+var_4]
    mov     esi, eax
    lea     rdi, aXDLd; "x(%d) = %ld\n"
    mov     eax, 0
    call    _printf
    jmp     short loc_D71
loc_DC4:
    nop
    nop
    leave
    retn
sub_D5D endp

