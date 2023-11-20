secure_read proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+nbytes+4], rdi
    mov     dword ptr [rbp+nbytes], esi
    mov     edx, dword ptr [rbp+nbytes]; nbytes
    mov     rax, [rbp+nbytes+4]
    mov     rsi, rax; buf
    mov     edi, 0; fd
    mov     eax, 0
    call    _read
    mov     [rbp+var_4], eax
    cmp     [rbp+var_4], 0
    jns     short loc_A81
    lea     rdi, s; "Do you want a flag?"
    call    _puts
    mov     edi, 0; status
    call    _exit
loc_A81:
    mov     eax, [rbp+var_4]
    cdqe
    lea     rdx, [rax-1]
    mov     rax, [rbp+nbytes+4]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    cmp     al, 0Ah
    jnz     short loc_AAB
    mov     eax, [rbp+var_4]
    cdqe
    lea     rdx, [rax-1]
    mov     rax, [rbp+nbytes+4]
    add     rax, rdx
    mov     byte ptr [rax], 0
loc_AAB:
    mov     eax, [rbp+var_4]
    leave
    retn
secure_read endp

