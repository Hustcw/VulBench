sub_400F09 proc
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 28h
    mov     rax, fs:28h
    mov     [rbp+var_18], rax
    xor     eax, eax
    mov     edi, offset aPleaseEnterThe_1; "Please enter the index: "
    call    sub_400C52
    mov     eax, 0
    call    sub_400C90
    mov     [rbp+var_24], eax
    cmp     [rbp+var_24], 0
    js      short loc_400FAF
    cmp     [rbp+var_24], 0Fh
    jg      short loc_400FAF
    mov     eax, [rbp+var_24]
    cdqe
    mov     rax, ds:ptr[rax*8]
    test    rax, rax
    jz      short loc_400FAF
    mov     eax, [rbp+var_24]
    cdqe
    mov     rax, ds:ptr[rax*8]
    mov     rdx, [rax]
    add     rdx, 1
    mov     [rax], rdx
    mov     eax, [rbp+var_24]
    cdqe
    mov     rax, ds:ptr[rax*8]
    lea     rbx, [rax+8]
    mov     edi, 0; timer
    call    _time
    mov     [rbx], rax
    mov     eax, [rbp+var_24]
    mov     cs:dword_602160, eax
    lea     rax, [rbp+newthread]
    mov     ecx, 0; arg
    mov     edx, offset start_routine; start_routine
    mov     esi, 0; attr
    mov     rdi, rax; newthread
    call    _pthread_create
loc_400FAF:
    nop
    mov     rax, [rbp+var_18]
    xor     rax, fs:28h
    jz      short loc_400FC4
    call    ___stack_chk_fail
loc_400FC4:
    add     rsp, 28h
    pop     rbx
    pop     rbp
    retn
sub_400F09 endp

