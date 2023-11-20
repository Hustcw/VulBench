sub_400E40 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_18], rdi
    call    _rand
    mov     ecx, eax
    mov     edx, 66666667h
    mov     eax, ecx
    imul    edx
    sar     edx, 1
    mov     eax, ecx
    sar     eax, 1Fh
    sub     edx, eax
    mov     eax, edx
    mov     [rbp+var_4], eax
    mov     edx, [rbp+var_4]
    mov     eax, edx
    shl     eax, 2
    add     eax, edx
    sub     ecx, eax
    mov     eax, ecx
    mov     [rbp+var_4], eax
    cmp     [rbp+var_4], 4; switch 5 cases
    ja      short def_400E8C; jumptable 0000000000400E8C default case
    mov     eax, [rbp+var_4]
    mov     rax, ds:jpt_400E8C[rax*8]
def_400E8C:
    jmp     rax; switch jump
    mov     rax, [rbp+var_18]; jumptable 0000000000400E8C case 0
    mov     qword ptr [rax], 1
    mov     rax, [rbp+var_18]; jumptable 0000000000400E8C case 1
    mov     qword ptr [rax], 0Ah
    mov     rax, [rbp+var_18]; jumptable 0000000000400E8C case 2
    mov     qword ptr [rax], 14h
    mov     rax, [rbp+var_18]; jumptable 0000000000400E8C case 3
    mov     qword ptr [rax], 64h ; 'd'
    mov     rax, [rbp+var_18]; jumptable 0000000000400E8C case 4
    mov     qword ptr [rax], 0C8h
    nop; jumptable 0000000000400E8C default case
    leave
    retn
sub_400E40 endp

