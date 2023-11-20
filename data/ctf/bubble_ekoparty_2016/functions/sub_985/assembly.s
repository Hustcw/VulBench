sub_985 proc
    push    rbp
    mov     rbp, rsp
    mov     [rbp+var_28], rdi
    mov     [rbp+var_2C], esi
    mov     [rbp+var_30], edx
    mov     eax, [rbp+var_2C]
    cdqe
    lea     rdx, ds:0[rax*4]
    mov     rax, [rbp+var_28]
    add     rax, rdx
    mov     eax, [rax]
    mov     [rbp+var_10], eax
    mov     eax, [rbp+var_2C]
    mov     [rbp+var_C], eax
    mov     eax, [rbp+var_2C]
    lea     edx, [rax+1]
    mov     [rbp+var_2C], edx
    mov     [rbp+var_14], eax
    jmp     short loc_A3F
loc_9C0:
    mov     eax, [rbp+var_2C]
    lea     edx, [rax+1]
    mov     [rbp+var_2C], edx
    cdqe
    lea     rdx, ds:0[rax*4]
    mov     rax, [rbp+var_28]
    add     rax, rdx
    mov     eax, [rax]
    cmp     eax, [rbp+var_10]
    jnb     short loc_A3F
    add     [rbp+var_14], 1
    mov     eax, [rbp+var_14]
    lea     rdx, ds:0[rax*4]
    mov     rax, [rbp+var_28]
    add     rax, rdx
    mov     eax, [rax]
    mov     [rbp+var_8], eax
    mov     eax, [rbp+var_14]
    lea     rdx, ds:0[rax*4]
    mov     rax, [rbp+var_28]
    add     rdx, rax
    mov     eax, [rbp+var_2C]
    cdqe
    shl     rax, 2
    lea     rcx, [rax-4]
    mov     rax, [rbp+var_28]
    add     rax, rcx
    mov     eax, [rax]
    mov     [rdx], eax
    mov     eax, [rbp+var_2C]
    cdqe
    shl     rax, 2
    lea     rdx, [rax-4]
    mov     rax, [rbp+var_28]
    add     rdx, rax
    mov     eax, [rbp+var_8]
    mov     [rdx], eax
loc_A3F:
    mov     eax, [rbp+var_2C]
    cmp     eax, [rbp+var_30]
    jle     loc_9C0
    mov     eax, [rbp+var_14]
    lea     rdx, ds:0[rax*4]
    mov     rax, [rbp+var_28]
    add     rax, rdx
    mov     eax, [rax]
    mov     [rbp+var_4], eax
    mov     eax, [rbp+var_14]
    lea     rdx, ds:0[rax*4]
    mov     rax, [rbp+var_28]
    add     rdx, rax
    mov     eax, [rbp+var_10]
    mov     [rdx], eax
    mov     eax, [rbp+var_C]
    cdqe
    lea     rdx, ds:0[rax*4]
    mov     rax, [rbp+var_28]
    add     rdx, rax
    mov     eax, [rbp+var_4]
    mov     [rdx], eax
    mov     eax, [rbp+var_14]
    pop     rbp
    retn
sub_985 endp

