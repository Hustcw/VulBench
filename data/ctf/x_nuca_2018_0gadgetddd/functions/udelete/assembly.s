udelete proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     edx, 22h ; '"'; n
    mov     esi, offset aWhichNoteDoYou; "Which Note do you want to delete: "
    mov     edi, 1; fd
    call    _write
    mov     eax, 0
    call    input_choice
    mov     [rbp+var_4], eax
    cmp     [rbp+var_4], 0
    js      short loc_400E81
    cmp     [rbp+var_4], 0Fh
    jle     short loc_400E97
loc_400E81:
    mov     edx, 0Eh; n
    mov     esi, offset aOutOfBound; "Out of bound!\n"
    mov     edi, 1; fd
    call    _write
    jmp     short locret_400F01
loc_400E97:
    mov     eax, [rbp+var_4]
    movsxd  rdx, eax
    mov     rax, rdx
    shl     rax, 2
    add     rax, rdx
    shl     rax, 5
    add     rax, 6020E0h
    mov     eax, [rax]
    test    eax, eax
    jz      short loc_400EFC
    mov     eax, [rbp+var_4]
    movsxd  rdx, eax
    mov     rax, rdx
    shl     rax, 2
    add     rax, rdx
    shl     rax, 5
    add     rax, 602178h
    mov     rax, [rax]
    mov     rdi, rax; ptr
    call    _free
    mov     eax, [rbp+var_4]
    movsxd  rdx, eax
    mov     rax, rdx
    shl     rax, 2
    add     rax, rdx
    shl     rax, 5
    add     rax, 6020E0h
    mov     dword ptr [rax], 0
loc_400EFC:
    mov     eax, 0
locret_400F01:
    leave
    retn
udelete endp

