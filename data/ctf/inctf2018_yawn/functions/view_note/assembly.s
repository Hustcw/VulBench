view_note proc
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
    js      short loc_400F52
    cmp     [rbp+idx], 9
    jg      short loc_400F52
    lea     rax, table
    mov     edx, [rbp+idx]
    movsxd  rdx, edx
    mov     rax, [rax+rdx*8]
    test    rax, rax
    jnz     short loc_400F59
loc_400F52:
    mov     eax, 0
    jmp     short locret_400FC6
loc_400F59:
    lea     rax, table
    mov     edx, [rbp+idx]
    movsxd  rdx, edx
    mov     rax, [rax+rdx*8]
    mov     rdx, rax
    mov     eax, [rbp+idx]
    mov     esi, eax
    lea     rdi, aNoteIdDNameS; "Note ID : %d\nName : %s\n"
    mov     eax, 0
    call    printf
    lea     rax, table
    mov     edx, [rbp+idx]
    movsxd  rdx, edx
    mov     rax, [rax+rdx*8]
    mov     rdx, [rax+58h]
    lea     rax, table
    mov     ecx, [rbp+idx]
    movsxd  rcx, ecx
    mov     rax, [rax+rcx*8]
    mov     rax, [rax+50h]
    mov     rsi, rax
    lea     rdi, aSizeLldDescrip; "Size : %lld\nDescription : %s\n"
    mov     eax, 0
    call    printf
    mov     eax, 0
locret_400FC6:
    leave
    retn
view_note endp

