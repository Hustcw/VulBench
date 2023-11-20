sub_400FCB proc
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
    mov     [rbp+var_124], 0
    jmp     short loc_40107D
loc_40100A:
    mov     eax, [rbp+var_124]
    cdqe
    mov     rax, ds:qword_602180[rax*8]
    test    rax, rax
    jz      short loc_401076
    mov     eax, [rbp+var_124]
    cdqe
    mov     rcx, ds:qword_602180[rax*8]
    mov     edx, [rbp+var_124]
    lea     rax, [rbp+s]
    mov     r8, rcx
    mov     ecx, edx
    mov     edx, offset aDLu; "%d\t->\t%lu"
    mov     esi, 100h; maxlen
    mov     rdi, rax; s
    mov     eax, 0
    call    _snprintf
    lea     rax, [rbp+s]
    mov     rdi, rax
    call    sub_400C00
    mov     rax, cs:stdout
    mov     rdi, rax; stream
    call    _fflush
loc_401076:
    add     [rbp+var_124], 1
loc_40107D:
    cmp     [rbp+var_124], 0Fh
    jle     short loc_40100A
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_40109B
    call    ___stack_chk_fail
locret_40109B:
    leave
    retn
sub_400FCB endp

