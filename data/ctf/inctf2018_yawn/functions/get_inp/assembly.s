get_inp proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+buffer], rdi
    mov     [rbp+size], esi
    mov     eax, [rbp+size]
    movsxd  rdx, eax; nbytes
    mov     rax, [rbp+buffer]
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    mov     [rbp+retval], eax
    cmp     [rbp+retval], 0FFFFFFFFh
    jnz     short loc_4009AF
    mov     edi, 0; status
    call    exit
loc_4009AF:
    mov     eax, [rbp+retval]
    cdqe
    lea     rdx, [rax-1]
    mov     rax, [rbp+buffer]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    cmp     al, 0Ah
    jnz     short loc_4009D9
    mov     eax, [rbp+retval]
    cdqe
    lea     rdx, [rax-1]
    mov     rax, [rbp+buffer]
    add     rax, rdx
    mov     byte ptr [rax], 0
loc_4009D9:
    mov     eax, [rbp+retval]
    sub     eax, 1
    leave
    retn
get_inp endp

