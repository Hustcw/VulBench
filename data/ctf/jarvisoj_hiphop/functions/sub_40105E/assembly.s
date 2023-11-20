sub_40105E proc
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
    ja      short def_4010AA; jumptable 00000000004010AA default case
    mov     eax, [rbp+var_4]
    mov     rax, ds:jpt_4010AA[rax*8]
def_4010AA:
    jmp     rax; switch jump
    mov     rax, [rbp+var_18]; jumptable 00000000004010AA case 0
    mov     qword ptr [rax], 0Ah
    mov     rax, [rbp+var_18]; jumptable 00000000004010AA case 1
    mov     qword ptr [rax], 0FFFFh
    mov     rax, [rbp+var_18]; jumptable 00000000004010AA case 2
    mov     qword ptr [rax], 0FFFFFFFh
    mov     rax, [rbp+var_18]; jumptable 00000000004010AA case 3
    mov     esi, 0FFFFFFFFh
    mov     [rax], rsi
    mov     rax, [rbp+var_18]; jumptable 00000000004010AA case 4
    mov     rdi, 0FFFFFFFFFh
    mov     [rax], rdi
    nop; jumptable 00000000004010AA default case
    leave
    retn
sub_40105E endp

