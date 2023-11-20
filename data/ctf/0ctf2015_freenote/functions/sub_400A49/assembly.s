sub_400A49 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     edi, 1810h; size
    call    _malloc
    mov     cs:qword_6020A8, rax
    mov     rax, cs:qword_6020A8
    mov     qword ptr [rax], 100h
    mov     rax, cs:qword_6020A8
    mov     qword ptr [rax+8], 0
    mov     [rbp+var_4], 0
    jmp     short loc_400B05
loc_400A88:
    mov     rcx, cs:qword_6020A8
    mov     eax, [rbp+var_4]
    movsxd  rdx, eax
    mov     rax, rdx
    add     rax, rax
    add     rax, rdx
    shl     rax, 3
    add     rax, rcx
    add     rax, 10h
    mov     qword ptr [rax], 0
    mov     rcx, cs:qword_6020A8
    mov     eax, [rbp+var_4]
    movsxd  rdx, eax
    mov     rax, rdx
    add     rax, rax
    add     rax, rdx
    shl     rax, 3
    add     rax, rcx
    add     rax, 10h
    mov     qword ptr [rax+8], 0
    mov     rcx, cs:qword_6020A8
    mov     eax, [rbp+var_4]
    movsxd  rdx, eax
    mov     rax, rdx
    add     rax, rax
    add     rax, rdx
    shl     rax, 3
    add     rax, rcx
    add     rax, 20h ; ' '
    mov     qword ptr [rax], 0
    add     [rbp+var_4], 1
loc_400B05:
    cmp     [rbp+var_4], 0FFh
    jle     loc_400A88
    leave
    retn
sub_400A49 endp

