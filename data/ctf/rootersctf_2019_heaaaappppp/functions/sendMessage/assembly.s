sendMessage proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 90h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, aEnterMessageTo; "Enter message to be sent: "
    call    _puts
    lea     rax, [rbp+buf]
    mov     edx, 7Fh; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    lea     rdi, aMessageRecieve; "Message recieved: "
    call    _puts
    lea     rax, [rbp+buf]
    mov     rdi, rax; s
    call    _puts
    lea     rdi, aSavingItForAdm; "\nSaving it for admin to see!\n"
    call    _puts
    lea     rax, [rbp+buf]
    mov     rdi, rax; s
    call    _strdup
    mov     cs:message, rax
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_13F1
    call    ___stack_chk_fail
locret_13F1:
    leave
    retn
sendMessage endp

