sub_400E02 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 130h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rax, [rbp+s]
    mov     edx, 10Ah; n
    mov     esi, 0; c
    mov     rdi, rax; s
    call    _memset
    mov     edi, offset aPleaseEnterThe_1; "Please enter the index: "
    call    sub_400C52
    mov     eax, 0
    call    sub_400C90
    mov     [rbp+var_124], eax
    cmp     [rbp+var_124], 0
    js      loc_400EF2
    cmp     [rbp+var_124], 0Fh
    jg      loc_400EF2
    mov     eax, [rbp+var_124]
    cdqe
    mov     rax, ds:ptr[rax*8]
    test    rax, rax
    jz      short loc_400EF2
    mov     eax, [rbp+var_124]
    cdqe
    mov     rax, ds:ptr[rax*8]
    add     rax, 8
    mov     rsi, [rax]
    mov     eax, [rbp+var_124]
    cdqe
    mov     rax, ds:ptr[rax*8]
    mov     rcx, [rax]
    mov     eax, [rbp+var_124]
    cdqe
    mov     rax, ds:ptr[rax*8]
    lea     rdx, [rax+10h]
    lea     rax, [rbp+s]
    mov     r9, rsi
    mov     r8, rcx
    mov     rcx, rdx
    mov     edx, offset format; "name: %s\ncount: %lu\ntime: %lu"
    mov     esi, 100h; maxlen
    mov     rdi, rax; s
    mov     eax, 0
    call    _snprintf
    lea     rax, [rbp+s]
    mov     rdi, rax
    call    sub_400C00
loc_400EF2:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_400F07
    call    ___stack_chk_fail
locret_400F07:
    leave
    retn
sub_400E02 endp

