do_encrypt proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+ws], rdi
    mov     [rbp+i], 0
    mov     [rbp+j], 0
    mov     [rbp+k], 0
    jmp     loc_1C08
loc_1B10:
    add     [rbp+i], 1
    and     [rbp+i], 0FFh
    mov     rax, [rbp+ws]
    mov     rdx, [rax+18h]
    mov     eax, [rbp+i]
    cdqe
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    movsx   eax, al
    add     [rbp+j], eax
    and     [rbp+j], 0FFh
    mov     rax, [rbp+ws]
    mov     rdx, [rax+18h]
    mov     eax, [rbp+i]
    cdqe
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    movsx   eax, al
    mov     [rbp+tmp], eax
    mov     rax, [rbp+ws]
    mov     rdx, [rax+18h]
    mov     eax, [rbp+j]
    cdqe
    lea     rcx, [rdx+rax]
    mov     rax, [rbp+ws]
    mov     rdx, [rax+18h]
    mov     eax, [rbp+i]
    cdqe
    add     rdx, rax
    movzx   eax, byte ptr [rcx]
    mov     [rdx], al
    mov     rax, [rbp+ws]
    mov     rdx, [rax+18h]
    mov     eax, [rbp+j]
    cdqe
    add     rax, rdx
    mov     edx, [rbp+tmp]
    mov     [rax], dl
    mov     rax, [rbp+ws]
    mov     rdx, [rax+18h]
    mov     rax, [rbp+ws]
    mov     rcx, [rax+18h]
    mov     eax, [rbp+i]
    cdqe
    add     rax, rcx
    movzx   eax, byte ptr [rax]
    movsx   ecx, al
    mov     rax, [rbp+ws]
    mov     rsi, [rax+18h]
    mov     eax, [rbp+j]
    cdqe
    add     rax, rsi
    movzx   eax, byte ptr [rax]
    movsx   eax, al
    add     eax, ecx
    cdqe
    movzx   eax, al
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    movsx   eax, al
    mov     [rbp+tmp], eax
    mov     rax, [rbp+ws]
    mov     rdx, [rax+8]
    mov     eax, [rbp+k]
    cdqe
    add     rax, rdx
    movzx   ecx, byte ptr [rax]
    mov     eax, [rbp+tmp]
    mov     esi, eax
    mov     rax, [rbp+ws]
    mov     rdx, [rax+8]
    mov     eax, [rbp+k]
    cdqe
    add     rax, rdx
    xor     ecx, esi
    mov     edx, ecx
    mov     [rax], dl
    add     [rbp+k], 1
loc_1C08:
    mov     eax, [rbp+k]
    movsxd  rdx, eax
    mov     rax, [rbp+ws]
    mov     rax, [rax+10h]
    cmp     rdx, rax
    jb      loc_1B10
    lea     rdi, aBufferEncrypte; "Buffer encrypted!"
    call    _puts
    nop
    leave
    retn
do_encrypt endp

