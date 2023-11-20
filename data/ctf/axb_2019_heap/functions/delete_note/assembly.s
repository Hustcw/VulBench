delete_note proc
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
    jg      short loc_FEE
    mov     eax, [rbp+var_C]
    test    eax, eax
    js      short loc_FEE
    mov     edx, [rbp+var_C]
    lea     rax, note
    movsxd  rdx, edx
    shl     rdx, 4
    add     rax, rdx
    mov     rax, [rax]
    test    rax, rax
    jnz     short loc_FFC
loc_FEE:
    lea     rdi, aYouCanTHackMe; "You can't hack me!"
    call    _puts
    jmp     short loc_1076
loc_FFC:
    mov     edx, [rbp+var_C]
    lea     rax, note
    movsxd  rdx, edx
    shl     rdx, 4
    add     rax, rdx
    mov     rax, [rax]
    mov     rdi, rax; ptr
    call    _free
    mov     edx, [rbp+var_C]
    lea     rax, note
    movsxd  rdx, edx
    shl     rdx, 4
    add     rax, rdx
    mov     qword ptr [rax], 0
    mov     edx, [rbp+var_C]
    lea     rax, note
    movsxd  rdx, edx
    shl     rdx, 4
    add     rax, rdx
    add     rax, 8
    mov     dword ptr [rax], 0
    lea     rax, counts
    mov     eax, [rax]
    lea     edx, [rax-1]
    lea     rax, counts
    mov     [rax], edx
    lea     rdi, aDone; "Done!"
    call    _puts
    nop
loc_1076:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_108A
    call    ___stack_chk_fail
locret_108A:
    leave
    retn
delete_note endp

