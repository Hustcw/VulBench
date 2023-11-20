add proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_14], edi
    mov     [rbp+var_18], esi
    mov     [rbp+var_1C], edx
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     eax, cs:w
    add     eax, 1
    mov     cs:w, eax
    mov     eax, cs:w
    cdqe
    lea     rcx, ds:0[rax*4]
    lea     rax, to
    mov     edx, [rbp+var_18]
    mov     [rcx+rax], edx
    mov     eax, cs:w
    cdqe
    lea     rcx, ds:0[rax*4]
    lea     rax, len
    mov     edx, [rbp+var_1C]
    mov     [rcx+rax], edx
    mov     ecx, cs:w
    mov     eax, [rbp+var_14]
    cdqe
    lea     rdx, ds:0[rax*4]
    lea     rax, head
    mov     edx, [rdx+rax]
    movsxd  rax, ecx
    lea     rcx, ds:0[rax*4]
    lea     rax, next
    mov     [rcx+rax], edx
    mov     edx, cs:w
    mov     eax, [rbp+var_14]
    cdqe
    lea     rcx, ds:0[rax*4]
    lea     rax, head
    mov     [rcx+rax], edx
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_9C7
    call    ___stack_chk_fail
locret_9C7:
    leave
    retn
add endp

