magic proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    movzx   eax, cs:magic_times
    test    al, al
    jnz     short loc_10FC
    lea     rdi, aAddr; "addr: "
    call    _puts
    lea     rax, [rbp+addr]
    mov     rsi, rax
    lea     rdi, aLlu; "%llu"
    mov     eax, 0
    call    ___isoc99_scanf
    mov     rax, [rbp+addr]
    mov     qword ptr [rax], 2001h
    jmp     short loc_1108
loc_10FC:
    lea     rdi, aNoMagicAnyMore; "no magic any more!"
    call    _puts
loc_1108:
    lea     rdi, aSuccess; "success"
    call    _puts
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_1129
    call    ___stack_chk_fail
locret_1129:
    leave
    retn
magic endp

