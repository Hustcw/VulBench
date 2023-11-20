myputs proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+str], rdi
    mov     [rbp+newline], esi
    mov     [rbp+len], 0
    nop
loc_AA1:
    mov     eax, [rbp+len]
    lea     edx, [rax+1]
    mov     [rbp+len], edx
    movsxd  rdx, eax
    mov     rax, [rbp+str]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    test    al, al
    jnz     short loc_AA1
    sub     [rbp+len], 1
    mov     eax, [rbp+len]
    movsxd  rdx, eax; n
    mov     rax, [rbp+str]
    mov     rsi, rax; buf
    mov     edi, 1; fd
    call    _write
    cmp     [rbp+newline], 0
    jz      short loc_AF2
    mov     edx, 1; n
    lea     rsi, unk_1348; buf
    mov     edi, 1; fd
    call    _write
loc_AF2:
    nop
    leave
    retn
myputs endp

