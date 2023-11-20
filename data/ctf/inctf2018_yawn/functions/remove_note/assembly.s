remove_note proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    lea     rdi, aEnterIdx; "Enter idx: "
    mov     eax, 0
    call    printf
    mov     eax, 0
    call    get_int
    mov     [rbp+idx], eax
    cmp     [rbp+idx], 0
    js      short loc_400E98
    cmp     [rbp+idx], 9
    jg      short loc_400E98
    lea     rax, table
    mov     edx, [rbp+idx]
    movsxd  rdx, edx
    mov     rax, [rax+rdx*8]
    test    rax, rax
    jnz     short loc_400E9F
loc_400E98:
    mov     eax, 0
    jmp     short locret_400F08
loc_400E9F:
    lea     rax, table
    mov     edx, [rbp+idx]
    movsxd  rdx, edx
    mov     rax, [rax+rdx*8]
    mov     rax, [rax+58h]
    mov     rdi, rax; ptr
    call    free
    lea     rax, table
    mov     edx, [rbp+idx]
    movsxd  rdx, edx
    mov     rax, [rax+rdx*8]
    mov     qword ptr [rax+58h], 0
    lea     rax, table
    mov     edx, [rbp+idx]
    movsxd  rdx, edx
    mov     rax, [rax+rdx*8]
    mov     rdi, rax; ptr
    call    free
    lea     rax, table
    mov     edx, [rbp+idx]
    movsxd  rdx, edx
    mov     qword ptr [rax+rdx*8], 0
    mov     eax, 0
locret_400F08:
    leave
    retn
remove_note endp

