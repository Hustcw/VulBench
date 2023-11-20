sub_A97 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_18], rdi
    mov     [rbp+var_1C], esi
    mov     [rbp+var_20], edx
    mov     edx, [rbp+var_20]
    mov     ecx, [rbp+var_1C]
    mov     rax, [rbp+var_18]
    mov     esi, ecx
    mov     rdi, rax
    call    sub_985
    mov     [rbp+var_4], eax
    mov     eax, [rbp+var_1C]
    cmp     eax, [rbp+var_20]
    jge     short loc_AF6
    mov     eax, [rbp+var_4]
    lea     edx, [rax-1]
    mov     ecx, [rbp+var_1C]
    mov     rax, [rbp+var_18]
    mov     esi, ecx
    mov     rdi, rax
    call    sub_A97
    mov     eax, [rbp+var_4]
    lea     ecx, [rax+1]
    mov     edx, [rbp+var_20]
    mov     rax, [rbp+var_18]
    mov     esi, ecx
    mov     rdi, rax
    call    sub_A97
loc_AF6:
    nop
    leave
    retn
sub_A97 endp

