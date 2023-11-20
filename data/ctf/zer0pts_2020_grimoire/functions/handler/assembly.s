handler proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_14], edi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    cmp     [rbp+var_14], 0Eh
    jnz     short loc_13B0
    lea     rdi, aItSTimeToSayGo; "\nIt's time to say goodbye."
    call    _puts
    mov     edi, 1; status
    call    _exit
loc_13B0:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_13C5
    call    ___stack_chk_fail
locret_13C5:
    leave
    retn
handler endp

