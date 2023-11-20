sub_ACC proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+buf], rdi
    mov     [rbp+var_1C], esi
    mov     eax, [rbp+var_1C]
    movsxd  rdx, eax; nbytes
    mov     rax, [rbp+buf]
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    mov     [rbp+var_4], eax
    cmp     [rbp+var_4], 0
    jg      short loc_B07
    lea     rdi, aBrokenPipe; "Broken pipe"
    call    sub_A97
loc_B07:
    mov     eax, [rbp+var_4]
    movsxd  rdx, eax
    mov     rax, [rbp+buf]
    add     rax, rdx
    mov     byte ptr [rax], 0
    nop
    leave
    retn
sub_ACC endp

