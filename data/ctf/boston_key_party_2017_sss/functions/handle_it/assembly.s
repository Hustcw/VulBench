handle_it proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     edi, offset a1SignCommand2E; "1) sign command\n2) execute command\n>_"...
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+buf]
    mov     edx, 4; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    movzx   eax, [rbp+buf]
    movsx   eax, al
    cmp     eax, 31h ; '1'
    jz      short loc_401408
    cmp     eax, 32h ; '2'
    jz      short loc_401419
    jmp     short loc_40142A
loc_401408:
    mov     eax, 0
    call    sign_it
    mov     eax, 0
    jmp     short loc_401439
loc_401419:
    mov     eax, 0
    call    execute_it
    mov     eax, 0
    jmp     short loc_401439
loc_40142A:
    mov     edi, offset aNop; "NOP"
    call    _puts
    mov     eax, 1
loc_401439:
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_40144D
    call    ___stack_chk_fail
locret_40144D:
    leave
    retn
handle_it endp

