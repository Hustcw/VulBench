ushow proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     edx, 20h ; ' '; n
    mov     esi, offset aWhichNoteDoYou_0; "Which Note do you want to show: "
    mov     edi, 1; fd
    call    _write
    mov     eax, 0
    call    input_choice
    mov     [rbp+var_8], eax
    cmp     [rbp+var_8], 0
    js      short loc_400F38
    cmp     [rbp+var_8], 0Fh
    jle     short loc_400F51
loc_400F38:
    mov     edx, 0Eh; n
    mov     esi, offset aOutOfBound; "Out of bound!\n"
    mov     edi, 1; fd
    call    _write
    jmp     locret_40105F
loc_400F51:
    mov     eax, [rbp+var_8]
    movsxd  rdx, eax
    mov     rax, rdx
    shl     rax, 2
    add     rax, rdx
    shl     rax, 5
    add     rax, 6020E0h
    mov     eax, [rax]
    test    eax, eax
    jz      loc_40105A
    mov     edx, 0Ch; n
    mov     esi, offset aNoteTitle; "note title: "
    mov     edi, 1; fd
    call    _write
    mov     eax, [rbp+var_8]
    movsxd  rdx, eax
    mov     rax, rdx
    shl     rax, 2
    add     rax, rdx
    shl     rax, 5
    add     rax, 6020E0h
    add     rax, 8
    mov     rdi, rax; s
    call    _strlen
    mov     [rbp+var_4], eax
    mov     eax, [rbp+var_4]
    movsxd  rcx, eax
    mov     eax, [rbp+var_8]
    movsxd  rdx, eax
    mov     rax, rdx
    shl     rax, 2
    add     rax, rdx
    shl     rax, 5
    add     rax, 6020E0h
    add     rax, 8
    mov     rdx, rcx; n
    mov     rsi, rax; buf
    mov     edi, 1; fd
    call    _write
    mov     edi, 0Ah; c
    call    _putchar
    mov     edx, 0Eh; n
    mov     esi, offset aNoteContent; "note content: "
    mov     edi, 1; fd
    call    _write
    mov     eax, [rbp+var_8]
    movsxd  rdx, eax
    mov     rax, rdx
    shl     rax, 2
    add     rax, rdx
    shl     rax, 5
    add     rax, 6020E4h
    mov     eax, [rax]
    movsxd  rcx, eax
    mov     eax, [rbp+var_8]
    movsxd  rdx, eax
    mov     rax, rdx
    shl     rax, 2
    add     rax, rdx
    shl     rax, 5
    add     rax, 602178h
    mov     rax, [rax]
    mov     rdx, rcx; n
    mov     rsi, rax; buf
    mov     edi, 1; fd
    call    _write
    mov     edi, 0Ah; c
    call    _putchar
loc_40105A:
    mov     eax, 0
locret_40105F:
    leave
    retn
ushow endp

