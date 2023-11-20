sub_C37 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+s1], rdi
    mov     [rbp+var_4], 0
    jmp     short loc_C9D
loc_C4C:
    mov     eax, [rbp+var_4]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, unk_202080
    mov     rax, [rdx+rax]
    test    rax, rax
    jz      short loc_C99
    mov     eax, [rbp+var_4]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, unk_202080
    mov     rdx, [rdx+rax]
    mov     rax, [rbp+s1]
    mov     rsi, rdx; s2
    mov     rdi, rax; s1
    call    _strcmp
    test    eax, eax
    jnz     short loc_C99
    mov     eax, [rbp+var_4]
    jmp     short locret_CA8
loc_C99:
    add     [rbp+var_4], 1
loc_C9D:
    cmp     [rbp+var_4], 1Fh
    jle     short loc_C4C
    mov     eax, 0FFFFFFFFh
locret_CA8:
    leave
    retn
sub_C37 endp

