main proc
    push    rbp
    push    rbx
    xor     eax, eax
    sub     rsp, 8
    call    sub_13C0
    call    sub_1460
    lea     rbx, unk_205B40
    lea     rbp, unk_204040
loc_1020:
    call    sub_15A0
    call    sub_1790
    call    sub_20E0
    mov     eax, [rbx]
    test    eax, eax
    jle     short loc_1020
    nop     dword ptr [rax]
loc_1038:
    sub     eax, 1
    cdqe
    mov     rdi, [rbp+rax*8+0]; ptr
    call    free
    mov     eax, [rbx]
    sub     eax, 1
    movsxd  rdx, eax
    test    eax, eax
    mov     [rbx], eax
    mov     qword ptr [rbp+rdx*8+0], 0
    jg      short loc_1038
    jmp     short loc_1020
main endp

