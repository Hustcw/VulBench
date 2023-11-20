remove_item proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     eax, cs:num
    test    eax, eax
    jnz     short loc_400C7D
    mov     edi, offset aNoServantInThe; "No servant in the team"
    call    _puts
    jmp     loc_400D32
loc_400C7D:
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
    mov     [rbp+var_14], eax
    mov     eax, [rbp+var_14]
    cdqe
    shl     rax, 4
    add     rax, 6020C8h
    mov     rax, [rax]
    test    rax, rax
    jz      short loc_400D28
    mov     eax, [rbp+var_14]
    cdqe
    shl     rax, 4
    add     rax, 6020C8h
    mov     rax, [rax]
    mov     rdi, rax; ptr
    call    _free
    mov     eax, [rbp+var_14]
    cdqe
    shl     rax, 4
    add     rax, 6020C8h
    mov     qword ptr [rax], 0
    mov     eax, [rbp+var_14]
    cdqe
    shl     rax, 4
    add     rax, 6020C0h
    mov     dword ptr [rax], 0
    mov     edi, offset aRemoveSuccessf; "remove successful!!"
    call    _puts
    mov     eax, cs:num
    sub     eax, 1
    mov     cs:num, eax
    jmp     short loc_400D32
loc_400D28:
    mov     edi, offset aInvaildIndex; "invaild index"
    call    _puts
loc_400D32:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_400D47
    call    ___stack_chk_fail
locret_400D47:
    leave
    retn
remove_item endp

