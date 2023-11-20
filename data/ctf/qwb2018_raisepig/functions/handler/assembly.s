handler proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_14], edi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    push    rax
    xor     eax, eax
    jz      short loc_1149
    add     rsp, 4
loc_1149:
    pop     rax
    lea     rdi, aTimeout; "timeout"
    call    puts
    mov     edi, 1; status
    call    exit
handler endp

