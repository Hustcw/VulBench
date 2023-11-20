getContent proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+buf], rdi
    mov     [rbp+size], esi
    mov     [rbp+i], 0
    jmp     short loc_CD5
loc_C83:
    mov     eax, [rbp+i]
    movsxd  rdx, eax
    mov     rax, [rbp+buf]
    add     rax, rdx
    mov     edx, 1; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    mov     [rbp+ret], eax
    cmp     [rbp+ret], 0FFFFFFFFh
    jnz     short loc_CB5
    mov     edi, 0; status
    call    _exit
loc_CB5:
    mov     eax, [rbp+i]
    movsxd  rdx, eax
    mov     rax, [rbp+buf]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    cmp     al, 0Ah
    jnz     short loc_CD1
    mov     eax, [rbp+i]
    add     eax, 1
    jmp     short locret_CE0
loc_CD1:
    add     [rbp+i], 1
loc_CD5:
    mov     eax, [rbp+i]
    cmp     eax, [rbp+size]
    jl      short loc_C83
    mov     eax, [rbp+i]
locret_CE0:
    leave
    retn
getContent endp

