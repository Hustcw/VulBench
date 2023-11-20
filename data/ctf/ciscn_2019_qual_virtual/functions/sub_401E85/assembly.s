sub_401E85 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_18], rdi
    mov     [rbp+var_1C], esi
    mov     eax, edx
    mov     [rbp+var_20], al
    mov     [rbp+var_8], 0
    jmp     short loc_401F02
loc_401EA2:
    mov     eax, [rbp+var_8]
    movsxd  rdx, eax
    mov     rax, [rbp+var_18]
    add     rax, rdx
    mov     edx, 1; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    mov     [rbp+var_4], eax
    cmp     [rbp+var_4], 1
    jz      short loc_401ED4
    mov     edi, 0FFFFFFFFh; status
    call    _exit
loc_401ED4:
    mov     eax, [rbp+var_8]
    movsxd  rdx, eax
    mov     rax, [rbp+var_18]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    cmp     [rbp+var_20], al
    jnz     short loc_401EFE
    mov     eax, [rbp+var_8]
    movsxd  rdx, eax
    mov     rax, [rbp+var_18]
    add     rax, rdx
    mov     byte ptr [rax], 0
    mov     eax, [rbp+var_8]
    jmp     short locret_401F23
loc_401EFE:
    add     [rbp+var_8], 1
loc_401F02:
    mov     eax, [rbp+var_8]
    cmp     eax, [rbp+var_1C]
    jl      short loc_401EA2
    mov     eax, [rbp+var_1C]
    cdqe
    lea     rdx, [rax-1]
    mov     rax, [rbp+var_18]
    add     rax, rdx
    mov     byte ptr [rax], 0
    mov     eax, [rbp+var_1C]
    sub     eax, 1
locret_401F23:
    leave
    retn
sub_401E85 endp

