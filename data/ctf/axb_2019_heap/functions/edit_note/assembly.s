edit_note proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, aEnterAnIndex; "Enter an index:"
    call    _puts
    lea     rax, [rbp+var_C]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    ___isoc99_scanf
    mov     eax, [rbp+var_C]
    cmp     eax, 0Ah
    jg      short loc_10F2
    mov     eax, [rbp+var_C]
    test    eax, eax
    js      short loc_10F2
    mov     edx, [rbp+var_C]
    lea     rax, note
    movsxd  rdx, edx
    shl     rdx, 4
    add     rax, rdx
    mov     rax, [rax]
    test    rax, rax
    jnz     short loc_1100
loc_10F2:
    lea     rdi, aYouCanTHackMe; "You can't hack me!"
    call    _puts
    jmp     short loc_1154
loc_1100:
    lea     rdi, aEnterTheConten; "Enter the content: "
    call    _puts
    mov     edx, [rbp+var_C]
    lea     rax, note
    movsxd  rdx, edx
    shl     rdx, 4
    add     rax, rdx
    add     rax, 8
    mov     edx, [rax]
    mov     ecx, [rbp+var_C]
    lea     rax, note
    movsxd  rcx, ecx
    shl     rcx, 4
    add     rax, rcx
    mov     rax, [rax]
    mov     esi, edx
    mov     rdi, rax
    call    get_input
    lea     rdi, aDone; "Done!"
    call    _puts
    nop
loc_1154:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_1168
    call    ___stack_chk_fail
locret_1168:
    leave
    retn
edit_note endp

