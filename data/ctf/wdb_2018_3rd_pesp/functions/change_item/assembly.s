change_item proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     eax, cs:num
    test    eax, eax
    jnz     short loc_400B53
    mov     edi, offset aNoServantInThe; "No servant in the team"
    call    _puts
    jmp     loc_400C36
loc_400B53:
    mov     edi, offset aPleaseEnterThe_1; "Please enter the index of servant:"
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+buf]
    mov     edx, 8; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    lea     rax, [rbp+buf]
    mov     rdi, rax; nptr
    call    _atoi
    mov     [rbp+var_2C], eax
    mov     eax, [rbp+var_2C]
    cdqe
    shl     rax, 4
    add     rax, 6020C8h
    mov     rax, [rax]
    test    rax, rax
    jz      loc_400C2C
    mov     edi, offset aPleaseEnterThe; "Please enter the length of servant name"...
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+nptr]
    mov     edx, 8; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    lea     rax, [rbp+nptr]
    mov     rdi, rax; nptr
    call    _atoi
    mov     [rbp+var_28], eax
    mov     edi, offset aPleaseEnterThe_2; "Please enter the new name of the servna"...
    mov     eax, 0
    call    _printf
    mov     eax, [rbp+var_28]
    movsxd  rdx, eax; nbytes
    mov     eax, [rbp+var_2C]
    cdqe
    shl     rax, 4
    add     rax, 6020C8h
    mov     rax, [rax]
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    mov     [rbp+var_24], eax
    mov     eax, [rbp+var_2C]
    cdqe
    shl     rax, 4
    add     rax, 6020C8h
    mov     rdx, [rax]
    mov     eax, [rbp+var_24]
    cdqe
    add     rax, rdx
    mov     byte ptr [rax], 0
    jmp     short loc_400C36
loc_400C2C:
    mov     edi, offset aInvaildIndex; "invaild index"
    call    _puts
loc_400C36:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_400C4B
    call    ___stack_chk_fail
locret_400C4B:
    leave
    retn
change_item endp

