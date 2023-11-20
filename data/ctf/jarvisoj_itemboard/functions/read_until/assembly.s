read_until proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     [rbp+fd], edi
    mov     [rbp+buf], rsi
    mov     [rbp+len], edx
    mov     eax, ecx
    mov     [rbp+endchar], al
    mov     [rbp+i], 0
    jmp     short loc_A0F
loc_9C8:
    mov     eax, [rbp+i]
    movsxd  rdx, eax
    mov     rax, [rbp+buf]
    lea     rcx, [rdx+rax]
    mov     eax, [rbp+fd]
    mov     edx, 1; nbytes
    mov     rsi, rcx; buf
    mov     edi, eax; fd
    call    _read
    test    rax, rax
    jg      short loc_9F4
    mov     eax, 0FFFFFFFFh
    jmp     short locret_A2D
loc_9F4:
    mov     eax, [rbp+i]
    movsxd  rdx, eax
    mov     rax, [rbp+buf]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    cmp     al, [rbp+endchar]
    jnz     short loc_A0B
    jmp     short loc_A1A
loc_A0B:
    add     [rbp+i], 1
loc_A0F:
    mov     eax, [rbp+len]
    sub     eax, 1
    cmp     eax, [rbp+i]
    jg      short loc_9C8
loc_A1A:
    mov     eax, [rbp+i]
    movsxd  rdx, eax
    mov     rax, [rbp+buf]
    add     rax, rdx
    mov     byte ptr [rax], 0
    mov     eax, [rbp+i]
locret_A2D:
    leave
    retn
read_until endp

