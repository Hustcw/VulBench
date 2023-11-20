handle proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_14], edi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
loc_196E:
    mov     eax, [rbp+var_14]
    lea     rsi, aWelcomeToBabyS; "Welcome to baby's first pwn.\nPick your"...
    mov     edi, eax
    call    sendstr
    lea     rcx, [rbp+var_10]
    mov     eax, [rbp+var_14]
    mov     edx, 2
    mov     rsi, rcx
    mov     edi, eax
    call    recvlen
    movzx   eax, [rbp+var_10]
    movsx   eax, al
    cmp     eax, 32h ; '2'
    jz      short loc_19C5
    cmp     eax, 32h ; '2'
    jg      short loc_19AD
    cmp     eax, 31h ; '1'
    jz      short loc_19B9
    jmp     short loc_19F3
loc_19AD:
    cmp     eax, 33h ; '3'
    jz      short loc_19D1
    cmp     eax, 34h ; '4'
    jz      short loc_19DD
    jmp     short loc_19F3
loc_19B9:
    mov     eax, [rbp+var_14]
    mov     edi, eax
    call    dostack
    jmp     short loc_19F3
loc_19C5:
    mov     eax, [rbp+var_14]
    mov     edi, eax
    call    dofmt
    jmp     short loc_19F3
loc_19D1:
    mov     eax, [rbp+var_14]
    mov     edi, eax
    call    doheap
    jmp     short loc_19F3
loc_19DD:
    mov     eax, 0
    mov     rdx, [rbp+var_8]
    xor     rdx, fs:28h
    jz      short locret_19FD
    jmp     short loc_19F8
loc_19F3:
    jmp     loc_196E
loc_19F8:
    call    ___stack_chk_fail
locret_19FD:
    leave
    retn
handle endp

