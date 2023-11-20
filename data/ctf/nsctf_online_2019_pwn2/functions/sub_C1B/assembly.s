sub_C1B proc
    push    rbp
    mov     rbp, rsp
    lea     rdi, aInputTheNote; "Input the note"
    call    puts
    lea     rax, qword_202090
    mov     rax, [rax]
    test    rax, rax
    jz      short loc_C5D
    lea     rax, unk_202040
    mov     eax, [rax]
    movsxd  rdx, eax; nbytes
    lea     rax, qword_202090
    mov     rax, [rax]
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
loc_C5D:
    nop
    pop     rbp
    retn
sub_C1B endp

